#ifndef USER_PPM_TASK_H
#define USER_PPM_TASK_H

#include <stdint.h>

void Ppm_Task(void *argument);
/* Current No Reverse With Brake: negative = brake, positive = drive. */
int16_t Ppm_GetThrottlePercent(void);

#endif
