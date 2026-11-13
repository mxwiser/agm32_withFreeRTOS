#include "buzzer.h"
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"

static TaskHandle_t buzzer_task;
static uint32_t buzzer_compare;

bool buzzerd(uint32_t duration_ms)
{
  if (buzzer_task == NULL) return false;
  return xTaskNotify(buzzer_task, duration_ms, eSetValueWithOverwrite) == pdPASS;
}

static TickType_t duration_ticks(uint32_t ms)
{
  uint64_t ticks = ((uint64_t)ms * configTICK_RATE_HZ + 999U) / 1000U;
  if (ticks >= portMAX_DELAY) ticks = portMAX_DELAY - 1U;
  return (TickType_t)(ticks == 0U ? 1U : ticks);
}

static void buzzer_task_main(void *argument)
{
  (void)argument;
  (void)buzzerd(BUZZER_STARTUP_MS);
  for (;;) {
    uint32_t duration_ms;
    (void)xTaskNotifyWait(0, UINT32_MAX, &duration_ms, portMAX_DELAY);
    while (duration_ms != 0U) {
      GPTIMER_OC_SetCompare(GPTIMER4, GPTIMER_CHANNEL_CH0, buzzer_compare);
      /* A new request restarts the timer; 0 silences it immediately. */
      if (xTaskNotifyWait(0, UINT32_MAX, &duration_ms,
                          duration_ticks(duration_ms)) != pdTRUE) break;
    }
    GPTIMER_OC_SetCompare(GPTIMER4, GPTIMER_CHANNEL_CH0, 0);
  }
}

bool Buzzer_Init(void)
{
  SYS_EnableAPBClock(APB_MASK_GPIO3 | APB_MASK_GPTIMER4);
  /* PIN_45 is GPTIMER4_CH0 / GPIO3_0. Hold the transistor off while configuring. */
  GPIO_SetSoftwareMode(GPIO3, GPIO_BIT0);
  GPIO_SetLow(GPIO3, GPIO_BIT0);
  GPIO_SetOutput(GPIO3, GPIO_BIT0);

  uint32_t timer_hz = SYS_GetPclkFreq() / 2U;
  uint32_t period = (timer_hz + BUZZER_FREQUENCY_HZ / 2U) / BUZZER_FREQUENCY_HZ;
  if (period < 2U || period > 65536U) return false;
  buzzer_compare = period / 2U;

  GPTIMER_InitTypeDef timer_init;
  GPTIMER_StructInit(&timer_init);
  timer_init.Prescaler = 1U;
  timer_init.Autoreload = period - 1U;
  if (GPTIMER_Init(GPTIMER4, &timer_init) != RET_OK) return false;

  GPTIMER_OC_InitTypeDef channel_init;
  GPTIMER_OC_StructInit(&channel_init);
  channel_init.OCState = GPTIMER_OCSTATE_ENABLE;
  channel_init.OCMode = GPTIMER_OCMODE_PWM1;
  channel_init.CompareValue = 0;
  GPTIMER_OC_Init(GPTIMER4, GPTIMER_CHANNEL_CH0, &channel_init);
  GPTIMER_OC_DisablePreload(GPTIMER4, GPTIMER_CHANNEL_CH0);
  GPTIMER_EnableAllOutputs(GPTIMER4);
  GPTIMER_EnableCounter(GPTIMER4);
  GPIO_AF_ENABLE(GPTIMER4_CH0);

  return xTaskCreate(buzzer_task_main, "BUZZER", configMINIMAL_STACK_SIZE,
                     NULL, tskIDLE_PRIORITY + 1, &buzzer_task) == pdPASS;
}
