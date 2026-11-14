#include "cpld_adc.h"
#include "FreeRTOS.h"
#include "task.h"
#include "math/kalman.h"

#define CPLD_ADC_BASE 0x60000000UL
#define CPLD_ADC_REG(index) (*(volatile const uint32_t *)(CPLD_ADC_BASE + 4UL * (index)))
volatile CpldAdcValues cpld_adc_values;
static Kalman1D adc1_filter;
static Kalman1D adc2_filter;
static bool filters_initialized;

void CpldAdc_Poll(void)
{
  if (!filters_initialized) {
    Kalman1D_Init(&adc1_filter, ADC1_KALMAN_Q, ADC1_KALMAN_R);
    Kalman1D_Init(&adc2_filter, ADC2_KALMAN_Q, ADC2_KALMAN_R);
    filters_initialized = true;
  }
  uint32_t status = CPLD_ADC_REG(0);
  uint32_t valid = status & 3U;
  cpld_adc_values.adc1_sequence = (uint16_t)((status >> 2) & 0x7fffU);
  cpld_adc_values.adc2_sequence = (uint16_t)((status >> 17) & 0x7fffU);
  if (valid & 1U) {
    uint32_t raw = CPLD_ADC_REG(1) & CPLD_ADC_RAW_MAX;
    uint16_t filtered = Kalman1D_Update(&adc1_filter, (uint16_t)raw);
    cpld_adc_values.adc1_raw = (uint16_t)raw;
    cpld_adc_values.adc1_filtered = filtered;
    cpld_adc_values.adc1_percent = CpldAdc_NormalizePercent(filtered, ADC1_RAW_MIN, ADC1_RAW_MAX);
  }
  if (valid & 2U) {
    uint32_t raw = CPLD_ADC_REG(2) & CPLD_ADC_RAW_MAX;
    uint16_t filtered = Kalman1D_Update(&adc2_filter, (uint16_t)raw);
    cpld_adc_values.adc2_raw = (uint16_t)raw;
    cpld_adc_values.adc2_filtered = filtered;
    cpld_adc_values.adc2_percent = CpldAdc_NormalizePercent(filtered, ADC2_RAW_MIN, ADC2_RAW_MAX);
  }
  cpld_adc_values.valid_mask = (uint8_t)valid;
}

void CpldAdc_GetSnapshot(CpldAdcValues *values)
{
  if (values == NULL) return;
  taskENTER_CRITICAL();
  values->adc1_raw = cpld_adc_values.adc1_raw;
  values->adc2_raw = cpld_adc_values.adc2_raw;
  values->adc1_filtered = cpld_adc_values.adc1_filtered;
  values->adc2_filtered = cpld_adc_values.adc2_filtered;
  values->adc1_sequence = cpld_adc_values.adc1_sequence;
  values->adc2_sequence = cpld_adc_values.adc2_sequence;
  values->adc1_percent = cpld_adc_values.adc1_percent;
  values->adc2_percent = cpld_adc_values.adc2_percent;
  values->valid_mask = cpld_adc_values.valid_mask;
  taskEXIT_CRITICAL();
}
