#ifndef USER_MATH_PPM_MIX_H
#define USER_MATH_PPM_MIX_H

#include <stdint.h>

#define PPM_THROTTLE_WEIGHT 1.0f
#define PPM_BRAKE_WEIGHT 1.5f

/* Normalize a filtered ADC count to [0, 1], including endpoint clamping. */
float Ppm_NormalizeAdc(uint16_t sample, uint16_t min, uint16_t max);
/* Positive throttle and negative brake contributions; result is in [-1, 1]. */
float Ppm_MixNormalized(float throttle, float brake);

#endif
