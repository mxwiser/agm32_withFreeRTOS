#ifndef USER_PPM_TASK_H
#define USER_PPM_TASK_H

#include <stdint.h>
#include <stdbool.h>

typedef struct {
  float normalized; /* [-1, 1], negative = brake, positive = drive. */
  int16_t percent;  /* Rounded display value, -100..100. */
  bool valid;       /* Both ADC inputs have completed an initial sample. */
  bool vehicle_locked;
} PpmValues;

void Ppm_Task(void *argument);
void Ppm_GetSnapshot(PpmValues *values);
/* Starts locked; lock forces the published PPM to zero immediately. */
void VehicleLock_SetLocked(bool locked);

#endif
