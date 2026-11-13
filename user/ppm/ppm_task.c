#include "ppm_task.h"
#include "input_task.h"
#include "ppm_mix.h"
#include "ppm_output.h"
#include "vesc/vesc_uart.h"
#include "FreeRTOS.h"
#include "task.h"

/* A coherent snapshot for the UI and startup-only PPM test output. */
static volatile PpmValues ppm_values;
static volatile bool vehicle_locked = true;
static volatile uint32_t lock_generation;
volatile uint8_t ppm_startup_test_state;
volatile int32_t ppm_startup_test_peak_erpm;
volatile uint32_t ppm_startup_test_duration_ticks;

void VehicleLock_SetLocked(bool locked)
{
  taskENTER_CRITICAL();
  if (vehicle_locked != locked) {
    vehicle_locked = locked;
    ++lock_generation;
    /* On unlock, wait for a fresh calculation instead of reusing old input. */
    ppm_values.normalized = 0.0f;
    ppm_values.percent = 0;
    ppm_values.valid = locked;
  }
  if (locked) PpmOutput_SetTestActive(false);
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
  TickType_t test_start = last_wake;
  uint32_t test_generation = 0;
  ppm_startup_test_state = PpmOutput_TestAllowed() ? 0U : 3U;
  for (;;) {
    TickType_t now = xTaskGetTickCount();
    if (ppm_startup_test_state == 0U &&
        (TickType_t)(now - test_start) >= pdMS_TO_TICKS(PPM_TEST_NEUTRAL_MS)) {
      VescStatus vesc;
      Vesc_GetSnapshot(&vesc);
      if (vesc.online && vehicle_locked) {
        PpmOutput_WatchdogStart();
        VehicleLock_SetLocked(false);
        taskENTER_CRITICAL();
        test_generation = lock_generation;
        ppm_startup_test_state = 1U;
        ppm_startup_test_peak_erpm = 0;
        ppm_startup_test_duration_ticks = 0;
        taskEXIT_CRITICAL();
        test_start = now;
      } else {
        ppm_startup_test_state = 3U;
      }
    }
    if (ppm_startup_test_state == 1U) {
      VescStatus vesc;
      Vesc_GetSnapshot(&vesc);
      int64_t rpm = vesc.telemetry.electrical_rpm;
      int64_t peak = ppm_startup_test_peak_erpm;
      if ((rpm < 0 ? -rpm : rpm) > (peak < 0 ? -peak : peak))
        ppm_startup_test_peak_erpm = (int32_t)rpm;
      if (!vesc.online || vehicle_locked || lock_generation != test_generation ||
          (TickType_t)(now - test_start) >= pdMS_TO_TICKS(PPM_TEST_DURATION_MS)) {
        bool completed = vesc.online && !vehicle_locked && lock_generation == test_generation;
        ppm_startup_test_duration_ticks = (uint32_t)(now - test_start);
        VehicleLock_SetLocked(true);
        PpmOutput_WatchdogStop();
        ppm_startup_test_state = completed ? 2U : 3U;
      } else {
        PpmOutput_WatchdogFeed();
      }
    }
    taskENTER_CRITICAL();
    uint32_t generation = lock_generation;
    taskEXIT_CRITICAL();
    InputValues input;
    Input_GetSnapshot(&input);
    bool valid = (input.adc.valid_mask & 3U) == 3U;
    float normalized = 0.0f;
    int16_t percent = 0;
    if (ppm_startup_test_state == 1U) {
      normalized = (float)PPM_TEST_PERCENT / 100.0f;
      percent = (int16_t)PPM_TEST_PERCENT;
      valid = true;
    } else if (valid) {
      float throttle = Ppm_NormalizeAdc(input.adc.adc2_filtered, ADC2_RAW_MIN, ADC2_RAW_MAX);
      float brake = Ppm_NormalizeAdc(input.adc.adc1_filtered, ADC1_RAW_MIN, ADC1_RAW_MAX);
      normalized = Ppm_MixNormalized(throttle, brake);
      float scaled = normalized * 100.0f;
      percent = (int16_t)(scaled < 0.0f ? scaled - 0.5f : scaled + 0.5f);
    }
    taskENTER_CRITICAL();
    if (vehicle_locked || generation != lock_generation) {
      ppm_values.normalized = 0.0f;
      ppm_values.percent = 0;
      ppm_values.valid = vehicle_locked;
    } else {
      ppm_values.normalized = normalized;
      ppm_values.percent = percent;
      ppm_values.valid = valid;
    }
    PpmOutput_SetTestActive(!vehicle_locked && generation == lock_generation &&
                            ppm_startup_test_state == 1U);
    taskEXIT_CRITICAL();
    vTaskDelayUntil(&last_wake, pdMS_TO_TICKS(PPM_COMPUTE_PERIOD_MS));
  }
}
