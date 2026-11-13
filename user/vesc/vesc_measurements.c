#include "vesc_measurements.h"
#include <limits.h>
#include <stddef.h>

static int64_t round_divide(int64_t value, int32_t divisor)
{
  return value < 0 ? -((-value + divisor / 2) / divisor)
                   : (value + divisor / 2) / divisor;
}

int16_t VescTemperature_WholeCelsius(int16_t tenths_c)
{
  return (int16_t)round_divide(tenths_c, 10);
}

void VescElectrical_Convert(const VescTelemetry *telemetry, VescElectricalValues *values)
{
  if (telemetry == NULL || values == NULL) return;
  int64_t current = round_divide(telemetry->input_current_hundredths_a, 10);
  if (current > INT16_MAX) current = INT16_MAX;
  if (current < INT16_MIN) current = INT16_MIN;

  /* 0.1 V × 0.01 A = 0.001 W；使用完整电流精度再四舍五入。 */
  int64_t power = round_divide((int64_t)telemetry->input_voltage_tenths_v *
                               telemetry->input_current_hundredths_a, 1000);
  if (power > INT32_MAX) power = INT32_MAX;
  if (power < INT32_MIN) power = INT32_MIN;

  values->voltage_tenths_v = telemetry->input_voltage_tenths_v;
  values->current_tenths_a = (int16_t)current;
  values->power_w = (int32_t)power;
}
