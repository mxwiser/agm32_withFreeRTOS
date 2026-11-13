#include "lvgl_task.h"

#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include "st7789.h"
#include "lvgl.h"
#include "dashboard.h"
#include "battery.h"

#define DASHBOARD_DEMO_PERIOD_MS 500U

/* Demo values only; replace the timer with real measurements later. */
DashboardData dashboard_data = {
  .current_speed_kmh = 26,
  .battery_percent = 0, /* Calculated from voltage when the task starts. */
  .voltage_tenths_v = 524,
  .current_tenths_a = 86,
  .power_w = 451,
  .brake_percent = 18,
  .throttle_percent = 63,
};

/* RGB565, ten lines; uint32_t provides suitable alignment for the renderer. */
static uint32_t draw_buffer[ST7789_NATIVE_HEIGHT * 10U * 2U / sizeof(uint32_t)];
volatile ST7789_Status lvgl_lcd_status = ST7789_NOT_INITIALIZED;
volatile uint32_t lvgl_flush_errors;

static void dashboard_demo_timer(lv_timer_t *timer)
{
  static uint32_t step;
  static int16_t battery_voltage_step = -2;
  (void)timer;
  ++step;
  dashboard_data.current_speed_kmh = dashboard_data.current_speed_kmh >= 99
                                      ? -99 : dashboard_data.current_speed_kmh + 1;
  int32_t next_voltage = (int32_t)dashboard_data.voltage_tenths_v + battery_voltage_step;
  if (next_voltage <= (int32_t)BATTERY_DEMO_MIN_TENTHS_V) {
    next_voltage = BATTERY_DEMO_MIN_TENTHS_V;
    battery_voltage_step = 2;
  } else if (next_voltage >= (int32_t)BATTERY_DEMO_MAX_TENTHS_V) {
    next_voltage = BATTERY_DEMO_MAX_TENTHS_V;
    battery_voltage_step = -2;
  }
  dashboard_data.voltage_tenths_v = (uint16_t)next_voltage;
  dashboard_data.battery_percent = Battery_EstimatePercent(dashboard_data.voltage_tenths_v);
  dashboard_data.current_tenths_a = (int16_t)(30U + (step * 3U) % 100U);
  /* Include a charging/regeneration phase in each 20 second demo cycle. */
  if (step % 40U >= 30U)
    dashboard_data.current_tenths_a = -(int16_t)(5U + (step * 3U) % 50U);
  int32_t power_centiw = (int32_t)dashboard_data.voltage_tenths_v *
                        dashboard_data.current_tenths_a;
  dashboard_data.power_w = (power_centiw + (power_centiw < 0 ? -50 : 50)) / 100;
  dashboard_data.brake_percent = (uint8_t)((step * 2U) % 101U);
  dashboard_data.throttle_percent = (uint8_t)((step * 3U) % 101U);
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

  dashboard_data.battery_percent = Battery_EstimatePercent(dashboard_data.voltage_tenths_v);
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
