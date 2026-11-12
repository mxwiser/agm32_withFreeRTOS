#include "lcd_demo.h"
#include "st7789.h"
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include <stdio.h>

// Useful in the debugger; frame count increases only after a completed transfer.
volatile ST7789_Status lcd_init_status = ST7789_NOT_INITIALIZED;
volatile ST7789_Status lcd_readback_status = ST7789_READ_UNSUPPORTED;
volatile ST7789_Status lcd_sync_status = ST7789_READ_UNSUPPORTED;
volatile ST7789_Status lcd_last_status = ST7789_NOT_INITIALIZED;
volatile uint32_t lcd_frame_count;
volatile uint32_t lcd_fill_time_ms;
volatile uint32_t lcd_cpu_hz;
volatile uint32_t lcd_spi_hz;

void LCD_ColorTestTask(void *argument)
{
  (void)argument;
  static const uint16_t colors[] = {ST7789_RED, ST7789_GREEN, ST7789_BLUE};
  lcd_init_status = ST7789_Init();
  if (lcd_init_status != ST7789_OK) {
    printf("LCD init failed: %u\n", (unsigned)lcd_init_status);
    vTaskDelete(NULL);
  }
  lcd_cpu_hz = SYS_GetSysClkFreq();
  uint32_t divisor = (SPI0->CTRL & SPI_CTRL_SCLK_DIV_MASK) >> SPI_CTRL_SCLK_DIV_OFFSET;
  lcd_spi_hz = SYS_GetPclkFreq() / (divisor != 0 ? divisor : 256U);

  lcd_readback_status = ST7789_ProbeReadback();
  if (lcd_readback_status == ST7789_OK) {
    lcd_sync_status = ST7789_WaitFrameStart(100);
  }
  printf("LCD: CPU=%lu Hz, SPI=%lu Hz, readback=%u, frame sync=%u\n",
           (unsigned long)lcd_cpu_hz, (unsigned long)lcd_spi_hz,
           (unsigned)lcd_readback_status, (unsigned)lcd_sync_status);
  // The test deliberately keeps drawing on write-only panels. Applications
  // requiring a measured frame boundary should handle the sync error directly.
  bool frame_sync = lcd_sync_status == ST7789_OK;
  for (size_t i = 0;; i = (i + 1U) % (sizeof(colors) / sizeof(colors[0]))) {
    uint32_t start = board_millis();
    lcd_last_status = frame_sync ? ST7789_FillScreenSync(colors[i], 100)
                                 : ST7789_FillScreen(colors[i]);
    lcd_fill_time_ms = board_millis() - start;
    if (lcd_last_status != ST7789_OK) {
      printf("LCD fill failed: %u\n", (unsigned)lcd_last_status);
      vTaskDelete(NULL);
    }
    ++lcd_frame_count;
    vTaskDelay(pdMS_TO_TICKS(1000));
  }
}
