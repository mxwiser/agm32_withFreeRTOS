# ST7789（AGRV2K_303 L48）

默认 240×320、RGB565、竖屏、RGB 顺序，通信使用 SPI0 + DMA 通道 6。
`st7789.c` 的初始化表来自项目内 `2.4TFTST7789参考代码/2.4TFT7P.C` 的 `TFT_init()`：
保留电源、Porch、帧率、Gamma、`COLMOD=0x05`、`MADCTL=0x00` 和 `INVOFF=0x20`。
参考代码的 7 针串转并口发送函数没有移植；按本板 J6 的 8 针 SPI 接口实现。
窗口末地址修正为包含式末坐标：竖屏 `0..239`、`0..319`。

| J6 | 信号 | L48 物理引脚 | SDK 配置 |
|---|---|---|---|
| 3 | SCL | 28 / PB15 | SPI0_SCK，GPIO4 bit 5 |
| 4 | SDA | 29 / PA8 | SPI0_SI_IO0，GPIO0 bit 0 |
| 5 | RES | 30 / PA9 | GPIO5 bit 1 |
| 6 | DC | 31 / PA10 | GPIO5 bit 2 |
| 7 | CS | 32 / PA11 | GPIO4 bit 6，软件控制片选 |
| 8 | BLK | 33 / PA12 | GPIO5 bit 3，高有效 |

MCU 主频在 `example_board.ve` 中设为 200 MHz；改频率需重编并烧录 LOGIC 和 MCU。
SPI 时钟按实际 PCLK 计算，当前为 50 MHz（200 MHz / 4），模式 0。
50 MHz 是本屏的实板性能配置，超过所参考 ST7789V 手册的保守 66 ns 写周期指标；
更换屏幕或连接线后若不稳定，可将 `st7789_config.h` 的 `LCD_SPI_MAX_HZ` 降为 25 MHz 或 12.5 MHz。
SCK、SDA 使用硬件复用，CS 使用 GPIO 保持整个像素传输期间有效。
驱动只占用 1 KiB 静态像素缓冲；无需申请 153,600 字节整屏显存。
DMA 通道 6 和 SPI0 由 LCD 独占，不要同时运行原来的 SPI Flash 测试。

## 调用

在 `board_init()` 后初始化，从一个 LCD 任务调用；多个任务调用时，应用需用同一个互斥锁保护全部 LCD 操作。
所有绘图函数都是阻塞同步传输，返回时 SPI/DMA 已完成，可安全复用调用者的图像缓冲。
初始化会先关闭背光、复位、配置参数、清黑屏，再开启显示和背光。

```c
#include "st7789.h"

ST7789_Status result = ST7789_Init();
if (result == ST7789_OK) {
    result = ST7789_FillScreen(ST7789_RED);
}
// 坐标参数是 x、y、宽、高，必须完全位于当前方向的屏幕范围内。
result = ST7789_FillRect(20, 30, 100, 60, ST7789_RGB565(0, 255, 0));
// uint16_t image[40 * 20]：逐行 RGB565 数值，调用者无需交换高低字节。
// result = ST7789_DrawRGB565(0, 0, 40, 20, image);
// result = ST7789_SetRotation(1); // 横屏 320×240；0/1/2/3 对应四个方向。
```

当前 `main` 创建 LED 和 LCD 两个应用任务。`lcd_demo.c` 每秒依次刷红、绿、蓝。
调试器可观察 `lcd_init_status`、`lcd_readback_status`、`lcd_sync_status`、
`lcd_last_status`、`lcd_frame_count`、`lcd_fill_time_ms`、`lcd_cpu_hz`、`lcd_spi_hz`。
颜色保留 1 秒用于观察，这个停留时间与实际刷一帧所花的时间不同。
测试完后，可将 `LCD_ColorTestTask` 的循环替换为界面绘制代码。

本板实测：100 MHz MCU / 12.5 MHz SPI 时整屏约 99 ms；200 MHz MCU / 50 MHz SPI 时约 25 ms。
后者纯整屏传输约 40 帧/秒，演示的颜色停留延时不计入这个数值。
用户已确认 50 MHz 下红、绿、蓝颜色正常，换色明显加快。

## 帧同步与撕裂限制

ST7789 的 `GSCAN (0x45)` 返回当前扫描行，TE 输出也可用于帧同步。
但是 J6 没有引出 TE 或独立 SDO/MISO，8 针接口本身不能保证可读：
仅当屏幕内部设置为双向 SDA 串行接口 I 时，才能沿 SDA 回读。
接口 II 或只写模块不能仅靠软件增加回读能力。
依据：[Sitronix ST7789V 数据手册](https://support.newhavendisplay.com/hc/en-us/article_attachments/4414880310423)，
6.2、8.4、8.15、9.1.36 节。

`ST7789_ProbeReadback()` 修改并恢复 MADCTL 的已知值，检查两次结果和 RGB565 格式，
避免把悬空 SDA 读出的全 0/全 1 当作有效回读。写像素始终使用硬件 SPI；
因为 MCU 的单线硬件接收固定走 SO_IO1，回读时暂时用 GPIO 实现同一组线的半双工 SPI，完成后恢复硬件复用。
`st7789_config.h` 中 `LCD_TRY_SDA_READ=0` 可关闭回读尝试。
`LCD_SCANLINE_DUMMY_BITS` 独立配置 GSCAN 的 dummy 时钟，默认按其 dummy read 丢弃 8 位。

```c
if (ST7789_ProbeReadback() == ST7789_OK) {
    uint16_t line;
    ST7789_Status result = ST7789_ReadScanline(&line);
    result = ST7789_WaitFrameStart(100); // 等扫描行回绕，超时 100 ms
    if (result == ST7789_OK) {
        result = ST7789_FillRect(0, 0, 40, 20, ST7789_BLUE);
    }
    // 等待帧起点后整屏填色的组合接口：
    // result = ST7789_FillScreenSync(ST7789_GREEN, 100);
}
```

回读失败返回 `ST7789_READ_UNSUPPORTED`；扫描行不变化或无回绕返回 `ST7789_TIMEOUT`，
错误时同步填色函数不写入像素。演示任务会在串口报告探测结果，并对不支持同步的屏使用普通填色。

**帧起点对齐不等于保证整屏无撕裂。** 240×320 RGB565 一帧需要 1,228,800 位，
50 MHz SPI 仅传输就需要约 24.6 ms（实际更长）；厂商 `C6=0x01` 标注的面板刷新约为 111 Hz。
完整像素传输跨越多个面板扫描周期，不能声称一次读寄存器后整屏就无撕裂。
严格防撕裂还需按区域传输时间安排写入窗口，或提供 TE/更高带宽并调整面板刷新参数。
本驱动保留厂商帧率，不通过固定延时伪造帧同步。

当前实板探测结果为 `lcd_readback_status=5`、`lcd_sync_status=5`，尚未获得有效 SDA 回读。
因此颜色演示使用普通阻塞填色；帧同步接口已实现，但本屏当前不能验证其工作，也不能保证无撕裂。

状态码：`0=OK`，`1=参数错误`，`2=未初始化`，`3=超时`，`4=SPI/DMA 或回读数据错误`，`5=不支持回读`。

## 验证

Release 和 Debug 均编译通过。主机侧 `tests/lcd/test_st7789.c` 检查像素字节序、
窗口末地址、跨分块的奇数像素尾包、越界拒绝、旋转、读回探测、帧同步超时和错误返回。
用 C11 编译器运行，例如在项目根目录：

```sh
gcc -std=c11 -O2 -Wall -Wextra -Werror -Iuser/lcd user/lcd/st7789.c tests/lcd/test_st7789.c -o .pio/lcd_validation.exe
.pio/lcd_validation.exe
```
