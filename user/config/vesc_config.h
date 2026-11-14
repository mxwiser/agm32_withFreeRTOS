#ifndef USER_VESC_CONFIG_H
#define USER_VESC_CONFIG_H

#define VESC_UART_BAUD 115200U             /* UART0 波特率，须与 VESC 一致。 */
#define VESC_TASK_PERIOD_MS 1U             /* 接收和超时处理周期，单位毫秒。 */
#define VESC_REQUEST_PERIOD_MS 100U        /* 只读遥测请求周期，单位毫秒。 */
#define VESC_OFFLINE_TIMEOUT_MS 1000U      /* 多久未收到有效遥测判定离线，单位毫秒。 */
#define VESC_FRAME_TIMEOUT_MS 50U          /* 不完整数据帧的接收超时，单位毫秒。 */
#define VESC_RX_BUFFER_SIZE 128U           /* 接收环形缓冲区，须为 2～256 的 2 次幂。 */
#define VESC_SETUP_REQUEST_PERIOD_MS 100U   /* 车速及电量读取周期，单位毫秒。 */
#define VESC_SPEED_VALIDITY_MS 500U        /* 多久未收到车速后显示 --。 */
#define VESC_BATTERY_VALIDITY_MS 1500U      /* 多久未收到电量后图标变灰。 */
#define VESC_SETUP_REQUEST_GAP_MS 25U       /* 与实时遥测请求的最小间隔。 */

#if VESC_RX_BUFFER_SIZE < 2 || VESC_RX_BUFFER_SIZE > 256 || (VESC_RX_BUFFER_SIZE & (VESC_RX_BUFFER_SIZE - 1)) != 0
#error "VESC_RX_BUFFER_SIZE must be a power of two between 2 and 256"
#endif
#if VESC_SETUP_REQUEST_GAP_MS * 2U >= VESC_REQUEST_PERIOD_MS
#error "Setup request needs a gap on both sides of telemetry requests"
#endif
#endif
