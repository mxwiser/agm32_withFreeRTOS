#ifndef USER_CPLD_ADC_H
#define USER_CPLD_ADC_H

#include <stdint.h>

typedef struct {
  uint16_t adc1_raw;
  uint16_t adc2_raw;
  uint8_t adc1_percent;
  uint8_t adc2_percent;
  uint8_t valid_mask; /* bit 0: ADC1, bit 1: ADC2 */
} CpldAdcValues;

/* Written by the LVGL task; use a queue or synchronized snapshot across tasks. */
extern volatile CpldAdcValues cpld_adc_values;
void CpldAdc_Poll(void);

#endif
