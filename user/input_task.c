#include "input_task.h"
#include "FreeRTOS.h"
#include "task.h"

#define INPUT_POLL_PERIOD_MS 1U

/* Only Input_Task writes this snapshot; readers use Input_GetSnapshot(). */
static volatile InputValues input_values;

void Input_GetSnapshot(InputValues *values)
{
  if (values == NULL) return;
  taskENTER_CRITICAL();
  values->adc.adc1_raw = input_values.adc.adc1_raw;
  values->adc.adc2_raw = input_values.adc.adc2_raw;
  values->adc.adc1_filtered = input_values.adc.adc1_filtered;
  values->adc.adc2_filtered = input_values.adc.adc2_filtered;
  values->adc.adc1_percent = input_values.adc.adc1_percent;
  values->adc.adc2_percent = input_values.adc.adc2_percent;
  values->adc.valid_mask = input_values.adc.valid_mask;
  taskEXIT_CRITICAL();
}

void Input_Task(void *argument)
{
  (void)argument;
  TickType_t last_wake = xTaskGetTickCount();
  for (;;) {
    CpldAdcValues adc;
    CpldAdc_Poll();
    CpldAdc_GetSnapshot(&adc);

    taskENTER_CRITICAL();
    input_values.adc.adc1_raw = adc.adc1_raw;
    input_values.adc.adc2_raw = adc.adc2_raw;
    input_values.adc.adc1_filtered = adc.adc1_filtered;
    input_values.adc.adc2_filtered = adc.adc2_filtered;
    input_values.adc.adc1_percent = adc.adc1_percent;
    input_values.adc.adc2_percent = adc.adc2_percent;
    input_values.adc.valid_mask = adc.valid_mask;
    taskEXIT_CRITICAL();
    vTaskDelayUntil(&last_wake, pdMS_TO_TICKS(INPUT_POLL_PERIOD_MS));
  }
}
