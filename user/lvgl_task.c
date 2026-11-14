#include "lvgl_task.h"

#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include "st7789.h"
#include "lvgl.h"
#include "dashboard.h"
#include "input_task.h"
#include "ppm/ppm_task.h"
#include "config/task_config.h"
#include "vesc/vesc_uart.h"
#include "vesc/vesc_speed.h"
#include "vesc/vesc_measurements.h"

/* 速度、电气数据和 MOS 温度来自 VESC 遥测。 */
DashboardData dashboard_data = {
  .current_speed_kmh = 0,
  .speed_valid = false,
  .battery_percent = 0,
  .electrical_valid = false,
  .brake_percent = 0,
  .throttle_percent = 0,
  .ppm_throttle_percent = 0,
  .vehicle_locked = true,
};

/* RGB565, ten lines; uint32_t provides suitable alignment for the renderer. */
static uint32_t draw_buffer[ST7789_NATIVE_HEIGHT * 10U * 2U / sizeof(uint32_t)];
volatile ST7789_Status lvgl_lcd_status = ST7789_NOT_INITIALIZED;
volatile uint32_t lvgl_flush_errors;

static void dashboard_update_inputs(void)
{
  InputValues sample;
  PpmValues ppm;
  VescStatus vesc;
  Input_GetSnapshot(&sample);
  Ppm_GetSnapshot(&ppm);
  Vesc_GetSnapshot(&vesc);
  int16_t speed;
  dashboard_data.speed_valid = vesc.online &&
      VescSpeed_FromErpm(vesc.telemetry.electrical_rpm,
                         VESC_MOTOR_POLE_PAIRS, VESC_WHEEL_CIRCUMFERENCE_MM,
                         VESC_GEAR_MOTOR_TURNS, VESC_GEAR_WHEEL_TURNS, &speed);
  dashboard_data.current_speed_kmh = dashboard_data.speed_valid ? speed : 0;
  dashboard_data.electrical_valid = vesc.online;
  dashboard_data.battery_valid = vesc.online && vesc.battery_valid;
  dashboard_data.battery_percent = dashboard_data.battery_valid ? vesc.battery_percent : 0U;
  dashboard_data.controller_temperature_valid = vesc.online;
  if (vesc.online) {
    VescElectricalValues values;
    VescElectrical_Convert(&vesc.telemetry, &values);
    dashboard_data.voltage_tenths_v = values.voltage_tenths_v;
    dashboard_data.current_tenths_a = values.current_tenths_a;
    dashboard_data.power_w = values.power_w;
    dashboard_data.controller_temperature_c =
        VescTemperature_WholeCelsius(vesc.telemetry.fet_temp_tenths_c);
  }
  dashboard_data.brake_percent = sample.adc.adc1_percent;
  dashboard_data.throttle_percent = sample.adc.adc2_percent;
  dashboard_data.adc_valid_mask = sample.adc.valid_mask;
  dashboard_data.ppm_throttle_percent = ppm.percent;
  dashboard_data.ppm_valid = ppm.valid;
  dashboard_data.vehicle_locked = ppm.vehicle_locked;
}

static void dashboard_adc_timer(lv_timer_t *timer)
{
  (void)timer;
  dashboard_update_inputs();
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
  dashboard_update_inputs();
  Dashboard_Refresh(&dashboard_data);
  if (lv_timer_create(dashboard_adc_timer, DASHBOARD_ADC_PERIOD_MS, NULL) == NULL) {
    printf("Dashboard ADC timer allocation failed\n");
  }

  for (;;) {
    uint32_t delay_ms = lv_timer_handler();
    if (delay_ms < 1U) delay_ms = 1U;
    if (delay_ms > 20U) delay_ms = 20U;
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
  }
}
