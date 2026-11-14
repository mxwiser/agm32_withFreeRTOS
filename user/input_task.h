#ifndef USER_INPUT_TASK_H
#define USER_INPUT_TASK_H

#include "cpld_adc.h"
#include <stdint.h>

typedef struct {
  CpldAdcValues adc;
  uint32_t update_tick;
} InputValues;

void Input_Task(void *argument);
void Input_GetSnapshot(InputValues *values);

#endif
