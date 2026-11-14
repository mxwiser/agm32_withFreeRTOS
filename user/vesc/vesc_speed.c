#include "vesc_speed.h"
#include <limits.h>

int16_t VescSpeed_FromMmPerSecond(int32_t speed_mm_per_second)
{
  int64_t speed = speed_mm_per_second;
  uint64_t magnitude = (uint64_t)(speed < 0 ? -speed : speed);
  uint64_t rounded_kmh = (magnitude * 36U + 5000U) / 10000U;
  if (speed < 0)
    return rounded_kmh >= 32768U ? INT16_MIN : (int16_t)-(int32_t)rounded_kmh;
  return rounded_kmh > INT16_MAX ? INT16_MAX : (int16_t)rounded_kmh;
}
