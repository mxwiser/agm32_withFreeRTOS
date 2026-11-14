#include "ppm_output.h"
#include "ppm_mix.h"
#include "config/ppm_config.h"
#include "board.h"

volatile bool ppm_watchdog_reset_detected;

bool PpmOutput_Init(void)
{
  /* 看门狗复位后不再自动重试，避免故障时反复启动电机。 */
  ppm_watchdog_reset_detected = SYS_IsActiveResetFlag_WDOG();
  SYS_ClearResetFlags();
  SYS_EnableAPBClock(APB_MASK_GPIO1 | APB_MASK_GPTIMER0 | APB_MASK_WATCHDOG0);
  PpmOutput_WatchdogStop();
  GPIO_SetSoftwareMode(GPIO1, GPIO_BIT0);
  GPIO_SetLow(GPIO1, GPIO_BIT0);
  GPIO_SetOutput(GPIO1, GPIO_BIT0);

  uint32_t pclk = SYS_GetPclkFreq();
  if (pclk < 1000000U || pclk % 1000000U != 0U || pclk / 1000000U > 65536U)
    return false;

  GPTIMER_InitTypeDef init;
  GPTIMER_StructInit(&init);
  init.Prescaler = pclk / 1000000U - 1U;
  init.Autoreload = PPM_FRAME_PERIOD_US - 1U;
  if (GPTIMER_Init(GPTIMER0, &init) != RET_OK) return false;
  GPTIMER_OC_InitTypeDef channel;
  GPTIMER_OC_StructInit(&channel);
  channel.OCState = GPTIMER_OCSTATE_ENABLE;
  channel.OCMode = GPTIMER_OCMODE_PWM1;
  channel.CompareValue = PPM_PULSE_CENTER_US;
  GPTIMER_OC_Init(GPTIMER0, GPTIMER_CHANNEL_CH0, &channel);
  /* Commit changes on the next 20 ms frame to avoid a second pulse mid-frame. */
  GPTIMER_OC_EnablePreload(GPTIMER0, GPTIMER_CHANNEL_CH0);
  GPTIMER_GenerateEventUpdate(GPTIMER0);
  GPTIMER_EnableAllOutputs(GPTIMER0);
  GPTIMER_EnableCounter(GPTIMER0);
  GPIO_AF_ENABLE(GPTIMER0_CH0);
  return true;
}

void PpmOutput_SetNormalized(float normalized)
{
  GPTIMER_OC_SetCompare(GPTIMER0, GPTIMER_CHANNEL_CH0, Ppm_PulseWidthUs(normalized));
}

void PpmOutput_WatchdogStart(void)
{
  SYS_DisableAPBClkStop(APB_MASK_WATCHDOG0);
  WDOG_InitMS(PPM_WATCHDOG_MS);
}

void PpmOutput_WatchdogFeed(void)
{
  WDOG_Feed();
}

void PpmOutput_WatchdogStop(void)
{
  WDOG_UnLock();
  WDOG->WdogControl = 0;
  WDOG_Lock();
}
