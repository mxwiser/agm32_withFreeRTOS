#ifndef USER_MATH_KALMAN_H
#define USER_MATH_KALMAN_H

#include <stdbool.h>
#include <stdint.h>

/* Scalar random-walk filter using single-precision floating point. */
typedef struct {
  float estimate;
  float covariance;
  float process_noise;
  float measurement_noise;
  bool initialized;
} Kalman1D;

/* Q >= 0, R > 0. The first measurement initializes the estimate directly. */
void Kalman1D_Init(Kalman1D *filter, float q, float r);
uint16_t Kalman1D_Update(Kalman1D *filter, uint16_t measurement);

#endif
