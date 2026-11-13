#ifndef USER_VESC_SPEED_H
#define USER_VESC_SPEED_H

#include <stdbool.h>
#include <stdint.h>

/* 电气转速和传动参数换算为有符号整数 km/h；参数不完整时返回 false。 */
bool VescSpeed_FromErpm(int32_t erpm, uint32_t pole_pairs, uint32_t wheel_mm,
                        uint32_t motor_turns, uint32_t wheel_turns, int16_t *kmh);

#endif
