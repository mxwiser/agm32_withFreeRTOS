#ifndef USER_BATTERY_H
#define USER_BATTERY_H

#include <stdint.h>
#include "config/battery_config.h"

#define BATTERY_DEMO_MIN_TENTHS_V ((BATTERY_SERIES_CELLS * BATTERY_DISPLAY_EMPTY_CELL_MV + 99U) / 100U)
#define BATTERY_DEMO_MAX_TENTHS_V ((BATTERY_SERIES_CELLS * BATTERY_FULL_CELL_MV) / 100U)

/* Approximate relaxed-voltage display estimate, not a protection threshold. */
uint8_t Battery_EstimatePercent(uint16_t pack_voltage_tenths_v);

#endif
