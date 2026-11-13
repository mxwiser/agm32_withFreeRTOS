#include "dashboard.h"
#include "battery.h"

LV_FONT_DECLARE(font_speed_58);
LV_FONT_DECLARE(font_dashboard_14);
LV_FONT_DECLARE(font_dashboard_24);
LV_FONT_DECLARE(font_title_cn_14);

#define COLOR_BG       0xE5E7E9
#define COLOR_PANEL    0xFAFAFA
#define COLOR_BORDER   0x92999F
#define COLOR_TRACK    0xB7BEC4
#define COLOR_TEXT     0x000000
#define COLOR_CYAN     0x005E73
#define COLOR_SPEED_ARC 0x711C96
#define COLOR_BIKE_UNLOCKED 0x000000
#define COLOR_BIKE_LOCKED 0xFF0000
#define COLOR_VOLTAGE  0xF50057  /* Voltage card accent. */
#define COLOR_THROTTLE 0x536DFE  /* Throttle progress fill. */
#define COLOR_BATTERY  0x64DD17  /* Battery cells at 20% and above. */
#define COLOR_BATTERY_LOW 0xFF0000 /* Battery warning below 20%. */
#define COLOR_YELLOW   0x8A4D00
#define COLOR_RED      0xFF0000
#define BATTERY_SEGMENTS 5U
#define BATTERY_SEGMENT_WIDTH 4
#define BATTERY_SEGMENT_GAP 2

typedef struct {
  lv_obj_t *speed;
  lv_obj_t *gauge;
  lv_obj_t *bike_wheel_left;
  lv_obj_t *bike_wheel_right;
  lv_obj_t *bike_frame;
  lv_obj_t *battery_body;
  lv_obj_t *battery_terminal;
  lv_obj_t *battery_segments[BATTERY_SEGMENTS];
  lv_obj_t *controller_temperature;
  lv_obj_t *voltage;
  lv_obj_t *current;
  lv_obj_t *power;
  lv_obj_t *brake_text;
  lv_obj_t *brake_fill;
  lv_obj_t *throttle_text;
  lv_obj_t *throttle_fill;
  lv_obj_t *ppm_text;
  lv_obj_t *ppm_brake_fill;
  lv_obj_t *ppm_drive_fill;
} DashboardWidgets;

static DashboardWidgets ui;
static DashboardData previous;
static bool previous_valid;
static bool create_failed;

static uint8_t limit_percent(uint8_t value)
{
  return value > 100U ? 100U : value;
}

static lv_obj_t *box(lv_obj_t *parent, int x, int y, int w, int h,
                     uint32_t bg, uint32_t border, int radius)
{
  lv_obj_t *obj = lv_obj_create(parent);
  if (obj == NULL) { create_failed = true; return NULL; }
  lv_obj_remove_style_all(obj);
  lv_obj_set_pos(obj, x, y);
  lv_obj_set_size(obj, w, h);
  lv_obj_set_scrollable(obj, false);
  lv_obj_set_clickable(obj, false);
  lv_obj_set_style_bg_color(obj, lv_color_hex(bg), 0);
  lv_obj_set_style_bg_opa(obj, LV_OPA_COVER, 0);
  lv_obj_set_style_border_color(obj, lv_color_hex(border), 0);
  lv_obj_set_style_border_width(obj, border == bg ? 0 : 1, 0);
  lv_obj_set_style_radius(obj, radius, 0);
  lv_obj_set_style_pad_all(obj, 0, 0);
  return obj;
}

static lv_obj_t *text(lv_obj_t *parent, int x, int y, int width,
                      const char *value, const lv_font_t *font,
                      uint32_t color, lv_text_align_t align)
{
  lv_obj_t *label = lv_label_create(parent);
  if (label == NULL) { create_failed = true; return NULL; }
  lv_obj_set_pos(label, x, y);
  lv_obj_set_width(label, width);
  lv_label_set_long_mode(label, LV_LABEL_LONG_MODE_CLIP);
  lv_obj_set_style_text_font(label, font, 0);
  lv_obj_set_style_text_color(label, lv_color_hex(color), 0);
  lv_obj_set_style_text_align(label, align, 0);
  lv_label_set_text(label, value);
  return label;
}

static void make_bike(lv_obj_t *screen)
{
  /* Line points must remain valid for the lifetime of the widget. */
  static const lv_point_precise_t frame[] = {
    {12, 16}, {19, 8}, {26, 16}, {12, 16}, {17, 10}, {23, 10}, {26, 16}, {34, 16}
  };
  ui.bike_wheel_left = box(screen, 7, 11, 10, 10, COLOR_PANEL, COLOR_BIKE_LOCKED, LV_RADIUS_CIRCLE);
  ui.bike_wheel_right = box(screen, 29, 11, 10, 10, COLOR_PANEL, COLOR_BIKE_LOCKED, LV_RADIUS_CIRCLE);
  lv_obj_t *line = lv_line_create(screen);
  if (line == NULL) { create_failed = true; return; }
  ui.bike_frame = line;
  lv_obj_set_pos(line, 0, 0);
  lv_obj_set_style_line_color(line, lv_color_hex(COLOR_BIKE_LOCKED), 0);
  lv_obj_set_style_line_width(line, 2, 0);
  lv_line_set_points(line, frame, sizeof(frame) / sizeof(frame[0]));
}

static lv_obj_t *metric_card(lv_obj_t *screen, int y, const char *title, uint32_t accent)
{
  lv_obj_t *card = box(screen, 170, y, 144, 47, COLOR_PANEL, COLOR_BORDER, 5);
  if (card == NULL) return NULL;
  (void)box(card, 0, 3, 4, 41, accent, accent, 2);
  (void)text(card, 12, 1, 124, title, &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_LEFT);
  return text(card, 12, 16, 124, "0", &font_dashboard_24, COLOR_TEXT, LV_TEXT_ALIGN_LEFT);
}

static bool ppm_card(lv_obj_t *screen)
{
  lv_obj_t *card = box(screen, 163, 191, 151, 43, COLOR_PANEL, COLOR_BORDER, 5);
  if (card == NULL) return false;
  (void)text(card, 8, 4, 83, "PPM THR", &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_LEFT);
  ui.ppm_text = text(card, 95, 4, 47, "0%", &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_RIGHT);
  lv_obj_t *track = box(card, 8, 27, 135, 8, COLOR_TRACK, COLOR_TRACK, 4);
  if (track == NULL) return false;
  ui.ppm_brake_fill = box(track, 66, 0, 1, 8, COLOR_RED, COLOR_RED, 0);
  ui.ppm_drive_fill = box(track, 68, 0, 1, 8, COLOR_THROTTLE, COLOR_THROTTLE, 0);
  return ui.ppm_text && ui.ppm_brake_fill && ui.ppm_drive_fill;
}

static bool combined_duty_card(lv_obj_t *screen)
{
  lv_obj_t *card = box(screen, 6, 191, 151, 43, COLOR_PANEL, COLOR_BORDER, 5);
  if (card == NULL) return false;
  ui.brake_text = text(card, 8, 4, 64, "B --", &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_LEFT);
  ui.throttle_text = text(card, 75, 4, 67, "T --", &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_RIGHT);
  lv_obj_t *track = box(card, 8, 27, 135, 8, COLOR_TRACK, COLOR_TRACK, 4);
  if (track == NULL) return false;
  ui.brake_fill = box(track, 66, 0, 1, 8, COLOR_RED, COLOR_RED, 0);
  ui.throttle_fill = box(track, 68, 0, 1, 8, COLOR_THROTTLE, COLOR_THROTTLE, 0);
  return ui.brake_text && ui.throttle_text && ui.brake_fill && ui.throttle_fill;
}

bool Dashboard_Create(lv_obj_t *screen)
{
  create_failed = false;
  previous_valid = false;
  lv_obj_set_scrollable(screen, false);
  lv_obj_set_scrollbar_mode(screen, LV_SCROLLBAR_MODE_OFF);
  lv_obj_set_style_bg_color(screen, lv_color_hex(COLOR_BG), 0);
  lv_obj_set_style_bg_opa(screen, LV_OPA_COVER, 0);

  (void)box(screen, 0, 0, 320, 26, COLOR_PANEL, COLOR_PANEL, 0);
  (void)box(screen, 0, 25, 320, 1, COLOR_CYAN, COLOR_CYAN, 0);
  make_bike(screen);
  (void)text(screen, 44, 4, 180, "汽车与交通工程学院 毛小文",
             &font_title_cn_14, COLOR_TEXT, LV_TEXT_ALIGN_LEFT);

  lv_obj_t *battery_group = box(screen, 230, 3, 84, 20, COLOR_PANEL, COLOR_PANEL, 0);
  if (battery_group != NULL) {
    ui.battery_body = box(battery_group, 0, 3, 34, 14, COLOR_PANEL, COLOR_TEXT, 2);
    if (ui.battery_body != NULL) {
      /* Five 4 px cells with 2 px gaps, centered inside the 1 px border. */
      for (unsigned i = 0; i < BATTERY_SEGMENTS; ++i) {
        ui.battery_segments[i] = box(ui.battery_body,
            2 + (int)i * (BATTERY_SEGMENT_WIDTH + BATTERY_SEGMENT_GAP), 1,
            BATTERY_SEGMENT_WIDTH, 10, COLOR_BATTERY, COLOR_BATTERY, 0);
      }
    }
    ui.battery_terminal = box(battery_group, 34, 7, 3, 6, COLOR_TEXT, COLOR_TEXT, 1);
    ui.controller_temperature = text(battery_group, 42, 0, 42, "0°C",
                                      &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_RIGHT);
    if (ui.controller_temperature != NULL)
      lv_obj_align(ui.controller_temperature, LV_ALIGN_RIGHT_MID, 0, 0);
  }

  ui.gauge = lv_arc_create(screen);
  if (ui.gauge != NULL) {
    lv_obj_set_pos(ui.gauge, 5, 31);
    lv_obj_set_size(ui.gauge, 156, 156);
    lv_obj_set_clickable(ui.gauge, false);
    lv_obj_set_style_bg_opa(ui.gauge, LV_OPA_TRANSP, LV_PART_MAIN);
    lv_obj_set_style_border_width(ui.gauge, 0, LV_PART_MAIN);
    lv_obj_set_style_pad_all(ui.gauge, 0, LV_PART_MAIN);
    lv_obj_set_style_arc_width(ui.gauge, 9, LV_PART_MAIN);
    lv_obj_set_style_arc_color(ui.gauge, lv_color_hex(COLOR_TRACK), LV_PART_MAIN);
    lv_obj_set_style_arc_width(ui.gauge, 9, LV_PART_INDICATOR);
    lv_obj_set_style_arc_color(ui.gauge, lv_color_hex(COLOR_SPEED_ARC), LV_PART_INDICATOR);
    lv_obj_set_style_arc_rounded(ui.gauge, true, LV_PART_INDICATOR);
    lv_obj_remove_style(ui.gauge, NULL, LV_PART_KNOB);
    lv_obj_set_style_bg_opa(ui.gauge, LV_OPA_TRANSP, LV_PART_KNOB);
    lv_arc_set_bg_angles(ui.gauge, 135, 45);
    lv_arc_set_range(ui.gauge, 0, 99);
  } else create_failed = true;
  (void)text(screen, 25, 60, 116, "SPEED", &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_CENTER);
  ui.speed = text(screen, 14, 78, 140, "0", &font_speed_58, COLOR_TEXT, LV_TEXT_ALIGN_CENTER);
  (void)text(screen, 25, 145, 116, "km/h", &font_dashboard_14, COLOR_TEXT, LV_TEXT_ALIGN_CENTER);

  ui.voltage = metric_card(screen, 31, "Voltage", COLOR_VOLTAGE);
  ui.current = metric_card(screen, 83, "Current", COLOR_CYAN);
  ui.power = metric_card(screen, 135, "Power", COLOR_YELLOW);
  (void)combined_duty_card(screen);
  (void)ppm_card(screen);

  bool battery_ready = true;
  for (unsigned i = 0; i < BATTERY_SEGMENTS; ++i)
    battery_ready = battery_ready && ui.battery_segments[i] != NULL;
  return !create_failed && ui.speed && ui.gauge && ui.bike_wheel_left &&
         ui.bike_wheel_right && ui.bike_frame && ui.battery_body &&
         ui.battery_terminal && battery_ready && ui.controller_temperature &&
         ui.voltage && ui.current && ui.power &&
         ui.brake_text && ui.brake_fill && ui.throttle_text && ui.throttle_fill &&
         ui.ppm_text && ui.ppm_brake_fill && ui.ppm_drive_fill;
}

static void set_bar(lv_obj_t *fill, uint8_t value, int max_width)
{
  value = limit_percent(value);
  lv_obj_set_hidden(fill, value == 0U);
  if (value != 0U) {
    int width = (max_width * value + 99) / 100;
    lv_obj_set_width(fill, width);
  }
}

static void set_brake_bar(lv_obj_t *fill, uint8_t value)
{
  value = limit_percent(value);
  lv_obj_set_hidden(fill, value == 0U);
  if (value != 0U) {
    int width = (67 * value + 99) / 100;
    lv_obj_set_pos(fill, 67 - width, 0);
    lv_obj_set_width(fill, width);
  }
}

void Dashboard_Refresh(const DashboardData *data)
{
  if (data == NULL || create_failed) return;
  if (!previous_valid || data->vehicle_locked != previous.vehicle_locked) {
    lv_color_t color = lv_color_hex(data->vehicle_locked ? COLOR_BIKE_LOCKED : COLOR_BIKE_UNLOCKED);
    lv_obj_set_style_border_color(ui.bike_wheel_left, color, 0);
    lv_obj_set_style_border_color(ui.bike_wheel_right, color, 0);
    lv_obj_set_style_line_color(ui.bike_frame, color, 0);
  }
  if (!previous_valid || data->current_speed_kmh != previous.current_speed_kmh) {
    int32_t speed = data->current_speed_kmh;
    uint32_t magnitude = (uint32_t)(speed < 0 ? -speed : speed);
    lv_label_set_text_fmt(ui.speed, "%d", (int)speed);
    lv_arc_set_value(ui.gauge, magnitude > 99U ? 99 : (int32_t)magnitude);
  }
  if (!previous_valid || data->battery_percent != previous.battery_percent) {
    uint8_t value = limit_percent(data->battery_percent);
    uint32_t indicator = value < BATTERY_LOW_PERCENT ? COLOR_BATTERY_LOW : COLOR_BATTERY;
    uint32_t outline = value < BATTERY_LOW_PERCENT ? COLOR_BATTERY_LOW : COLOR_TEXT;
    unsigned active_segments = ((unsigned)value * BATTERY_SEGMENTS + 99U) / 100U;
    for (unsigned i = 0; i < BATTERY_SEGMENTS; ++i) {
      uint32_t color = i < active_segments ? indicator : COLOR_TRACK;
      lv_obj_set_style_bg_color(ui.battery_segments[i], lv_color_hex(color), 0);
    }
    lv_obj_set_style_border_color(ui.battery_body, lv_color_hex(outline), 0);
    lv_obj_set_style_bg_color(ui.battery_terminal, lv_color_hex(outline), 0);
  }
  if (!previous_valid || data->controller_temperature_c != previous.controller_temperature_c)
    lv_label_set_text_fmt(ui.controller_temperature, "%d°C", (int)data->controller_temperature_c);
  if (!previous_valid || data->voltage_tenths_v != previous.voltage_tenths_v)
    lv_label_set_text_fmt(ui.voltage, "%u.%u V", (unsigned)(data->voltage_tenths_v / 10U), (unsigned)(data->voltage_tenths_v % 10U));
  if (!previous_valid || data->current_tenths_a != previous.current_tenths_a) {
    int32_t current = data->current_tenths_a;
    uint32_t magnitude = (uint32_t)(current < 0 ? -current : current);
    lv_label_set_text_fmt(ui.current, "%s%u.%u A", current < 0 ? "-" : "",
                         (unsigned)(magnitude / 10U), (unsigned)(magnitude % 10U));
  }
  if (!previous_valid || data->power_w != previous.power_w)
    lv_label_set_text_fmt(ui.power, "%ld W", (long)data->power_w);
  if (!previous_valid || data->brake_percent != previous.brake_percent ||
      ((data->adc_valid_mask ^ previous.adc_valid_mask) & 1U)) {
    uint8_t value = limit_percent(data->brake_percent);
    if (data->adc_valid_mask & 1U) {
      lv_label_set_text_fmt(ui.brake_text, "B %u%%", (unsigned)value);
      set_brake_bar(ui.brake_fill, value);
    } else {
      lv_label_set_text(ui.brake_text, "B --");
      set_brake_bar(ui.brake_fill, 0);
    }
  }
  if (!previous_valid || data->throttle_percent != previous.throttle_percent ||
      ((data->adc_valid_mask ^ previous.adc_valid_mask) & 2U)) {
    uint8_t value = limit_percent(data->throttle_percent);
    if (data->adc_valid_mask & 2U) {
      lv_label_set_text_fmt(ui.throttle_text, "T %u%%", (unsigned)value);
      set_bar(ui.throttle_fill, value, 67);
    } else {
      lv_label_set_text(ui.throttle_text, "T --");
      set_bar(ui.throttle_fill, 0, 67);
    }
  }
  if (!previous_valid || data->ppm_throttle_percent != previous.ppm_throttle_percent ||
      data->ppm_valid != previous.ppm_valid) {
    int32_t value = data->ppm_throttle_percent;
    if (value < -100) value = -100;
    if (value > 100) value = 100;
    if (data->ppm_valid) {
      lv_label_set_text_fmt(ui.ppm_text, "%d%%", (int)value);
      set_brake_bar(ui.ppm_brake_fill, value < 0 ? (uint8_t)-value : 0U);
      set_bar(ui.ppm_drive_fill, value > 0 ? (uint8_t)value : 0U, 67);
    } else {
      lv_label_set_text(ui.ppm_text, "--");
      set_brake_bar(ui.ppm_brake_fill, 0);
      set_bar(ui.ppm_drive_fill, 0, 67);
    }
  }
  previous = *data;
  previous_valid = true;
}
