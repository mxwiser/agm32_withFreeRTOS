# LVGL 接入

`main` 启动 `LVGL_Task`，由该 FreeRTOS 任务初始化 ST7789、LVGL 和显示设备，
创建自行车仪表界面，并循环调用 `lv_timer_handler()`。屏幕默认为横屏 320×240，RGB565，
使用 10 行的局部绘图缓冲；刷新经过现有的同步 SPI/DMA 驱动，驱动负责像素字节序转换。
LVGL 时钟使用 `board_millis()`，不依赖其他任务或 FreeRTOS tick hook。
LVGL 创建设备时读取驱动当前宽高；若以后在运行中更改屏幕方向，还需同步更新
LVGL 的显示分辨率并确认绘图缓冲大小。

所有 LVGL API 和 ST7789 操作都应在该任务执行；其他任务可以通过 FreeRTOS 队列
发送数据，由 LVGL 任务更新界面。当前不接入触摸或其他输入设备。
调试器可观察 `lvgl_lcd_status` 和 `lvgl_flush_errors`；刷新错误会计数，
但当前不会自动重新绘制失败的区域。

`user/lv_conf.h` 使用 32 KiB LVGL 内存池和简单主题。受 208 KiB 程序 Flash 区域限制，
当前只启用标签等基础功能，关闭了多数控件和非 RGB565 软件渲染格式。
添加界面时可按需启用控件，并重新检查链接结果是否仍处于程序区内。
仪表使用直接从 Noto Sans SC 栅格化的字体：58 号加粗速度数字、24 号电气数值、
14 号半粗正文。速度字模不再由较小字模缩放，数值文字采用纯黑色。
默认字体为 14 号正文，旧的 Montserrat 48 字体保留在源码中但不再被本界面链接使用。
标题使用 Noto Sans SC Medium 的 14 号精简字体，仅包含标题所需的中文和空格，
如需其他中文或度数符号需另外添加字形。字体位图直接放在 Flash，节省 RAM。
14/24 号字体由 `python tools/make_dashboard_fonts.py` 生成，58 号数字字体由
`python tools/make_speed_font.py` 生成，两者均需要 Pillow，并通过 `tools/font_raster.py`
直接按目标字号生成。默认使用本机安装的 `NotoSansSC-VF.ttf`；可用 `--font` 指定字体文件。
标题字体由 `python tools/make_title_font.py` 生成，默认使用系统中安装的
`NotoSansSC-VF.ttf`，也可通过 `--font` 指定文件。Noto Sans SC 采用 SIL OFL 1.1，
许可文本位于 `user/user_fonts/OFL-1.1.txt`。
仪表环和卡片等图形由 LVGL 绘制；如后续添加图片素材，放在 `user/image`。
界面采用中性浅灰背景、近白色卡片和纯黑文字，右侧卡片省去小型装饰图标，
为标题和数值提供更大的显示区域，以适应当前较高的 LCD 背光。
当前关闭 Flex、Grid 自动布局和 Observer 数据绑定；如界面需要，可以在
`user/lv_conf.h` 中重新启用。圆弧、圆角等复杂软件绘制能力仍然保留。

## 演示数据及后续对接

`lvgl_task.c` 中的 `dashboard_data` 暂时由 `dashboard_demo_timer()` 每 500 ms 更新。
`DashboardData` 字段定义在 `dashboard.h`：速度单位 km/h、电池和占空比单位为百分比；
`voltage_tenths_v`、`current_tenths_a` 分别以 0.1 V、0.1 A 为单位，`power_w` 为瓦特。
演示功率从模拟电压和电流计算。

接入实际数据时，在 LVGL 任务中读取线程安全的消息或数据快照，填充 `DashboardData`
并调用 `Dashboard_Refresh()`，再移除演示定时器。其他任务不要直接调用 LVGL API，
也不要无同步地修改正在被 LVGL 任务读取的数据。

## Flash 分区及烧录

程序区为 `0x80000000..0x80033fff`（208 KiB），压缩 LOGIC 和解压程序使用
`0x80034000..0x8003ffff`（48 KiB）。第一次从旧的未压缩分区升级时，必须一起
烧录新的 MCU 固件、压缩 LOGIC 和启动配置；仅烧录 MCU 程序可能覆盖旧 LOGIC，
无法完成迁移。使用 Release 的 PlatformIO `batch_upload`（Upload Batch）目标，
它会生成并烧录包含以上三项的 batch 文件。启动时间可能增加约 30–50 ms。
旧的未压缩 LOGIC 已备份在 `.pio/logic_uncompressed_backup/`。

由于自定义字体的位图位于 `.flash` 节，当前 PlatformIO 的 RAM 统计会低估，
请以 ELF 的 `.data`、`.sdata`、`.bss` 和 `.sbss` 大小及链接器检查为准。

示例界面可在 `lvgl_task.c` 中修改。若恢复 LCD 纯色测试，应在 `main` 中以
`LCD_ColorTestTask` 替换 LVGL 任务，避免同时操作屏幕。
