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

/* 0：等待安全中位；1：输出已启用；2：故障锁存，须排查并复位。 */
extern volatile uint8_t ppm_control_state;

void Ppm_Task(void *argument);
void Ppm_GetSnapshot(PpmValues *values);
/* Bench starts unlocked; lock publishes zero and schedules neutral next frame. */
void VehicleLock_SetLocked(bool locked);

#endif
