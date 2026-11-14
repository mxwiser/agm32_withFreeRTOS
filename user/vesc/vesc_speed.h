#ifndef USER_VESC_SPEED_H
#define USER_VESC_SPEED_H

#include <stdint.h>

/* VESC mm/s 转为有符号整数 km/h，四舍五入并限制到 int16_t 范围。 */
int16_t VescSpeed_FromMmPerSecond(int32_t speed_mm_per_second);

#endif
