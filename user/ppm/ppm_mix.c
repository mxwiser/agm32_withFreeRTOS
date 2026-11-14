#include "ppm_mix.h" /* PPM input normalization and mixing. */

float Ppm_NormalizeAdc(uint16_t sample, uint16_t min, uint16_t max)
{
  if (max <= min || sample <= min) return 0.0f;
  if (sample >= max) return 1.0f;
  return (float)(sample - min) / (float)(max - min);
}

float Ppm_MixNormalized(float throttle, float brake)
{
  if (throttle < 0.0f) throttle = 0.0f;
  if (throttle > 1.0f) throttle = 1.0f;
  if (brake < 0.0f) brake = 0.0f;
  if (brake > 1.0f) brake = 1.0f;
  float value = PPM_THROTTLE_WEIGHT * throttle - PPM_BRAKE_WEIGHT * brake;
  if (value < -1.0f) return -1.0f;
  if (value > 1.0f) return 1.0f;
  return value;
}

uint16_t Ppm_PulseWidthUs(float normalized)
{
  if (normalized < -1.0f) normalized = -1.0f;
  if (normalized > 1.0f) normalized = 1.0f;
  float width = (float)PPM_PULSE_CENTER_US;
  if (normalized >= 0.0f)
    width += normalized * (float)(PPM_PULSE_MAX_US - PPM_PULSE_CENTER_US);
  else
    width += normalized * (float)(PPM_PULSE_CENTER_US - PPM_PULSE_MIN_US);
  return (uint16_t)(width + 0.5f);
}
