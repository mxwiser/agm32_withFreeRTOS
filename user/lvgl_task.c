#include "lvgl_task.h"

#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include "st7789.h"
#include "lvgl.h"

/* RGB565, ten lines; uint32_t provides suitable alignment for the renderer. */
static uint32_t draw_buffer[ST7789_NATIVE_WIDTH * 10U * 2U / sizeof(uint32_t)];
volatile ST7789_Status lvgl_lcd_status = ST7789_NOT_INITIALIZED;
volatile uint32_t lvgl_flush_errors;

static void flush_display(lv_display_t *display, const lv_area_t *area, uint8_t *pixels)
{
  lvgl_lcd_status = ST7789_DrawRGB565((uint16_t)area->x1, (uint16_t)area->y1,
                                      (uint16_t)(area->x2 - area->x1 + 1),
                                      (uint16_t)(area->y2 - area->y1 + 1),
                                      (const uint16_t *)pixels);
  if (lvgl_lcd_status != ST7789_OK) {
    ++lvgl_flush_errors;
  }
  /* The driver blocks until DMA completes, including on error. */
  lv_display_flush_ready(display);
}

void LVGL_Task(void *argument)
{
  (void)argument;
  lvgl_lcd_status = ST7789_Init();
  if (lvgl_lcd_status != ST7789_OK) {
    printf("LVGL LCD init failed: %u\n", (unsigned)lvgl_lcd_status);
    vTaskDelete(NULL);
    return;
  }

  lv_init();
  lv_tick_set_cb(board_millis);
  lv_display_t *display = lv_display_create(ST7789_Width(), ST7789_Height());
  if (display == NULL) {
    printf("LVGL display allocation failed\n");
    vTaskDelete(NULL);
    return;
  }
  lv_display_set_color_format(display, LV_COLOR_FORMAT_RGB565);
  lv_display_set_flush_cb(display, flush_display);
  lv_display_set_buffers(display, draw_buffer, NULL, sizeof(draw_buffer),
                         LV_DISPLAY_RENDER_MODE_PARTIAL);

  lv_obj_t *label = lv_label_create(lv_screen_active());
  if (label != NULL) {
    lv_label_set_text(label, "LVGL + FreeRTOS");
    lv_obj_center(label);
  }

  for (;;) {
    uint32_t delay_ms = lv_timer_handler();
    if (delay_ms < 1U) delay_ms = 1U;
    if (delay_ms > 20U) delay_ms = 20U;
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
  }
}
