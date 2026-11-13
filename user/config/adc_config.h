#ifndef USER_ADC_CONFIG_H
#define USER_ADC_CONFIG_H

/* ADC1 接刹车，ADC2 接油门；端点为示例，请按实测值校准（范围 0～4095）。 */
#define ADC1_RAW_MIN 1000U /* 刹车最小原始值，低于此值为 0%。 */
#define ADC1_RAW_MAX 2000U /* 刹车最大原始值，高于此值为 100%。 */
#define ADC2_RAW_MIN 1000U /* 油门最小原始值，低于此值为 0%。 */
#define ADC2_RAW_MAX 2000U /* 油门最大原始值，高于此值为 100%。 */

/* 标量卡尔曼滤波参数：过程噪声 Q >= 0，测量噪声 R > 0，单位为 ADC 计数的平方。 */
#define ADC1_KALMAN_Q 0.0625f /* 刹车过程噪声。 */
#define ADC1_KALMAN_R 25.0f   /* 刹车测量噪声。 */
#define ADC2_KALMAN_Q 0.0625f /* 油门过程噪声。 */
#define ADC2_KALMAN_R 25.0f   /* 油门测量噪声。 */
#endif
