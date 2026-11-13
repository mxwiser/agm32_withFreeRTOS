#ifndef USER_VESC_CONFIG_H
#define USER_VESC_CONFIG_H

#define VESC_UART_BAUD 115200U             /* UART0 波特率，须与 VESC 一致。 */
#define VESC_TASK_PERIOD_MS 1U             /* 接收和超时处理周期，单位毫秒。 */
#define VESC_REQUEST_PERIOD_MS 100U        /* 只读遥测请求周期，单位毫秒。 */
#define VESC_OFFLINE_TIMEOUT_MS 1000U      /* 多久未收到有效遥测判定离线，单位毫秒。 */
#define VESC_FRAME_TIMEOUT_MS 50U          /* 不完整数据帧的接收超时，单位毫秒。 */
#define VESC_RX_BUFFER_SIZE 128U           /* 接收环形缓冲区，须为 2～256 的 2 次幂。 */
#define VESC_CONFIG_RETRY_MS 1000U          /* 未取得电机配置时的重试周期。 */
#define VESC_CONFIG_REFRESH_MS 10000U       /* 已取得配置后的重新读取周期。 */
#define VESC_CONFIG_TIMEOUT_MS 250U         /* 完整配置应答等待超时。 */
#define VESC_CONFIG_VALIDITY_MS 30000U      /* 配置持续读取失败后的失效时间。 */
#define VESC_CONFIG_REQUEST_GAP_MS 25U      /* 与实时遥测请求的最小间隔。 */

/* ERPM 换算车速：参数未知时设为 0，界面显示 --；确认后按实车填写。 */
#define VESC_MOTOR_POLE_PAIRS 10U       /* 20 个磁极对应 10 对极。 */
#define VESC_WHEEL_CIRCUMFERENCE_MM 1500U /* 车轮滚动周长，毫米；当前是假设值。 */
#define VESC_GEAR_MOTOR_TURNS 30U       /* 传动比的电机转数；当前是假设 30:1。 */
#define VESC_GEAR_WHEEL_TURNS 1U        /* 对应车轮转数，直驱填写 1。 */

#if VESC_RX_BUFFER_SIZE < 2 || VESC_RX_BUFFER_SIZE > 256 || (VESC_RX_BUFFER_SIZE & (VESC_RX_BUFFER_SIZE - 1)) != 0
#error "VESC_RX_BUFFER_SIZE must be a power of two between 2 and 256"
#endif
#endif
