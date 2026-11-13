#ifndef USER_BATTERY_H
#define USER_BATTERY_H

#include <stdint.h>
#include "config/battery_config.h"

/* Approximate relaxed-voltage display estimate, not a protection threshold. */
uint8_t Battery_EstimatePercent(uint16_t pack_voltage_tenths_v, uint8_t series_cells);

#endif
