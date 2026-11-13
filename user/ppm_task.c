#include "ppm_task.h"
#include "FreeRTOS.h"
#include "task.h"

#define PPM_DEMO_PERIOD_MS 500U

/* Temporary display data; replace the task body when PPM capture is connected. */
static volatile int16_t ppm_throttle_percent;

int16_t Ppm_GetThrottlePercent(void)
{
  int16_t value;
  taskENTER_CRITICAL();
  value = ppm_throttle_percent;
  taskEXIT_CRITICAL();
  return value;
}

void Ppm_Task(void *argument)
{
  (void)argument;
  TickType_t last_wake = xTaskGetTickCount();
  int16_t step = 10;
  for (;;) {
    vTaskDelayUntil(&last_wake, pdMS_TO_TICKS(PPM_DEMO_PERIOD_MS));
    int16_t next = (int16_t)(ppm_throttle_percent + step);
    if (next >= 100) { next = 100; step = -10; }
    else if (next <= -100) { next = -100; step = 10; }
    ppm_throttle_percent = next;
  }
}
