# CPLD ADC

两路 ADC 在 CPLD 中连续采样，MCU 使用 AHB 到 APB 桥读取最新值。寄存器为 32 位、只读，序号对应字偏移：

| 寄存器序号 | MCU 地址 | 内容 |
| --- | --- | --- |
| 0 | `0x60000000` | bit 0、1 分别表示 ADC1、ADC2 已完成首次采样 |
| 1 | `0x60000004` | ADC1 最新 12 位原始值，J3 / PB1 / PIN_19 / ADC_IN9 |
| 2 | `0x60000008` | ADC2 最新 12 位原始值，J4 / PB0 / PIN_18 / ADC_IN8 |

通道选择编码参考厂商例程：ADC_IN9 选择值为 10，ADC_IN8 选择值为 9。ADC 串行时钟由 200 MHz 总线时钟分频至 10 MHz，按例程的 13 个时钟计算约 769 k 次/秒/通道。
地址只译码低 4 位，寄存器在 CPLD 映射空间内每 16 字节镜像一次；程序使用表中的基地址。

`Input_Task` 独立于 LVGL，使用 1 ms 周期读取 ADC；LVGL 任务每 100 ms 通过 `Input_GetSnapshot()` 读取同步快照并更新界面。1 ms 为 FreeRTOS 任务调度周期，实际读取时间受中断和调度影响。首次有效采样前检查 `valid_mask`。两路寄存器分别读取，不保证采样时刻完全相同。

ADC1、ADC2 分别使用独立的一维卡尔曼滤波器处理原始值，然后换算百分比；首次有效采样直接作为滤波初值。调试器可通过 `cpld_adc_values` 同时查看 `adc1_raw`、`adc2_raw` 和 `adc1_filtered`、`adc2_filtered`。

在 `config/adc_config.h` 分别调整 `ADC1_KALMAN_Q`、`ADC1_KALMAN_R`、`ADC2_KALMAN_Q` 和 `ADC2_KALMAN_R`，直接使用单精度浮点数：默认 Q=0.0625f，R=25.0f。Q 越大响应通常越快，R 越大通常越平稳；两者应根据实测噪声和响应速度调整，Q 应大于或等于 0，R 应大于 0。初始化时负 Q 按 0 处理，非正 R 按 1 处理。

在 `config/adc_config.h` 中分别设置 `ADC1_RAW_MIN`、`ADC1_RAW_MAX` 和 `ADC2_RAW_MIN`、`ADC2_RAW_MAX`，当前均使用示例值 1000～2000。每路**滤波值**低于下限按 0% 显示，高于上限按 100% 显示，区间内线性换算并四舍五入，例如 1500 显示 50%。实际使用前按各传感器实测值调整；每路须满足 `0 <= MIN < MAX <= 4095`。

仪表盘左侧共用条中，B 刹车使用 ADC1，向左显示；T 油门使用 ADC2，向右显示，可同时显示。右侧 PPM 的独立任务每 1 ms 从两路滤波后的 ADC 值计算：`PPM = clamp(1.0 × 油门 - 1.5 × 刹车, -1, 1)`，油门和刹车分别根据各自量程归一化到 0～1。权重在 `user/config/ppm_config.h` 中定义；计算使用完整的 ADC 归一化精度，界面显示四舍五入后的百分比。负值向左表示刹车，正值向右表示驱动。任一路尚未完成首次有效采样时，PPM 显示 `--`。

其他任务可调用 `Ppm_GetSnapshot()` 取得归一化值、百分比和有效标志。当前仅计算和显示，尚未生成或发送 PPM 信号；示例量程与滤波参数尚需根据传感器实测校准，也没有输入故障诊断。

车辆启动时默认锁定，车 Logo 显示红色，PPM 快照强制为 0。调用 `VehicleLock_SetLocked(false)` 解锁后 Logo 变黑，并在下一次有效 ADC 计算后恢复 PPM；调用 `VehicleLock_SetLocked(true)` 会同步清零 PPM。现在还没有接入实际锁车信号或 PPM 输出，后续输出必须始终使用 `Ppm_GetSnapshot()` 获取经过锁定限制的值。
