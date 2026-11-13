#include "lvgl_task.h"

#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include "st7789.h"
#include "lvgl.h"

LV_FONT_DECLARE(big_numbers);

#define SPEED_DEMO_PERIOD_MS 200U
#define SPEED_DEMO_MAX_KMH   99U
#define LED_DEMO_PERIOD_MS   1000U

typedef enum {
  SCREEN_LED_RED = 0,
  SCREEN_LED_BLUE,
  SCREEN_LED_GREEN
} ScreenLedState;

/* Owned by the LVGL task; the demo cycles this speed in km/h. */
uint8_t current_speed_kmh;
ScreenLedState screen_led_state = SCREEN_LED_RED;

/* RGB565, ten lines; uint32_t provides suitable alignment for the renderer. */
static uint32_t draw_buffer[ST7789_NATIVE_HEIGHT * 10U * 2U / sizeof(uint32_t)];
volatile ST7789_Status lvgl_lcd_status = ST7789_NOT_INITIALIZED;
volatile uint32_t lvgl_flush_errors;

static void speed_demo_timer(lv_timer_t *timer)
{
  lv_obj_t *label = lv_timer_get_user_data(timer);
  current_speed_kmh = current_speed_kmh < SPEED_DEMO_MAX_KMH
                        ? current_speed_kmh + 1U : 0U;
  lv_label_set_text_fmt(label, "%2u", (unsigned)current_speed_kmh);
}

static void update_screen_led(lv_obj_t *led)
{
  uint32_t color;
  switch (screen_led_state) {
    case SCREEN_LED_BLUE:  color = 0x0000FF; break;
    case SCREEN_LED_GREEN: color = 0x00FF00; break;
    case SCREEN_LED_RED:
    default:               color = 0xFF0000; break;
  }
  lv_led_set_color(led, lv_color_hex(color));
}

static void led_demo_timer(lv_timer_t *timer)
{
  lv_obj_t *led = lv_timer_get_user_data(timer);
  switch (screen_led_state) {
    case SCREEN_LED_RED:  screen_led_state = SCREEN_LED_BLUE; break;
    case SCREEN_LED_BLUE: screen_led_state = SCREEN_LED_GREEN; break;
    default:              screen_led_state = SCREEN_LED_RED; break;
  }
  update_screen_led(led);
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

  lv_obj_set_scrollable(lv_screen_active(), false);
  lv_obj_set_scrollbar_mode(lv_screen_active(), LV_SCROLLBAR_MODE_OFF);
  lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(0xF2F4F7), 0);
  lv_obj_set_style_bg_opa(lv_screen_active(), LV_OPA_COVER, 0);
  lv_obj_t *label = lv_label_create(lv_screen_active());
  if (label != NULL) {
    current_speed_kmh = 0;
    lv_label_set_text(label, "0");
    lv_obj_set_style_text_font(label, &big_numbers, 0);
    lv_obj_set_style_text_color(label, lv_color_hex(0x0000FF), 0);
    lv_obj_set_pos(label, 15, 30);
    if (lv_timer_create(speed_demo_timer, SPEED_DEMO_PERIOD_MS, label) == NULL) {
      printf("Speed demo timer allocation failed\n");
    }
  }

  lv_obj_t *led = lv_led_create(lv_screen_active());
  if (led != NULL) {
    lv_obj_set_size(led, 24, 24);
    lv_obj_align(led, LV_ALIGN_TOP_RIGHT, -12, 12);
    lv_obj_set_style_bg_color(led, lv_color_white(), 0);
    lv_obj_set_style_bg_opa(led, LV_OPA_COVER, 0);
    lv_obj_set_style_radius(led, LV_RADIUS_CIRCLE, 0);
    screen_led_state = SCREEN_LED_RED;
    update_screen_led(led);
    lv_led_on(led);
    if (lv_timer_create(led_demo_timer, LED_DEMO_PERIOD_MS, led) == NULL) {
      printf("LED demo timer allocation failed\n");
    }
  }

  for (;;) {
    uint32_t delay_ms = lv_timer_handler();
    if (delay_ms < 1U) delay_ms = 1U;
    if (delay_ms > 20U) delay_ms = 20U;
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
  }
}
