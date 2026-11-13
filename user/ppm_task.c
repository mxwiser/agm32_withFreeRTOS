#include "ppm_task.h"
#include "FreeRTOS.h"
#include "task.h"

#define PPM_DEMO_PERIOD_MS 500U

/* Temporary display data; replace the task body when PPM capture is connected. */
static volatile uint8_t ppm_throttle_percent;

uint8_t Ppm_GetThrottlePercent(void)
{
  uint8_t value;
  taskENTER_CRITICAL();
  value = ppm_throttle_percent;
  taskEXIT_CRITICAL();
  return value;
}

void Ppm_Task(void *argument)
{
  (void)argument;
  TickType_t last_wake = xTaskGetTickCount();
  for (;;) {
    vTaskDelayUntil(&last_wake, pdMS_TO_TICKS(PPM_DEMO_PERIOD_MS));
    ppm_throttle_percent = (uint8_t)((ppm_throttle_percent + 3U) % 101U);
  }
}
