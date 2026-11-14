#include "battery.h"
#include <stddef.h>

typedef struct {
  uint16_t cell_mv;
  uint8_t percent;
} BatteryPoint;

/* Provisional UI curve, not a measured capacity curve for the user's pack.
 * Replace/calibrate these points or supply BMS SOC when real data is connected.
 * Cell chemistry, temperature and current-induced sag affect the estimate.
 */
static const BatteryPoint display_curve[] = {
  {BATTERY_DISPLAY_EMPTY_CELL_MV, 0},
  {3500, 5},
  {3700, 20},
  {3800, 40},
  {3900, 60},
  {4050, 80},
  {BATTERY_FULL_CELL_MV, 100},
};

bool Battery_IsTypeSupported(uint8_t battery_type)
{
  return battery_type <= BATTERY_TYPE_LEAD_ACID;
}

uint8_t Battery_EstimatePercent(uint16_t pack_voltage_tenths_v, uint8_t series_cells,
                                uint8_t battery_type)
{
  if (series_cells == 0U || series_cells > BATTERY_MAX_SERIES_CELLS ||
      !Battery_IsTypeSupported(battery_type)) return 0U;
  uint32_t pack_mv = (uint32_t)pack_voltage_tenths_v * 100U;
  if (battery_type != BATTERY_TYPE_LIION) {
    /* Provisional linear display ranges, matching the VESC type conventions.
     * LiFePO4's flat plateau makes voltage-only SOC particularly approximate. */
    uint32_t empty = (battery_type == BATTERY_TYPE_LIFEPO4 ?
                      BATTERY_LIFEPO4_EMPTY_CELL_MV : BATTERY_LEAD_EMPTY_CELL_MV) * series_cells;
    uint32_t full = (battery_type == BATTERY_TYPE_LIFEPO4 ?
                     BATTERY_LIFEPO4_FULL_CELL_MV : BATTERY_LEAD_FULL_CELL_MV) * series_cells;
    if (pack_mv <= empty) return 0U;
    if (pack_mv >= full) return 100U;
    return (uint8_t)((pack_mv - empty) * 100U / (full - empty));
  }
  if (pack_mv <= (uint32_t)display_curve[0].cell_mv * series_cells)
    return 0;

  for (size_t i = 1; i < sizeof(display_curve) / sizeof(display_curve[0]); ++i) {
    uint32_t high = (uint32_t)display_curve[i].cell_mv * series_cells;
    if (pack_mv < high) {
      uint32_t low = (uint32_t)display_curve[i - 1].cell_mv * series_cells;
      uint32_t delta_percent = display_curve[i].percent - display_curve[i - 1].percent;
      return (uint8_t)(display_curve[i - 1].percent +
                      (pack_mv - low) * delta_percent / (high - low));
    }
  }
  return 100;
}
