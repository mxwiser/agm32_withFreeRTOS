#include "ppm_control.h"
#include "ppm_mix.h"

float PpmControl_Update(PpmControl *control, uint32_t now, bool locked,
                        bool inputs_ready, bool released, float throttle, float brake)
{
  if (control->state == PPM_CONTROL_FAULT) return 0.0f;
  if (locked) {
    control->state = PPM_CONTROL_WAITING;
    control->neutral_tracking = false;
    return 0.0f;
  }
  if (!inputs_ready) {
    if (control->state == PPM_CONTROL_ACTIVE) control->state = PPM_CONTROL_FAULT;
    control->neutral_tracking = false;
    return 0.0f;
  }
  if (control->state == PPM_CONTROL_WAITING) {
    if (!released) control->neutral_tracking = false;
    else if (!control->neutral_tracking) {
      control->neutral_tracking = true;
      control->neutral_since = now;
    } else if ((uint32_t)(now - control->neutral_since) >= PPM_NEUTRAL_ARM_MS) {
      control->state = PPM_CONTROL_ACTIVE;
    }
  }
  return control->state == PPM_CONTROL_ACTIVE ? Ppm_MixNormalized(throttle, brake) : 0.0f;
}
