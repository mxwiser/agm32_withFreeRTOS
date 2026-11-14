#include "battery.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
  assert(Battery_EstimatePercent(546, 13, BATTERY_TYPE_LIION) == 100);
  assert(Battery_EstimatePercent(481, 13, BATTERY_TYPE_LIION) == 20);
  assert(Battery_EstimatePercent(525, 13, BATTERY_TYPE_LIION) == 78);
  assert(Battery_EstimatePercent(416, 16, BATTERY_TYPE_LIFEPO4) == 0);
  assert(Battery_EstimatePercent(496, 16, BATTERY_TYPE_LIFEPO4) == 50);
  assert(Battery_EstimatePercent(576, 16, BATTERY_TYPE_LIFEPO4) == 100);
  assert(Battery_EstimatePercent(252, 12, BATTERY_TYPE_LEAD_ACID) == 0);
  assert(Battery_EstimatePercent(2832, 120, BATTERY_TYPE_LEAD_ACID) == 0); /* invalid cells */
  assert(Battery_EstimatePercent(284, 12, BATTERY_TYPE_LEAD_ACID) == 100);
  assert(!Battery_IsTypeSupported(3));
  assert(Battery_EstimatePercent(500, 0, BATTERY_TYPE_LIION) == 0);
  assert(Battery_EstimatePercent(500, 13, 255) == 0);
  for (uint8_t type = 0; type < 3; ++type) {
    uint8_t previous = 0;
    for (uint16_t voltage = 0; voltage < 1500; ++voltage) {
      uint8_t percent = Battery_EstimatePercent(voltage, 13, type);
      assert(percent >= previous && percent <= 100);
      previous = percent;
    }
  }
  puts("Battery estimates passed.");
  return 0;
}
