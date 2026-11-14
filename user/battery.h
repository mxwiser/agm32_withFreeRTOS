#ifndef USER_BATTERY_H
#define USER_BATTERY_H

#include <stdint.h>
#include "config/battery_config.h"
#include <stdbool.h>

/* Approximate relaxed-voltage display estimate, not a protection threshold. */
/* Values match the VESC BATTERY_TYPE enum. */
#define BATTERY_TYPE_LIION 0U
#define BATTERY_TYPE_LIFEPO4 1U
#define BATTERY_TYPE_LEAD_ACID 2U
bool Battery_IsTypeSupported(uint8_t battery_type);
uint8_t Battery_EstimatePercent(uint16_t pack_voltage_tenths_v, uint8_t series_cells,
                                uint8_t battery_type);

#endif
