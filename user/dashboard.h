#ifndef USER_DASHBOARD_H
#define USER_DASHBOARD_H

#include <stdbool.h>
#include <stdint.h>
#include "lvgl.h"

/* Speed is signed km/h (negative = reverse). Voltage/current use tenths of
 * V/A. Positive current/power means discharge; negative means charging/regen. */
typedef struct {
  int16_t current_speed_kmh;
  bool speed_valid; /* false: VESC 离线或车速换算参数未配置。 */
  uint8_t battery_percent;
  bool electrical_valid; /* false：电压、电流、功率和电量均无有效数据。 */
  uint16_t voltage_tenths_v;
  int16_t current_tenths_a;
  int32_t power_w;
  int16_t controller_temperature_c; /* Controller temperature, whole degrees C. */
  bool controller_temperature_valid; /* false：VESC 未在线。 */
  uint8_t brake_percent;
  uint8_t throttle_percent;
  int16_t ppm_throttle_percent; /* -100..100: negative brake, positive drive. */
  bool ppm_valid;
  bool vehicle_locked;
  uint8_t adc_valid_mask; /* bit 0: brake / ADC1, bit 1: throttle / ADC2 */
} DashboardData;

/* Only the LVGL task may modify these values or call the UI functions. */
extern DashboardData dashboard_data;
bool Dashboard_Create(lv_obj_t *screen);
void Dashboard_Refresh(const DashboardData *data);

#endif
