#ifndef USER_PPM_CONFIG_H
#define USER_PPM_CONFIG_H

/* 输出计算值 = 油门权重 × 油门 - 刹车权重 × 刹车，最终限制在 [-1, 1]。 */
#define PPM_THROTTLE_WEIGHT 1.0f /* 油门权重。 */
#define PPM_BRAKE_WEIGHT 1.5f    /* 刹车权重。 */
#define PPM_COMPUTE_PERIOD_MS 1U /* 归一化计算周期，单位毫秒。 */

/* VESC Tool 的脉宽设置。 */
#define PPM_PULSE_MIN_US 1000U    /* 最小脉宽 1.0 ms。 */
#define PPM_PULSE_CENTER_US 1500U /* 中位脉宽 1.5 ms。 */
#define PPM_PULSE_MAX_US 2000U    /* 最大脉宽 2.0 ms。 */
#define PPM_NEUTRAL_ARM_MS 1000U    /* 油门和刹车均松开且输入正常，保持 1 秒后允许输出。 */
#define PPM_NEUTRAL_PERCENT 5U      /* 判定松开的最大百分比；同时检查原始值。 */
#define PPM_INPUT_TIMEOUT_MS 20U    /* 采样任务超时后禁止输出。 */
#define PPM_ADC_TIMEOUT_MS 50U      /* 任一路 ADC 转换计数停止后禁止输出。 */
#define PPM_WATCHDOG_MS 250U        /* PPM 任务持续喂狗；超时复位后禁止自动恢复。 */
#define PPM_FRAME_PERIOD_US 20000U  /* PPM 脉冲周期，单位微秒（50 Hz）。 */

#if PPM_NEUTRAL_PERCENT > 100 || PPM_PULSE_MIN_US >= PPM_PULSE_CENTER_US || \
    PPM_PULSE_CENTER_US >= PPM_PULSE_MAX_US || PPM_PULSE_MAX_US >= PPM_FRAME_PERIOD_US
#error "Invalid PPM pulse or neutral percent configuration"
#endif
#endif
