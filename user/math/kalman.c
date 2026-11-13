#include "kalman.h"

void Kalman1D_Init(Kalman1D *filter, float q, float r)
{
  filter->estimate = 0.0f;
  filter->covariance = 0.0f;
  filter->process_noise = q >= 0.0f ? q : 0.0f;
  filter->measurement_noise = r > 0.0f ? r : 1.0f;
  filter->initialized = false;
}

uint16_t Kalman1D_Update(Kalman1D *filter, uint16_t measurement)
{
  if (!filter->initialized) {
    filter->estimate = (float)measurement;
    filter->covariance = filter->measurement_noise;
    filter->initialized = true;
    return measurement;
  }

  /* P- = P + Q; K = P- / (P- + R); x = x + K(z - x). */
  float predicted = filter->covariance + filter->process_noise;
  float gain = predicted / (predicted + filter->measurement_noise);
  filter->estimate += gain * ((float)measurement - filter->estimate);
  filter->covariance = (1.0f - gain) * predicted;
  return (uint16_t)(filter->estimate + 0.5f);
}
