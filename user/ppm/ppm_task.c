#include "ppm_task.h"
#include "input_task.h"
#include "ppm_control.h"
#include "ppm_mix.h"
#include "ppm_output.h"
#include "vesc/vesc_uart.h"
#include "FreeRTOS.h"
#include "task.h"

static volatile PpmValues ppm_values;
/* Temporary bench policy: unlocked at boot; drive still requires neutral arming. */
static volatile bool vehicle_locked = false;
static volatile uint32_t lock_generation;
volatile uint8_t ppm_control_state = PPM_CONTROL_WAITING;

void VehicleLock_SetLocked(bool locked)
{
  taskENTER_CRITICAL();
  if (vehicle_locked != locked) {
    vehicle_locked = locked;
    ++lock_generation;
    ppm_values.normalized = 0.0f;
    ppm_values.percent = 0;
    ppm_values.valid = locked;
  }
  if (locked) PpmOutput_SetNormalized(0.0f);
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
  TickType_t wake = xTaskGetTickCount();
  TickType_t adc1_progress = wake, adc2_progress = wake;
  uint16_t adc1_sequence = 0, adc2_sequence = 0;
  bool adc1_seen = false, adc2_seen = false;
  uint32_t observed_generation = 0;
  PpmControl control = { .state = ppm_watchdog_reset_detected ?
                                  PPM_CONTROL_FAULT : PPM_CONTROL_WAITING };
  if (control.state == PPM_CONTROL_FAULT) VehicleLock_SetLocked(true);
  PpmOutput_WatchdogStart();
  for (;;) {
    uint32_t generation;
    bool locked;
    taskENTER_CRITICAL();
    generation = lock_generation;
    locked = vehicle_locked;
    taskEXIT_CRITICAL();
    if (generation != observed_generation) {
      observed_generation = generation;
      if (control.state != PPM_CONTROL_FAULT) control.state = PPM_CONTROL_WAITING;
      control.neutral_tracking = false;
    }

    InputValues input;
    VescStatus vesc;
    Input_GetSnapshot(&input);
    Vesc_GetSnapshot(&vesc);
    TickType_t now = xTaskGetTickCount();
    if ((input.adc.valid_mask & 1U) && input.adc.adc1_sequence != adc1_sequence) {
      adc1_sequence = input.adc.adc1_sequence;
      adc1_progress = now;
      adc1_seen = true;
    }
    if ((input.adc.valid_mask & 2U) && input.adc.adc2_sequence != adc2_sequence) {
      adc2_sequence = input.adc.adc2_sequence;
      adc2_progress = now;
      adc2_seen = true;
    }

    bool ready = vesc.online &&
        (TickType_t)(now - vesc.last_update_tick) <= pdMS_TO_TICKS(VESC_OFFLINE_TIMEOUT_MS) &&
        (input.adc.valid_mask & 3U) == 3U && adc1_seen && adc2_seen &&
        (TickType_t)(now - input.update_tick) <= pdMS_TO_TICKS(PPM_INPUT_TIMEOUT_MS) &&
        (TickType_t)(now - adc1_progress) <= pdMS_TO_TICKS(PPM_ADC_TIMEOUT_MS) &&
        (TickType_t)(now - adc2_progress) <= pdMS_TO_TICKS(PPM_ADC_TIMEOUT_MS);
    float throttle = Ppm_NormalizeAdc(input.adc.adc2_filtered, ADC2_RAW_MIN, ADC2_RAW_MAX);
    float brake = Ppm_NormalizeAdc(input.adc.adc1_filtered, ADC1_RAW_MIN, ADC1_RAW_MAX);
    float release_limit = (float)PPM_NEUTRAL_PERCENT / 100.0f;
    bool released = throttle <= release_limit && brake <= release_limit &&
        Ppm_NormalizeAdc(input.adc.adc2_raw, ADC2_RAW_MIN, ADC2_RAW_MAX) <= release_limit &&
        Ppm_NormalizeAdc(input.adc.adc1_raw, ADC1_RAW_MIN, ADC1_RAW_MAX) <= release_limit;
    float normalized = PpmControl_Update(&control, (uint32_t)now, locked, ready, released, throttle, brake);
    if (control.state == PPM_CONTROL_FAULT) VehicleLock_SetLocked(true);
    float scaled = normalized * 100.0f;
    int16_t percent = (int16_t)(scaled < 0.0f ? scaled - 0.5f : scaled + 0.5f);

    taskENTER_CRITICAL();
    if (vehicle_locked || generation != lock_generation || control.state != PPM_CONTROL_ACTIVE) {
      ppm_values.normalized = 0.0f;
      ppm_values.percent = 0;
      ppm_values.valid = vehicle_locked;
      PpmOutput_SetNormalized(0.0f);
    } else {
      ppm_values.normalized = normalized;
      ppm_values.percent = percent;
      ppm_values.valid = true;
      PpmOutput_SetNormalized(normalized);
    }
    ppm_control_state = (uint8_t)control.state;
    taskEXIT_CRITICAL();
    PpmOutput_WatchdogFeed();
    vTaskDelayUntil(&wake, pdMS_TO_TICKS(PPM_COMPUTE_PERIOD_MS));
  }
}
