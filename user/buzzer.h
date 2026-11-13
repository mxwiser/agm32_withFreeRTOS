#ifndef USER_BUZZER_H
#define USER_BUZZER_H

#include <stdbool.h>
#include <stdint.h>
#include "config/buzzer_config.h"

/* Called from main after board_init(), before starting the scheduler. */
bool Buzzer_Init(void);

/* Non-blocking task-context request; 0 stops sound. New requests replace old ones. */
bool buzzerd(uint32_t duration_ms);

#endif
