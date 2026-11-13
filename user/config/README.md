# 项目配置

可调的应用宏按功能放在本目录，宏旁有中文说明。修改后需要重新编译并烧录 MCU。

- `adc_config.h`：ADC1 刹车、ADC2 油门的标定范围及各自卡尔曼 Q、R。当前 1000～2000 只是示例，须按实际测量校准。
- `ppm_config.h`：油门与刹车的混合权重、计算周期、VESC 脉宽以及开机测试配置。当前配置启用开机测试，先输出 2 秒中位，再输出 25% 持续 10 秒，然后回中位并锁车。VESC 离线时跳过或中止，测试期间启用看门狗；看门狗复位后跳过自动测试。测试代码尚未经实物验证。将 `PPM_TEST_ENABLE` 设为 0 可关闭自动测试。
- `vesc_config.h`：VESC 的 UART 波特率、请求周期、超时、接收缓冲区，以及 ERPM 换算车速所需的极对数、轮周长、传动比。
- `battery_config.h`：电池串数、显示估算电压及低电量阈值；电量估算不用于电池保护。
- `dashboard_config.h`：仪表盘颜色；刹车进度条为 `COLOR_RED`。
- `task_config.h`：ADC、界面和指示灯更新周期。
- `buzzer_config.h`：蜂鸣器频率及开机提示音时长。
- `lcd_geometry.h`、`st7789_config.h`：屏幕分辨率、管脚、SPI 和读回设置。
- `lv_conf.h`、`FreeRTOSConfig.h`：LVGL 与 FreeRTOS 配置。

通信协议和驱动内部固定常量仍在各自代码中；FPGA 引脚映射、主频及构建配置由 `example_board.ve`、`platformio.ini` 等工程文件管理，不能只修改这里的宏。修改管脚或频率前需检查硬件及逻辑配置。
