#ifndef USER_PPM_CONTROL_H
#define USER_PPM_CONTROL_H

#include <stdbool.h>
#include <stdint.h>

typedef enum {
  PPM_CONTROL_WAITING = 0,
  PPM_CONTROL_ACTIVE = 1,
  PPM_CONTROL_FAULT = 2
} PpmControlState;

typedef struct {
  PpmControlState state;
  bool neutral_tracking;
  uint32_t neutral_since;
} PpmControl;

/* now is a millisecond RTOS tick; fault is latched until reset. */
float PpmControl_Update(PpmControl *control, uint32_t now, bool locked,
                        bool inputs_ready, bool released, float throttle, float brake);

#endif
