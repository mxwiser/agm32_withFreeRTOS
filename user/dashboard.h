#ifndef USER_DASHBOARD_H
#define USER_DASHBOARD_H

#include <stdbool.h>
#include <stdint.h>
#include "lvgl.h"

/* Speed is signed km/h (negative = reverse). Voltage/current use tenths of
 * V/A. Positive current/power means discharge; negative means charging/regen. */
typedef struct {
  int16_t current_speed_kmh;
  uint8_t battery_percent;
  uint16_t voltage_tenths_v;
  int16_t current_tenths_a;
  int32_t power_w;
  int16_t controller_temperature_c; /* Controller temperature, whole degrees C. */
  uint8_t brake_percent;
  uint8_t throttle_percent;
  uint8_t adc_valid_mask; /* bit 0: brake / ADC1, bit 1: throttle / ADC2 */
} DashboardData;

/* Only the LVGL task may modify these values or call the UI functions. */
extern DashboardData dashboard_data;
bool Dashboard_Create(lv_obj_t *screen);
void Dashboard_Refresh(const DashboardData *data);

#endif
