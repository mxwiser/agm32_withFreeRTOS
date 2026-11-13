#ifndef USER_BATTERY_H
#define USER_BATTERY_H

#include <stdint.h>

/* Provisional 48 V LiPo display model: confirm against the pack/charger label. */
#ifndef BATTERY_SERIES_CELLS
#define BATTERY_SERIES_CELLS 13U
#endif

#define BATTERY_LOW_PERCENT 20U
#define BATTERY_DISPLAY_EMPTY_CELL_MV 3300U
#define BATTERY_FULL_CELL_MV 4200U
#define BATTERY_DEMO_MIN_TENTHS_V ((BATTERY_SERIES_CELLS * BATTERY_DISPLAY_EMPTY_CELL_MV + 99U) / 100U)
#define BATTERY_DEMO_MAX_TENTHS_V ((BATTERY_SERIES_CELLS * BATTERY_FULL_CELL_MV) / 100U)

/* Approximate relaxed-voltage display estimate, not a protection threshold. */
uint8_t Battery_EstimatePercent(uint16_t pack_voltage_tenths_v);

#endif
