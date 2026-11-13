#include "ppm_task.h"
#include "input_task.h"
#include "math/ppm_mix.h"
#include "FreeRTOS.h"
#include "task.h"

#define PPM_COMPUTE_PERIOD_MS 1U

/* A coherent snapshot for the UI and future PPM output. */
static volatile PpmValues ppm_values;
static volatile bool vehicle_locked = true;

void VehicleLock_SetLocked(bool locked)
{
  taskENTER_CRITICAL();
  if (vehicle_locked != locked) {
    vehicle_locked = locked;
    /* On unlock, wait for a fresh calculation instead of reusing old input. */
    ppm_values.normalized = 0.0f;
    ppm_values.percent = 0;
    ppm_values.valid = locked;
  }
  taskEXIT_CRITICAL();
}

void Ppm_GetSnapshot(PpmValues *values)
{
  if (values == NULL) return;
  taskENTER_CRITICAL();
  values->vehicle_locked = vehicle_locked;
  values->normalized = vehicle_locked ? 0.0f : ppm_values.normalized;
  values->percent = vehicle_locked ? 0 : ppm_values.percent;
  values->valid = vehicle_locked || ppm_values.valid;
  taskEXIT_CRITICAL();
}

void Ppm_Task(void *argument)
{
  (void)argument;
  TickType_t last_wake = xTaskGetTickCount();
  for (;;) {
    InputValues input;
    Input_GetSnapshot(&input);
    bool valid = (input.adc.valid_mask & 3U) == 3U;
    float normalized = 0.0f;
    int16_t percent = 0;
    if (valid) {
      float throttle = Ppm_NormalizeAdc(input.adc.adc2_filtered, ADC2_RAW_MIN, ADC2_RAW_MAX);
      float brake = Ppm_NormalizeAdc(input.adc.adc1_filtered, ADC1_RAW_MIN, ADC1_RAW_MAX);
      normalized = Ppm_MixNormalized(throttle, brake);
      float scaled = normalized * 100.0f;
      percent = (int16_t)(scaled < 0.0f ? scaled - 0.5f : scaled + 0.5f);
    }
    taskENTER_CRITICAL();
    ppm_values.normalized = vehicle_locked ? 0.0f : normalized;
    ppm_values.percent = vehicle_locked ? 0 : percent;
    ppm_values.valid = vehicle_locked || valid;
    taskEXIT_CRITICAL();
    vTaskDelayUntil(&last_wake, pdMS_TO_TICKS(PPM_COMPUTE_PERIOD_MS));
  }
}
