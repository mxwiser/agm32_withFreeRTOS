# VESC 串口

UART0 使用 115200、8N1，连接 J1：主控 TX 接 VESC RX，主控 RX 接 VESC TX，并共地。波特率及周期在 `user/config/vesc_config.h` 中配置。UART0 不再输出调试日志，调试可使用 SWD。

VESC 任务周期性发送选择性状态读取请求，并校验应答帧和 CRC；通过 `Vesc_GetSnapshot()` 可读取 MOS 管温度、输入电流、电气转速（`telemetry.electrical_rpm`）、输入电压及在线状态。`vesc_status`、`vesc_uart_rx_errors` 和 `vesc_uart_rx_overflows` 可供调试器查看。未收到有效应答或超过离线超时时间时 `online` 为 false。

仪表盘每 100 ms 从线程安全快照读取 ERPM 并换算为有符号车速，单位 km/h；离线或换算参数不完整时显示 `--`，速度弧归零。计算公式：`车速 = ERPM ÷ 极对数 ÷ (电机转数 / 车轮转数) × 车轮周长（mm）× 60 ÷ 1000000`，结果四舍五入到整数。当前按 20 个磁极、假设轮周长 1500 mm、假设电机转 30 圈车轮转 1 圈计算；实测后在 `user/config/vesc_config.h` 修改。

电压和电流取 VESC 输入端遥测；电流为有符号数，界面保留一位小数。功率使用同一帧电压和完整精度电流相乘，四舍五入为整数瓦。电池图标根据输入电压估算电量；这不是 BMS 实测 SOC。顶部温度取 VESC 报文的 MOS 温度，四舍五入到整数摄氏度。VESC 离线时这些数值显示 `--`，电池图标变灰。

PPM 代码位于 `user/ppm/`。已为 ADC3 / PIN_17 准备 GPTIMER0 脉冲输出和开机测试代码，参数位于 `user/config/ppm_config.h`。当前配置在中位等待 2 秒、确认 VESC 串口在线后，输出 25% 持续 10 秒，然后回中位并锁车；离线或锁车会中止测试。测试期间启用看门狗，看门狗复位后跳过自动测试。该输出与看门狗尚未经实物验证。由于变更了管脚映射，必须同时更新 FPGA LOGIC 和 MCU 程序；只烧 MCU 不会更新管脚映射。测试使用 15% 的 VESC 输入死区，VESC 处理后控制量会低于输入的 25%。
