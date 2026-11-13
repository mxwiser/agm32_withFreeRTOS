# 改装自行车主控项目交接

记录日期：2026-11-13。此文件用于下次恢复会话；继续工作前检查当前代码、配置和硬件状态，后续修改可能使本记录过时。

## 最重要的当前状态

- **当前已烧录的固件开启了电机开机测试。** `user/config/ppm_config.h` 中 `PPM_TEST_ENABLE=1`：每次正常上电或复位后，先输出 2 秒中位；若 VESC 在线，自动输出 25% PPM 持续 10 秒，然后回中位并锁车。重新上电、烧录或复位前必须考虑电机可能转动，保持车轮架空。要关闭该行为，设为 `0` 并重新编译烧录 MCU；仅修改文件不会改变已烧录固件。
- 本次 25% 测试用户确认电机转动。SWD 记录测试持续 10000 个 1 ms 节拍、峰值 42201 ERPM；结束后定时器回到 1500 μs，车辆锁定。中位脉冲由 VESC 实测约 1.503 ms。测试期间串口掉线或锁车会中止；看门狗超时复位、恢复中位且不自动重试已在中位状态实测。
- **目前物理 PPM 只用于上面的固定开机测试。** ADC 刹车/油门已经能计算、显示归一化 PPM，但该计算值尚未驱动物理 PPM 管脚。不要把已有 UI 计算结果误认为已完成油门控制。
- 用户说油门和刹车器件之后才会到，届时再继续接入、标定及测试。开机测试是临时用途，正式接入前需要处理禁用、输入故障与失效保护、锁车及 VESC 断线行为，并在车轮架空条件下验证。

## 硬件与约束

- 项目为 AGRV2K_303 L48 改装自行车主控，MCU/FPGA 主频 200 MHz；参考资料在 `D:\Projects\FPGA\agm\AG32开发资料汇总（10月20日更新）`。
- `logic/ahb2apb.v` **只读，禁止修改**。用户曾授权编译和烧录；调整 FPGA 管脚或时钟要同时生成并烧录 LOGIC 与 MCU，不能仅烧录 MCU。
- LCD 为 ST7789，横屏 320×240，RGB565，SPI0 + DMA6；当前白天亮色主题，右侧电压/电流/功率，左侧速度与 ADC/PPM，顶部车辆图标、电池和温度。LCD 接线和驱动见 `user/lcd/README.md`；之前 DMA 边界出现过黑点和错位，改动显示驱动时需留意。
- ADC1 = 刹车，J3 / PB1 / PIN_19；ADC2 = 油门，J4 / PB0 / PIN_18；两路由 CPLD 连续采样，MCU 通过 APB 读取。ADC1、ADC2 当前 1000～2000 都是**示例标定值**，不是实测范围。
- J5 的 ADC3 标号对应 PA7 / PIN_17，现已映射 GPTIMER0_CH0，连接 VESC PPM；这里的 ADC3 是板上网络名，当前用作输出。
- J1 七针 UART0：PIN_20 / TX 接 VESC RX，PIN_21 / RX 接 VESC TX，共地；115200、8N1。用户不需要串口调试日志，调试走 SWD。
- 蜂鸣器使用 GPTIMER4_CH0 / PIN_45，2.7 kHz，独立任务，接口为 `buzzerd(duration_ms)`，开机提示音 120 ms。

## 软件与配置

- 可调宏集中在 `user/config/`，有中文注释；目录说明见 `user/config/README.md`。LVGL 配置 `user/config/lv_conf.h`，FreeRTOS 配置 `user/config/FreeRTOSConfig.h`。
- 输入任务每 1 ms 读取 ADC，分别使用 `user/math/` 下的浮点标量卡尔曼滤波；Q/R 和各自量程在 `user/config/adc_config.h`。UI 每 100 ms 取线程安全快照。
- `user/ppm/` 独立任务计算 `clamp(油门 × 1.0 - 刹车 × 1.5, -1, 1)`；界面中间为 0，刹车向左、油门向右。锁车红色、解锁黑色；锁定时快照及测试输出回中位。现有 ADC 有效标志只表示完成过首次采样，**不能检测采样后卡住**，正式控制前需补充可靠的输入新鲜度与故障检测。
- VESC 使用 `PPM and UART`，用户说输入模式为 `Current No Reverse With Brake`；截图中的 PPM 起点/中位/终点为 1.0/1.5/2.0 ms，Input Deadband 为 15%。25% 指的是中位以上的 PPM 归一化指令，不等同 25% 电机占空比；VESC 会应用死区及其控制设置。
- `user/vesc/` 使用 UART0 读取 VESC 输入电压、电流、ERPM 和 MOS 温度；UI 显示电压、电流、由同帧电压电流计算的功率及整数摄氏温度。电流和功率有正负号；VESC 离线时相关项目显示 `--`、电池图标变灰。
- 车速由 ERPM 换算，20 个磁铁按 10 对极配置；**轮周长 1500 mm、传动比电机:车轮 = 30:1 均为用户提出的假设，待实测**。参数在 `user/config/vesc_config.h`。
- 电池显示按 48 V、13 串、满电 54.6 V 配置，低于 20% 显示红色；使用输入电压曲线估算 SOC，不是 BMS 实测或保护阈值。

## 常用验证和文件

- VESC 串口与速度、MOS 温度说明见 `user/vesc/README.md`；ADC/卡尔曼与地址见 `user/CPLD_ADC.md`；界面见 `user/LVGL.md`。
- 平台为 PlatformIO `release`。`build_logic.bat --no-pause` 运行项目原生 FPGA 综合；有自定义逻辑时不要仅凭 PlatformIO `buildlogic` 显示 up to date 就认定 bitstream 已重新生成。确保 FPGA/MCU 版本一致后再使用对应的烧录目标。
- 今天已验证 VESC 遥测正常、LCD 刷新错误计数为 0；具体数值只代表当时现场。继续工作前检查 Git 状态、当前宏和实物连接，保留用户在会话间的改动。
