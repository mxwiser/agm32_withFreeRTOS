#ifndef USER_PPM_OUTPUT_H
#define USER_PPM_OUTPUT_H

#include <stdbool.h>
#include <stdint.h>

/* 调试器可查看本次是否由 PPM 测试看门狗复位启动。 */
extern volatile bool ppm_watchdog_reset_detected;
bool PpmOutput_Init(void);
bool PpmOutput_TestAllowed(void);
void PpmOutput_SetTestActive(bool active);
void PpmOutput_WatchdogStart(void);
void PpmOutput_WatchdogFeed(void);
void PpmOutput_WatchdogStop(void);

#endif
