# 项目配置

可调的应用宏按功能放在本目录，宏旁有中文说明。修改后需要重新编译并烧录 MCU。

- `adc_config.h`：ADC1 刹车、ADC2 油门的标定范围及各自卡尔曼 Q、R。当前 1000～2000 只是示例，须按实际测量校准。
- `ppm_config.h`：台架用油门/刹车混合权重、脉宽、中位等待时间与故障超时。固定开机输出测试已从源码移除；新的油门控制仅供架空车轮测试，详见 `user/CPLD_ADC.md`。
- `vesc_config.h`：VESC 的 UART 波特率、请求周期、超时和接收缓冲区；车速参数在 VESC Tool 中配置。
- `battery_config.h`：电池图标低电量变红阈值；电量读取自 VESC，不用于电池保护。
- `dashboard_config.h`：仪表盘颜色；刹车进度条为 `COLOR_RED`。
- `task_config.h`：ADC、界面和指示灯更新周期。
- `buzzer_config.h`：蜂鸣器频率及开机提示音时长。
- `lcd_geometry.h`、`st7789_config.h`：屏幕分辨率、管脚、SPI 和读回设置。
- `lv_conf.h`、`FreeRTOSConfig.h`：LVGL 与 FreeRTOS 配置。

通信协议和驱动内部固定常量仍在各自代码中；FPGA 引脚映射、主频及构建配置由 `example_board.ve`、`platformio.ini` 等工程文件管理，不能只修改这里的宏。修改管脚或频率前需检查硬件及逻辑配置。
