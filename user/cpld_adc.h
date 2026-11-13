#ifndef USER_CPLD_ADC_H
#define USER_CPLD_ADC_H

#include <stdint.h>

/* Example calibration: adjust each channel to the measured raw endpoints. */
#define ADC1_RAW_MIN 1000U
#define ADC1_RAW_MAX 2000U
#define ADC2_RAW_MIN 1000U
#define ADC2_RAW_MAX 2000U
#define CPLD_ADC_RAW_MAX 4095U

/* Variances in ADC-count-squared units. Q >= 0; R > 0. */
#define ADC1_KALMAN_Q 0.0625f
#define ADC1_KALMAN_R 25.0f
#define ADC2_KALMAN_Q 0.0625f
#define ADC2_KALMAN_R 25.0f

#if ADC1_RAW_MIN < 0 || ADC1_RAW_MIN >= ADC1_RAW_MAX || ADC1_RAW_MAX > CPLD_ADC_RAW_MAX
#error "ADC1 calibration must satisfy 0 <= MIN < MAX <= 4095"
#endif
#if ADC2_RAW_MIN < 0 || ADC2_RAW_MIN >= ADC2_RAW_MAX || ADC2_RAW_MAX > CPLD_ADC_RAW_MAX
#error "ADC2 calibration must satisfy 0 <= MIN < MAX <= 4095"
#endif

/* Saturating linear conversion to whole percent, rounded to nearest. */
static inline uint8_t CpldAdc_NormalizePercent(uint16_t raw, uint16_t min, uint16_t max)
{
  if (max <= min || raw <= min) return 0U;
  if (raw >= max) return 100U;
  uint32_t span = (uint32_t)max - min;
  return (uint8_t)((((uint32_t)raw - min) * 100U + span / 2U) / span);
}

typedef struct {
  uint16_t adc1_raw;
  uint16_t adc2_raw;
  uint16_t adc1_filtered;
  uint16_t adc2_filtered;
  uint8_t adc1_percent;
  uint8_t adc2_percent;
  uint8_t valid_mask; /* bit 0: ADC1, bit 1: ADC2 */
} CpldAdcValues;

/* Written by the ADC task; use CpldAdc_GetSnapshot() from other tasks. */
extern volatile CpldAdcValues cpld_adc_values;
void CpldAdc_Poll(void);
void CpldAdc_GetSnapshot(CpldAdcValues *values);

#endif
