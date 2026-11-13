# ST7789（AGRV2K_303 L48）

默认 320×240、RGB565、横屏（方向 1）、RGB 顺序，通信使用 SPI0 + DMA 通道 6。
`st7789.c` 的初始化表来自项目内 `2.4TFTST7789参考代码/2.4TFT7P.C` 的 `TFT_init()`：
保留电源、Porch、帧率、Gamma、`COLMOD=0x05` 和 `INVOFF=0x20`；`MADCTL=0x60` 设置横屏。
参考代码的 7 针串转并口发送函数没有移植；按本板 J6 的 8 针 SPI 接口实现。
窗口末地址使用包含式末坐标：默认横屏为 x `0..319`、y `0..239`。

| J6 | 信号 | L48 物理引脚 | SDK 配置 |
|---|---|---|---|
| 3 | SCL | 28 / PB15 | SPI0_SCK，GPIO4 bit 5 |
| 4 | SDA | 29 / PA8 | SPI0_SI_IO0，GPIO0 bit 0 |
| 5 | RES | 30 / PA9 | GPIO5 bit 1 |
| 6 | DC | 31 / PA10 | GPIO5 bit 2 |
| 7 | CS | 32 / PA11 | GPIO4 bit 6，软件控制片选 |
| 8 | BLK | 33 / PA12 | GPIO5 bit 3，高有效 |

MCU 主频在 `example_board.ve` 中设为 200 MHz；改频率需重编并烧录 LOGIC 和 MCU。
SPI 时钟上限仍为 50 MHz，按实际 PCLK 和偶数分频计算，当前为 50 MHz（200 MHz / 4），模式 0。
50 MHz 是本屏的实板性能配置，超过所参考 ST7789V 手册的保守 66 ns 写周期指标；
更换屏幕或连接线后若不稳定，可将 `st7789_config.h` 的 `LCD_SPI_MAX_HZ` 降为 25 MHz 或 12.5 MHz。
SCK、SDA 使用硬件复用，CS 使用 GPIO 保持整个像素传输期间有效。
驱动只占用 1 KiB 静态像素缓冲；无需申请 153,600 字节整屏显存。
DMA 通道 6 和 SPI0 由 LCD 独占，不要同时运行原来的 SPI Flash 测试。

## 调用

在 `board_init()` 后初始化，从一个 LCD 任务调用；多个任务调用时，应用需用同一个互斥锁保护全部 LCD 操作。
所有绘图函数都是阻塞同步传输，返回时 SPI/DMA 已完成，可安全复用调用者的图像缓冲。
初始化会先关闭背光、复位、配置参数、清黑屏，再开启显示和背光。
像素数据均通过 DMA 发送（包括不足 4 字节的尾包）；命令与地址仍由 CPU 发送。
先用 DMA 将首个像素字写入 SPI 阶段寄存器，再用 SPI 请求驱动 DMA 发送剩余数据，
避免每块重复发送首字。该全 DMA 方案仍需在实板验证不同颜色、短包和分块边界。

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

当前 `main` 创建 LED 和 LVGL 两个应用任务，默认显示 LVGL 测试文字，见
[`LVGL 线程说明`](../LVGL.md)。`lcd_demo.c` 保留了每秒依次刷红、绿、蓝的测试任务；
如需运行它，应在 `main` 中替换 LVGL 任务，不能同时运行两个屏幕任务。
调试器可观察 `lcd_init_status`、`lcd_readback_status`、`lcd_sync_status`、
`lcd_last_status`、`lcd_frame_count`、`lcd_fill_time_ms`、`lcd_cpu_hz`、`lcd_spi_hz`。
颜色保留 1 秒用于观察，这个停留时间与实际刷一帧所花的时间不同。

本板实测：100 MHz MCU / 12.5 MHz SPI 时整屏约 99 ms；200 MHz MCU / 50 MHz SPI 时约 25 ms；
之前 240 MHz MCU / 40 MHz SPI 时约 31 ms；当前 200 MHz / 50 MHz 配置的实际刷新时间需重新测量。
200 MHz / 50 MHz 组合纯整屏传输约 40 帧/秒；当前组合约 32 帧/秒，演示的颜色停留延时不计入这些数值。
50 MHz 下红、绿、蓝已通过实板显示确认，换色明显加快。

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
当前 40 MHz SPI 仅传输就需要约 30.7 ms（实际更长）；厂商 `C6=0x01` 标注的面板刷新约为 111 Hz。
完整像素传输跨越多个面板扫描周期，不能声称一次读寄存器后整屏就无撕裂。
严格防撕裂还需按区域传输时间安排写入窗口，或提供 TE/更高带宽并调整面板刷新参数。
本驱动保留厂商帧率，不通过固定延时伪造帧同步。

当前实板探测结果为 `lcd_readback_status=5`、`lcd_sync_status=5`，尚未获得有效 SDA 回读。
再次用调试器调用半双工 SPI，读取 MADCTL (`0x0b`)、COLMOD (`0x0c`)、
ID (`0x04`) 和扫描行 (`0x45`)，尝试不同 dummy 时钟，返回均为 `ff ff ff ff`。
这些结果说明当前回读不可用，不能单凭此断定屏幕内部的接口选择或模块电路连接方式。
对照 `st7789-without-te-demo-master` 后增加了 `LCD_READ_MODE3` 配置，默认采用该例程的
模式 3 回读时序；像素写入仍为硬件 SPI 模式 0，时钟随主频按配置的上限分频。
模式 3 实板再次读取上述寄存器，以及不跳过 dummy 的 GSCAN 原始 4 字节，结果仍全部为 `0xff`。
该参考例程用单线双向 MOSI、3 字节接收及其特定的位重组（`data[1] << 1 | !!data[2]`），
设置 `C6=0x1e`，等待第 150 行后写 `200×280` 区域。不能将它的位重组直接用于无效的全 `0xff` 数据，
否则会得到假的 511 行。当前继续保留本屏厂商初始化参数及有限超时，不启用未验证的同步。
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
