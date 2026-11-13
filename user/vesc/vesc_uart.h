#ifndef USER_VESC_UART_H
#define USER_VESC_UART_H

#include "vesc_protocol.h"
#include "config/vesc_config.h"

typedef struct {
  VescTelemetry telemetry;
  uint32_t packets_ok;
  uint32_t last_update_tick;
  bool online;
} VescStatus;

/* Communication status and diagnostic counters may be inspected through SWD. */
extern volatile VescStatus vesc_status;
extern volatile uint32_t vesc_uart_rx_errors;
extern volatile uint32_t vesc_uart_rx_overflows;

bool VescUart_Init(void);
void Vesc_GetSnapshot(VescStatus *result);

#endif
