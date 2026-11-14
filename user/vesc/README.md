# VESC 串口

UART0 使用 115200、8N1，连接 J1：主控 TX 接 VESC RX，主控 RX 接 VESC TX，并共地。波特率及周期在 `user/config/vesc_config.h` 中配置。UART0 不再输出调试日志，调试可使用 SWD。

VESC 任务周期性发送选择性状态读取请求，并校验应答帧和 CRC；通过 `Vesc_GetSnapshot()` 可读取 MOS 管温度、输入电流、电气转速（`telemetry.electrical_rpm`）、输入电压及在线状态。`vesc_status`、`vesc_uart_rx_errors` 和 `vesc_uart_rx_overflows` 可供调试器查看。未收到有效应答或超过离线超时时间时 `online` 为 false。

仪表盘直接读取 VESC 的有符号车速，以 0.001 m/s 接收并换算、四舍五入为整数 km/h；VESC 离线或车速应答超过 500 ms 未更新时显示 `--`，速度弧归零。需要在 VESC Tool 的车辆设置中填写实际电机磁极数、总传动比和车轮有效滚动直径。之前提出的 20 磁极、30:1、轮周长 1500 mm 是待确认的实车参数，不能当作已测量值。如果飞轮使滑行时电机不随车轮转，VESC 基于电机转速计算的速度不能代表滑行车速。

电压和电流取 VESC 输入端遥测；电流为有符号数，界面保留一位小数。功率使用同一帧电压和完整精度电流相乘，四舍五入为整数瓦。顶部温度取 VESC 报文的 MOS 温度，四舍五入到整数摄氏度。VESC 离线时这些数值显示 `--`，电池图标变灰。

车速和电量通过同一个 `COMM_GET_VALUES_SETUP_SELECTIVE` 请求读取，正常每 100 ms 请求一次；电量比例按 1000 倍传输，例如 750 表示 75%。显示百分比舍去小数并限制在 0～100。若电量应答超过 1500 ms 未更新，或 VESC 遥测离线，图标变灰；可通过 SWD 检查 `vesc_status.speed_mm_per_second`、`speed_valid`、`battery_level_thousandths`、`battery_percent`、`battery_valid`、`setup_packets_ok` 和 `setup_last_update_tick`。周期和超时见 `user/config/vesc_config.h`。协议格式已做软件测试，实际 VESC 的兼容性仍需现场验证。

VESC 电量一般依据其设置及电压估算，不等于 BMS 实测 SOC，也不是保护阈值。必须在 VESC Tool 中正确配置电池类型、串数和容量，换电池后同步更新；负载压降、温度和电芯差异会影响显示。

PPM 代码位于 `user/ppm/`。ADC3 / PIN_17 使用 GPTIMER0 输出脉冲，参数位于 `user/config/ppm_config.h`。当前配置在每次正常启动时先等待 2 秒中位、确认 VESC 串口在线，再输出 25% 持续 10 秒，然后回中位并锁车；离线或锁车会中止测试。测试期间启用看门狗，看门狗复位后跳过自动测试。将 `PPM_TEST_ENABLE` 设为 0 并重新烧录可关闭开机测试。

中位脉冲已通过 VESC 读回约 1.503 ms，看门狗复位后的中位输出已验证；一次 25% 测试记录到峰值 42201 ERPM，计时 10000 个 1 ms 节拍后回到 1.500 ms 并锁车。测试使用 15% 的 VESC 输入死区，VESC 处理后控制量会低于输入的 25%。更改 ADC3 管脚映射时，必须同时更新 FPGA LOGIC 和 MCU 程序；只烧 MCU 不会更新管脚映射。
