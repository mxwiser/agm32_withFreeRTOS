#include "vesc_speed.h"
#include <limits.h>
#include <stddef.h>

bool VescSpeed_FromErpm(int32_t erpm, uint32_t pole_pairs, uint32_t wheel_mm,
                        uint32_t motor_turns, uint32_t wheel_turns, int16_t *kmh)
{
  /* 限制参数范围，使最坏情况下的整数运算不会溢出。 */
  if (kmh == NULL || pole_pairs == 0U || pole_pairs > 1000U ||
      wheel_mm == 0U || wheel_mm > 10000U || motor_turns == 0U ||
      motor_turns > 1000U || wheel_turns == 0U || wheel_turns > 1000U)
    return false;

  int64_t signed_erpm = erpm;
  uint64_t magnitude = (uint64_t)(signed_erpm < 0 ? -signed_erpm : signed_erpm);
  uint64_t numerator = magnitude * wheel_mm * wheel_turns * 60U;
  uint64_t denominator = (uint64_t)pole_pairs * motor_turns * 1000000U;
  uint64_t rounded = (numerator + denominator / 2U) / denominator;
  if (signed_erpm < 0) {
    *kmh = rounded >= 32768U ? INT16_MIN : (int16_t)-(int32_t)rounded;
  } else {
    *kmh = rounded > INT16_MAX ? INT16_MAX : (int16_t)rounded;
  }
  return true;
}
