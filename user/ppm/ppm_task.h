#ifndef USER_PPM_PPM_TASK_H
#define USER_PPM_PPM_TASK_H

#include <stdint.h>
#include <stdbool.h>

typedef struct {
  float normalized; /* [-1, 1], negative = brake, positive = drive. */
  int16_t percent;  /* Rounded display value, -100..100. */
  bool valid;       /* Locked zero is valid; unlocked requires both ADCs. */
  bool vehicle_locked;
} PpmValues;

/* 0：等待中位；1：测试中；2：已结束；3：跳过或中止。 */
extern volatile uint8_t ppm_startup_test_state;
extern volatile int32_t ppm_startup_test_peak_erpm; /* 本次测试的最大绝对电气转速。 */
extern volatile uint32_t ppm_startup_test_duration_ticks; /* 本次测试实际持续节拍数。 */

void Ppm_Task(void *argument);
void Ppm_GetSnapshot(PpmValues *values);
/* Starts locked; lock forces the published PPM to zero immediately. */
void VehicleLock_SetLocked(bool locked);

#endif
