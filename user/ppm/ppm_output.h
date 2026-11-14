#ifndef USER_PPM_OUTPUT_H
#define USER_PPM_OUTPUT_H

#include <stdbool.h>
#include <stdint.h>

/* 调试器可查看本次是否由看门狗复位启动。 */
extern volatile bool ppm_watchdog_reset_detected;
bool PpmOutput_Init(void);
void PpmOutput_SetNormalized(float normalized);
void PpmOutput_WatchdogStart(void);
void PpmOutput_WatchdogFeed(void);
void PpmOutput_WatchdogStop(void);

#endif
