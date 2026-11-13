#include "cpld_adc.h"

#define CPLD_ADC_BASE 0x60000000UL
#define CPLD_ADC_REG(index) (*(volatile const uint32_t *)(CPLD_ADC_BASE + 4UL * (index)))
#define CPLD_ADC_MAX 4095U

volatile CpldAdcValues cpld_adc_values;

static uint8_t adc_percent(uint32_t sample)
{
  return (uint8_t)((sample * 100U + CPLD_ADC_MAX / 2U) / CPLD_ADC_MAX);
}

void CpldAdc_Poll(void)
{
  uint32_t valid = CPLD_ADC_REG(0) & 3U;
  if (valid & 1U) {
    uint32_t raw = CPLD_ADC_REG(1) & CPLD_ADC_MAX;
    cpld_adc_values.adc1_raw = (uint16_t)raw;
    cpld_adc_values.adc1_percent = adc_percent(raw);
  }
  if (valid & 2U) {
    uint32_t raw = CPLD_ADC_REG(2) & CPLD_ADC_MAX;
    cpld_adc_values.adc2_raw = (uint16_t)raw;
    cpld_adc_values.adc2_percent = adc_percent(raw);
  }
  cpld_adc_values.valid_mask = (uint8_t)valid;
}
