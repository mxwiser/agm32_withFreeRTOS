#ifndef USER_INPUT_TASK_H
#define USER_INPUT_TASK_H

#include "cpld_adc.h"

typedef struct {
  CpldAdcValues adc;
} InputValues;

void Input_Task(void *argument);
void Input_GetSnapshot(InputValues *values);

#endif
