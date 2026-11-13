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

`user/config/lv_conf.h` 使用 32 KiB LVGL 内存池和简单主题。受 208 KiB 程序 Flash 区域限制，
当前只启用标签等基础功能，关闭了多数控件和非 RGB565 软件渲染格式。
添加界面时可按需启用控件，并重新检查链接结果是否仍处于程序区内。
仪表使用直接从 Noto Sans SC 栅格化的字体：58 号加粗速度数字、24 号电气数值、
14 号半粗正文。速度字模不再由较小字模缩放，数值文字采用纯黑色。
默认字体为 14 号正文，旧的 Montserrat 48 字体保留在源码中但不再被本界面链接使用。
标题使用 Noto Sans SC Medium 的 14 号精简字体，仅包含标题所需的中文和空格，
如需其他中文需另外添加字形；14 号正文字体包含温度所需的 `°`。字体位图直接放在 Flash，节省 RAM。
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
`user/config/lv_conf.h` 中重新启用。圆弧、圆角等复杂软件绘制能力仍然保留。

## 演示数据及后续对接

ADC 每 1 ms 读取，ADC 和 VESC 数据每 100 ms 更新界面。
车 Logo 的锁定状态与 PPM 采用同一数据源：锁定红色、解锁黑色；启动默认锁定，状态接口见 `user/CPLD_ADC.md`。
速度由 VESC 串口读取的 ERPM 按 `user/config/vesc_config.h` 的电机极对数、轮周长和传动比换算；离线或参数不完整时显示 `--`。电压和电流取 VESC 输入端遥测，功率根据同一帧的输入电压和电流计算；VESC 离线时显示 `--`。左侧进度条分别显示 CPLD 的 ADC1 刹车及 ADC2 油门，右侧显示 `ppm_task.c` 中独立任务根据两路 ADC 计算的 PPM 值；
ADC 尚无有效结果时显示 `--`。接口及寄存器说明见 `user/CPLD_ADC.md`。
`DashboardData` 字段定义在 `dashboard.h`：速度单位 km/h、电池和占空比单位为百分比；
速度为有符号 `int16_t`，负值表示倒车，速度圆弧按绝对值显示（圆弧范围 0～99）。
`voltage_tenths_v`、`current_tenths_a` 分别以 0.1 V、0.1 A 为单位，`power_w` 为瓦特。
电流字段为 `int16_t`，功率字段为 `int32_t`；约定放电/驱动为正，充电/回收为负。
电流显示保留一位小数，支持 `-0.5 A` 这样的负数，功率显示支持负整数。
输入功率使用电流的原始 0.01 A 精度计算，再四舍五入到整数瓦。

电池图标和控制器温度放在同一个顶部容器中，温度替代原来的电量百分比文字。
`controller_temperature_c` 为有符号 `int16_t`，单位为整数摄氏度，例如 `35` 显示为 `35°C`。
当前温度来自 VESC 的 MOS 温度，按整数摄氏度显示；串口离线时显示 `--°C`。
电池图标仍使用 `battery_percent` 表示电量，内部使用 5 个长方形格子，
每格对应约 20% 电量，有电时向上取整显示格数，0% 时全部为空格。
绿色表示正常电量，灰色表示空格；格子对外框保持对称留白。
电量严格低于 20% 时，外框、端子和填充变红；20% 起恢复正常颜色。温度文字不受电量影响。
颜色在 `user/config/dashboard_config.h` 中独立配置：`COLOR_VOLTAGE` 用于电压卡片，
`COLOR_THROTTLE` 用于油门进度条，`COLOR_BATTERY` 用于正常电量格子，
`COLOR_BATTERY_LOW` 用于低电量提示，修改其中一项不会影响其他项。
`user/battery.h` 按已确认的 48 V、13 串 LiPo、满电 54.6 V 配置。
满电参考为 13×4.2 V=54.6 V；单节 3.7 V 标称、4.2 V 满电的背景说明见
[Adafruit LiPo 电压说明](https://learn.adafruit.com/li-ion-and-lipoly-batteries/voltages)。
`Battery_EstimatePercent()` 使用 `battery.c` 中的分段曲线估算显示电量，
该曲线是待校准的 UI 近似，不是实测容量曲线，也不参与任何充放电保护。
当前示例曲线在 48.1 V 显示 20%，低于该值进入红色区域；负载压降、温度等会影响估算。
电量根据 VESC 输入电压估算；串口离线时电池图标变灰，避免将过期数据误认为有效电量。
实际数据接入后优先使用 BMS 提供的 SOC，或按电芯厂家曲线校准显示估算。

接入其他实际数据时，在 LVGL 任务中读取线程安全的消息或数据快照，填充 `DashboardData`
并调用 `Dashboard_Refresh()`。其他任务不要直接调用 LVGL API，
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
