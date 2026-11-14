#include "vesc_uart.h"
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"

static uint8_t rx_buffer[VESC_RX_BUFFER_SIZE];
static volatile uint8_t rx_head, rx_tail;
volatile VescStatus vesc_status;
volatile uint32_t vesc_uart_rx_errors;
volatile uint32_t vesc_uart_rx_overflows;

/* UART0 ISR only moves bytes; parsing and RTOS calls stay in the VESC task. */
void UART0_isr(void)
{
  while (!UART_IsRxFifoEmpty(UART0)) {
    uint32_t word = UART0->DR;
    if ((word & (UART_DR_FE | UART_DR_PE | UART_DR_BE | UART_DR_OE)) != 0U) {
      ++vesc_uart_rx_errors;
      UART_ClearErrors(UART0);
      continue;
    }
    uint8_t next = (uint8_t)((rx_head + 1U) & (VESC_RX_BUFFER_SIZE - 1U));
    if (next == rx_tail) {
      ++vesc_uart_rx_overflows;
    } else {
      rx_buffer[rx_head] = (uint8_t)word;
      rx_head = next;
    }
  }
  UART_ClearInt(UART0, UART_INT_RX | UART_INT_RT | UART_INT_FE |
                        UART_INT_PE | UART_INT_BE | UART_INT_OE);
}

void Vesc_GetSnapshot(VescStatus *result)
{
  if (result == NULL) return;
  taskENTER_CRITICAL();
  result->telemetry.fet_temp_tenths_c = vesc_status.telemetry.fet_temp_tenths_c;
  result->telemetry.input_current_hundredths_a = vesc_status.telemetry.input_current_hundredths_a;
  result->telemetry.electrical_rpm = vesc_status.telemetry.electrical_rpm;
  result->telemetry.input_voltage_tenths_v = vesc_status.telemetry.input_voltage_tenths_v;
  result->packets_ok = vesc_status.packets_ok;
  result->last_update_tick = vesc_status.last_update_tick;
  result->battery_packets_ok = vesc_status.battery_packets_ok;
  result->battery_last_update_tick = vesc_status.battery_last_update_tick;
  result->battery_level_thousandths = vesc_status.battery_level_thousandths;
  result->battery_percent = vesc_status.battery_percent;
  result->battery_valid = vesc_status.battery_valid;
  result->online = vesc_status.online;
  taskEXIT_CRITICAL();
}

static void vesc_task_main(void *argument)
{
  (void)argument;
  VescParser parser;
  VescProtocol_Reset(&parser);
  uint8_t request[VESC_REQUEST_BYTES];
  uint8_t battery_request[VESC_REQUEST_BYTES];
  VescProtocol_Request(request);
  VescProtocol_RequestBattery(battery_request);
  TickType_t wake = xTaskGetTickCount();
  TickType_t last_request = wake - pdMS_TO_TICKS(VESC_REQUEST_PERIOD_MS);
  TickType_t last_byte = wake;
  TickType_t last_battery_request = wake - pdMS_TO_TICKS(VESC_BATTERY_REQUEST_PERIOD_MS);
  uint32_t last_errors = 0, last_overflows = 0;
  for (;;) {
    TickType_t now = xTaskGetTickCount();
    if ((TickType_t)(now - last_request) >= pdMS_TO_TICKS(VESC_REQUEST_PERIOD_MS)) {
      UART_Send(UART0, request, sizeof(request));
      last_request = now;
    }
    TickType_t since_request = now - last_request;
    if (vesc_status.online && parser.state == 0U && rx_head == rx_tail &&
        since_request >= pdMS_TO_TICKS(VESC_BATTERY_REQUEST_GAP_MS) &&
        since_request < pdMS_TO_TICKS(VESC_REQUEST_PERIOD_MS - VESC_BATTERY_REQUEST_GAP_MS) &&
        (TickType_t)(now - last_battery_request) >= pdMS_TO_TICKS(VESC_BATTERY_REQUEST_PERIOD_MS)) {
      UART_Send(UART0, battery_request, sizeof(battery_request));
      last_battery_request = now;
    }
    if (last_errors != vesc_uart_rx_errors || last_overflows != vesc_uart_rx_overflows) {
      taskENTER_CRITICAL();
      last_errors = vesc_uart_rx_errors;
      last_overflows = vesc_uart_rx_overflows;
      rx_tail = rx_head;
      taskEXIT_CRITICAL();
      VescProtocol_Reset(&parser);
    }
    if (parser.state != 0U && (TickType_t)(now - last_byte) > pdMS_TO_TICKS(VESC_FRAME_TIMEOUT_MS))
      VescProtocol_Reset(&parser);
    while (rx_tail != rx_head) {
      uint8_t byte = rx_buffer[rx_tail];
      rx_tail = (uint8_t)((rx_tail + 1U) & (VESC_RX_BUFFER_SIZE - 1U));
      last_byte = now;
      VescResult result;
      VescEvent event = VescProtocol_Feed(&parser, byte, &result);
      if (event == VESC_EVENT_TELEMETRY) {
        taskENTER_CRITICAL();
        vesc_status.telemetry.fet_temp_tenths_c = result.telemetry.fet_temp_tenths_c;
        vesc_status.telemetry.input_current_hundredths_a = result.telemetry.input_current_hundredths_a;
        vesc_status.telemetry.electrical_rpm = result.telemetry.electrical_rpm;
        vesc_status.telemetry.input_voltage_tenths_v = result.telemetry.input_voltage_tenths_v;
        ++vesc_status.packets_ok;
        vesc_status.last_update_tick = now;
        vesc_status.online = true;
        taskEXIT_CRITICAL();
      } else if (event == VESC_EVENT_BATTERY) {
        int16_t level = result.battery_level_thousandths;
        taskENTER_CRITICAL();
        vesc_status.battery_level_thousandths = level;
        vesc_status.battery_percent = VescProtocol_BatteryPercent(level);
        ++vesc_status.battery_packets_ok;
        vesc_status.battery_last_update_tick = now;
        vesc_status.battery_valid = true;
        taskEXIT_CRITICAL();
      }
    }
    if (vesc_status.online &&
        (TickType_t)(now - vesc_status.last_update_tick) > pdMS_TO_TICKS(VESC_OFFLINE_TIMEOUT_MS)) {
      taskENTER_CRITICAL();
      vesc_status.online = false;
      vesc_status.battery_valid = false;
      taskEXIT_CRITICAL();
    }
    if (vesc_status.battery_valid &&
        (TickType_t)(now - vesc_status.battery_last_update_tick) > pdMS_TO_TICKS(VESC_BATTERY_VALIDITY_MS)) {
      taskENTER_CRITICAL();
      vesc_status.battery_valid = false;
      taskEXIT_CRITICAL();
    }
    vTaskDelayUntil(&wake, pdMS_TO_TICKS(VESC_TASK_PERIOD_MS));
  }
}

bool VescUart_Init(void)
{
  if (xTaskCreate(vesc_task_main, "VESC", configMINIMAL_STACK_SIZE,
                  NULL, tskIDLE_PRIORITY + 2, NULL) != pdPASS) return false;
  SYS_EnableAPBClock(APB_MASK_UART0);
  GPIO_AF_ENABLE(UART0_UARTTXD);
  GPIO_AF_ENABLE(UART0_UARTRXD);
  UART_Init(UART0, VESC_UART_BAUD, UART_LCR_DATABITS_8, UART_LCR_STOPBITS_1,
            UART_LCR_PARITY_NONE, UART_LCR_FIFO_16);
  UART_SetRxIntFifoLevel(UART0, UART_INT_FIFO_1_8TH);
  UART_ClearInt(UART0, UART_INT_ALL);
  UART_EnableInt(UART0, UART_INT_RX | UART_INT_RT | UART_INT_FE |
                        UART_INT_PE | UART_INT_BE | UART_INT_OE);
  INT_EnableIRQ(UART0_IRQn, 1);
  return true;
}
