#include "battery.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
  assert(Battery_EstimatePercent(0) == 0);
  assert(Battery_EstimatePercent(BATTERY_DEMO_MIN_TENTHS_V) == 0);
  assert(Battery_EstimatePercent(BATTERY_DEMO_MAX_TENTHS_V) == 100);
  assert(Battery_EstimatePercent(UINT16_MAX) == 100);

  uint8_t previous = 0;
  for (uint16_t voltage = 0; voltage <= 700; ++voltage) {
    uint8_t percent = Battery_EstimatePercent(voltage);
    assert(percent >= previous && percent <= 100);
    previous = percent;
  }

#if BATTERY_SERIES_CELLS == 13U
  assert(Battery_EstimatePercent(481) == 20);
  assert(Battery_EstimatePercent(480) < BATTERY_LOW_PERCENT);
  assert(Battery_EstimatePercent(482) >= BATTERY_LOW_PERCENT);
  assert(Battery_EstimatePercent(546) == 100);
  assert(Battery_EstimatePercent(525) == 78);
#endif
  puts("Battery estimate: endpoints, interpolation, monotonicity and low threshold passed.");
  return 0;
}
