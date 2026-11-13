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
