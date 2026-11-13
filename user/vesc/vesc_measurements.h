#ifndef USER_VESC_MEASUREMENTS_H
#define USER_VESC_MEASUREMENTS_H

#include "vesc_protocol.h"

typedef struct {
  uint16_t voltage_tenths_v;
  int16_t current_tenths_a;
  int32_t power_w;
} VescElectricalValues;

/* 将同一帧的输入电压、电流换算为界面值及有符号输入功率。 */
void VescElectrical_Convert(const VescTelemetry *telemetry, VescElectricalValues *values);
/* MOS 温度由 0.1 ℃ 四舍五入为整数 ℃，支持负温度。 */
int16_t VescTemperature_WholeCelsius(int16_t tenths_c);

#endif
