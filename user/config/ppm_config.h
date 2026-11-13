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
/* 台架测试：上电后先输出中位，再输出固定 25%，持续 10 秒后锁车。 */
#define PPM_TEST_ENABLE 1U          /* 1 开机自动测试；0 禁用测试，仅输出中位。 */
#define PPM_TEST_PERCENT 25U        /* 以中位为零的正向指令百分比。 */
#define PPM_TEST_NEUTRAL_MS 2000U   /* 启动时保持中位，等待 VESC 安全启动。 */
#define PPM_TEST_DURATION_MS 10000U /* 正向测试持续时间，单位毫秒。 */
#define PPM_TEST_WATCHDOG_MS 250U   /* 看门狗单周期；两次超时后复位。 */
#define PPM_FRAME_PERIOD_US 20000U  /* PPM 脉冲周期，单位微秒（50 Hz）。 */

#if PPM_TEST_PERCENT > 100 || PPM_PULSE_MIN_US >= PPM_PULSE_CENTER_US || \
    PPM_PULSE_CENTER_US >= PPM_PULSE_MAX_US || PPM_PULSE_MAX_US >= PPM_FRAME_PERIOD_US
#error "Invalid PPM pulse or test percent configuration"
#endif
#endif
