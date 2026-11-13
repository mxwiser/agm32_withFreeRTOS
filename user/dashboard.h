#ifndef USER_DASHBOARD_H
#define USER_DASHBOARD_H

#include <stdbool.h>
#include <stdint.h>
#include "lvgl.h"

/* Temporary values. Voltage and current use tenths of V and A, respectively. */
typedef struct {
  uint8_t current_speed_kmh;
  uint8_t battery_percent;
  uint16_t voltage_tenths_v;
  uint16_t current_tenths_a;
  uint16_t power_w;
  uint8_t brake_percent;
  uint8_t throttle_percent;
} DashboardData;

/* Only the LVGL task may modify these values or call the UI functions. */
extern DashboardData dashboard_data;
bool Dashboard_Create(lv_obj_t *screen);
void Dashboard_Refresh(const DashboardData *data);

#endif
