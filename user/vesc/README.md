# VESC 串口

UART0 使用 115200、8N1，连接 J1：主控 TX 接 VESC RX，主控 RX 接 VESC TX，并共地。波特率及周期在 `user/config/vesc_config.h` 中配置。UART0 不再输出调试日志，调试可使用 SWD。

VESC 任务周期性发送选择性状态读取请求，并校验应答帧和 CRC；通过 `Vesc_GetSnapshot()` 可读取 MOS 管温度、输入电流、电气转速（`telemetry.electrical_rpm`）、输入电压及在线状态。`vesc_status`、`vesc_uart_rx_errors` 和 `vesc_uart_rx_overflows` 可供调试器查看。未收到有效应答或超过离线超时时间时 `online` 为 false。

仪表盘每 100 ms 从线程安全快照读取 ERPM 并换算为有符号车速，单位 km/h；离线或换算参数不完整时显示 `--`，速度弧归零。计算公式：`车速 = ERPM ÷ 极对数 ÷ (电机转数 / 车轮转数) × 车轮周长（mm）× 60 ÷ 1000000`，结果四舍五入到整数。当前按 20 个磁极、假设轮周长 1500 mm、假设电机转 30 圈车轮转 1 圈计算；实测后在 `user/config/vesc_config.h` 修改。

电压和电流取 VESC 输入端遥测；电流为有符号数，界面保留一位小数。功率使用同一帧电压和完整精度电流相乘，四舍五入为整数瓦。顶部温度取 VESC 报文的 MOS 温度，四舍五入到整数摄氏度。VESC 离线时这些数值显示 `--`，电池图标变灰。

电池图标读取 VESC 电机配置的电池类型和串数，并用输入电压估算电量；必须先在 VESC Tool 中正确配置，换电池后也要更新 VESC 配置。当前支持 VESC 配置类型 0 锂离子、1 磷酸铁锂和 2 铅酸，串数 1～32；配置格式仅支持已识别签名的 5.02、5.03、6.00 和 7.01。正常每 10 秒刷新配置，失败后重试；配置无效、过期、类型不支持或 VESC 离线时图标变灰。可通过 SWD 检查 `vesc_status.config_signature`、`config_packets_ok`、`battery_type`、`battery_cells` 和 `battery_config_valid`。配置有效性不是对实物电池的识别或校验。

锂离子使用原有近似分段曲线；磷酸铁锂和铅酸使用 `user/config/battery_config.h` 中的单节电压范围线性估算。尤其磷酸铁锂电压平台平坦，负载、温度及电芯差异会造成较大误差；这些值不是 BMS 实测 SOC，也不是保护阈值。

PPM 代码位于 `user/ppm/`。ADC3 / PIN_17 使用 GPTIMER0 输出脉冲，参数位于 `user/config/ppm_config.h`。当前配置在每次正常启动时先等待 2 秒中位、确认 VESC 串口在线，再输出 25% 持续 10 秒，然后回中位并锁车；离线或锁车会中止测试。测试期间启用看门狗，看门狗复位后跳过自动测试。将 `PPM_TEST_ENABLE` 设为 0 并重新烧录可关闭开机测试。

中位脉冲已通过 VESC 读回约 1.503 ms，看门狗复位后的中位输出已验证；一次 25% 测试记录到峰值 42201 ERPM，计时 10000 个 1 ms 节拍后回到 1.500 ms 并锁车。测试使用 15% 的 VESC 输入死区，VESC 处理后控制量会低于输入的 25%。更改 ADC3 管脚映射时，必须同时更新 FPGA LOGIC 和 MCU 程序；只烧 MCU 不会更新管脚映射。
