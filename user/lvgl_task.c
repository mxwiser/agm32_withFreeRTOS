#include "lvgl_task.h"

#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include "st7789.h"
#include "lvgl.h"
#include "dashboard.h"

#define DASHBOARD_DEMO_PERIOD_MS 500U

/* Demo values only; replace the timer with real measurements later. */
DashboardData dashboard_data = {
  .current_speed_kmh = 26,
  .battery_percent = 78,
  .voltage_tenths_v = 524,
  .current_tenths_a = 86,
  .power_w = 451,
  .brake_percent = 18,
  .throttle_percent = 63,
  .headlight_on = true,
  .led_state = DASHBOARD_LED_RED,
};

/* RGB565, ten lines; uint32_t provides suitable alignment for the renderer. */
static uint32_t draw_buffer[ST7789_NATIVE_HEIGHT * 10U * 2U / sizeof(uint32_t)];
volatile ST7789_Status lvgl_lcd_status = ST7789_NOT_INITIALIZED;
volatile uint32_t lvgl_flush_errors;

static void dashboard_demo_timer(lv_timer_t *timer)
{
  static uint32_t step;
  (void)timer;
  ++step;
  dashboard_data.current_speed_kmh = (uint8_t)((dashboard_data.current_speed_kmh + 1U) % 100U);
  dashboard_data.battery_percent = (uint8_t)(65U + (step / 4U) % 31U);
  dashboard_data.voltage_tenths_v = (uint16_t)(500U + step % 51U);
  dashboard_data.current_tenths_a = (uint16_t)(30U + (step * 3U) % 100U);
  dashboard_data.power_w = (uint16_t)(((uint32_t)dashboard_data.voltage_tenths_v *
                                       dashboard_data.current_tenths_a + 50U) / 100U);
  dashboard_data.brake_percent = (uint8_t)((step * 2U) % 101U);
  dashboard_data.throttle_percent = (uint8_t)((step * 3U) % 101U);
  dashboard_data.headlight_on = ((step / 10U) % 2U) == 0U;
  dashboard_data.led_state = (DashboardLedState)((step / 2U) % 3U);
  Dashboard_Refresh(&dashboard_data);
}

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

  if (!Dashboard_Create(lv_screen_active())) {
    printf("Dashboard allocation failed\n");
    vTaskDelete(NULL);
    return;
  }
  Dashboard_Refresh(&dashboard_data);
  if (lv_timer_create(dashboard_demo_timer, DASHBOARD_DEMO_PERIOD_MS, NULL) == NULL) {
    printf("Dashboard demo timer allocation failed\n");
  }

  for (;;) {
    uint32_t delay_ms = lv_timer_handler();
    if (delay_ms < 1U) delay_ms = 1U;
    if (delay_ms > 20U) delay_ms = 20U;
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
  }
}
