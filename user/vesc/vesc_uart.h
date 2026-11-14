#ifndef USER_VESC_UART_H
#define USER_VESC_UART_H

#include "vesc_protocol.h"
#include "config/vesc_config.h"

typedef struct {
  VescTelemetry telemetry;
  uint32_t packets_ok;
  uint32_t last_update_tick;
  uint32_t battery_packets_ok;
  uint32_t battery_last_update_tick;
  int16_t battery_level_thousandths; /* VESC 电量比例 × 1000，保留原始值供调试。 */
  uint8_t battery_percent;
  bool battery_valid;
  bool online;
} VescStatus;

/* Communication status and diagnostic counters may be inspected through SWD. */
extern volatile VescStatus vesc_status;
extern volatile uint32_t vesc_uart_rx_errors;
extern volatile uint32_t vesc_uart_rx_overflows;

bool VescUart_Init(void);
void Vesc_GetSnapshot(VescStatus *result);

#endif
