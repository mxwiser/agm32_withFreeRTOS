#include "board.h"

__attribute__((weak))
SYS_HSE_BypassTypeDef board_hse_source(void)
{
#ifdef BOARD_HSE_BYPASS
  return BOARD_HSE_BYPASS;
#else
  return SYS_HSE_BYPASS_OFF;
#endif
}

__attribute__((weak))
RTC_ClkSourceTypeDef board_rtc_source(void)
{
#ifdef BOARD_RTC_SOURCE
  return BOARD_RTC_SOURCE;
#else
  return RTC_CLK_SOURCE_LSE;
#endif
}

uint32_t board_lse_freq(void)
{
#ifdef BOARD_LSE_FREQ
  return BOARD_LSE_FREQ;
#else
  return 32768;
#endif
}

uint32_t board_pll_clkin_freq(void)
{
#ifdef BOARD_PLL_CLKIN_FREQ
  return BOARD_PLL_CLKIN_FREQ;
#else
  return SYS_GetHSEFreq();
#endif
}

__attribute__((weak)) uint32_t FCB_GetPLLFreq(uint32_t clkin_freq);
__attribute__((weak)) void board_init(void)
{
  PERIPHERAL_ENABLE(DMAC, 0);
  DMAC_Init();

  if (FCB_GetPLLFreq) {
    uint32_t freq = BOARD_PLL_FREQUENCY;
    SYS_EnableAPBClock(APB_MASK_FCB0);
    if (FCB_IsActive()) {
      freq = FCB_GetPLLFreq(board_pll_clkin_freq());
    } else {
      FCB_Activate();
    }
    SYS_SetPLLFreq(freq);
  }
  SYS_SwitchPLLClock(board_hse_source());

  INT_Init(); // This will disabe all interrupts. INT_EnableIRQ should be called after this to enable any external interrupt.
  INT_EnableIntGlobal();
  INT_EnableIntExternal();

  // Enable LED_GPIO and EXT_GPIO to drive LED's on board
  SYS_EnableAPBClock(LED_GPIO_MASK);
  GPIO_SetOutput(LED_GPIO, LED_GPIO_BITS);
  GPIO_SetHigh(LED_GPIO, LED_GPIO_BITS);

  // J6 display backlight: set the level before enabling the output.
  SYS_EnableAPBClock(LCD_BLK_GPIO_MASK);
  GPIO_SetSoftwareMode(LCD_BLK_GPIO, LCD_BLK_GPIO_BITS);
  GPIO_SetHigh(LCD_BLK_GPIO, LCD_BLK_GPIO_BITS);
  GPIO_SetOutput(LCD_BLK_GPIO, LCD_BLK_GPIO_BITS);

  SYS_EnableAPBClock(EXT_GPIO_MASK);
  GPIO_SetOutput(EXT_GPIO, EXT_GPIO_BITS);
  GPIO_SetHigh(EXT_GPIO, EXT_GPIO_BITS);

  // Enable BUT_GPIO to make buttons on board to trigger interrupts
  SYS_EnableAPBClock(BUT_GPIO_MASK);
  GPIO_SetInput(BUT_GPIO, BUT_GPIO_BITS);
  GPIO_EnableInt(BUT_GPIO, BUT_GPIO_BITS);
  GPIO_IntConfig(BUT_GPIO, BUT_GPIO_BITS, GPIO_INTMODE_FALLEDGE);

#ifdef LOGGER_UART
  GPIO_AF_ENABLE(GPIO_AF_PIN(UART, LOGGER_UART, UARTRXD));
  GPIO_AF_ENABLE(GPIO_AF_PIN(UART, LOGGER_UART, UARTTXD));

  MSG_UART = UARTx(LOGGER_UART);
  SYS_EnableAPBClock(APB_MASK_UARTx(LOGGER_UART));
  UART_Init(UARTx(LOGGER_UART), BAUD_RATE, UART_LCR_DATABITS_8, UART_LCR_STOPBITS_1, UART_LCR_PARITY_NONE, UART_LCR_FIFO_16);
#endif

  dbg_printf("\nInit done. CLK: %.3fMHz, RTC: %dHz\n", SYS_GetSysClkFreq()/(double)1e6, BOARD_RTC_FREQUENCY);
}

void board_led_write(bool state)
{
  GPIO_SetValue(LED_GPIO, LED_GPIO_BITS, state ? LED_GPIO_BITS : 0);
}

uint32_t board_button_read(void)
{
  return GPIO_GetValue(BUT_GPIO, BUT_GPIO_BITS);
}

int board_uart_read(uint8_t *buf, int len)
{
  (void) buf; (void) len;
  return 0;
}

int board_uart_write(void const *buf, int len)
{
  UART_Send(UART0, (const unsigned char *)buf, len);
  return len;
}

uint32_t board_millis(void)
{
  return UTIL_GetTick();
}
