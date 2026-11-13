#include "dashboard.h"

LV_FONT_DECLARE(lv_font_bike_48);
LV_FONT_DECLARE(font_speed_58);
LV_FONT_DECLARE(font_dashboard_12);
LV_FONT_DECLARE(font_dashboard_20);

#define COLOR_BG       0x050C14
#define COLOR_PANEL    0x101C29
#define COLOR_BORDER   0x41566C
#define COLOR_TRACK    0x26394A
#define COLOR_WHITE    0xF4F8FC
#define COLOR_MUTED    0xAABBD0
#define COLOR_CYAN     0x00E1E8
#define COLOR_GREEN    0x50F045
#define COLOR_YELLOW   0xFFC12A
#define COLOR_RED      0xFF4558

typedef struct {
  lv_obj_t *speed;
  lv_obj_t *gauge;
  lv_obj_t *battery_fill;
  lv_obj_t *battery_text;
  lv_obj_t *headlight;
  lv_obj_t *led;
  lv_obj_t *voltage;
  lv_obj_t *current;
  lv_obj_t *power;
  lv_obj_t *brake_text;
  lv_obj_t *brake_fill;
  lv_obj_t *throttle_text;
  lv_obj_t *throttle_fill;
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
  /* Static points must outlive the line widget. */
  static const lv_point_precise_t frame[] = {
    {12, 16}, {19, 8}, {26, 16}, {12, 16}, {17, 10}, {23, 10}, {26, 16}, {34, 16}
  };
  (void)box(screen, 7, 11, 10, 10, COLOR_PANEL, COLOR_WHITE, LV_RADIUS_CIRCLE);
  (void)box(screen, 29, 11, 10, 10, COLOR_PANEL, COLOR_WHITE, LV_RADIUS_CIRCLE);
  lv_obj_t *line = lv_line_create(screen);
  if (line == NULL) { create_failed = true; return; }
  lv_obj_set_pos(line, 0, 0);
  lv_obj_set_style_line_color(line, lv_color_hex(COLOR_WHITE), 0);
  lv_obj_set_style_line_width(line, 2, 0);
  lv_line_set_points(line, frame, sizeof(frame) / sizeof(frame[0]));
}

static lv_obj_t *metric_card(lv_obj_t *screen, int y, const char *title,
                             const char *symbol, uint32_t accent)
{
  lv_obj_t *card = box(screen, 171, y, 144, 47, COLOR_PANEL, COLOR_BORDER, 5);
  if (card == NULL) return NULL;
  (void)box(card, 0, 3, 4, 41, accent, accent, 2);
  (void)box(card, 9, 12, 22, 22, COLOR_PANEL, accent, LV_RADIUS_CIRCLE);
  (void)text(card, 10, 16, 20, symbol, &font_dashboard_12, accent, LV_TEXT_ALIGN_CENTER);
  (void)box(card, 37, 7, 1, 33, COLOR_BORDER, COLOR_BORDER, 0);
  (void)text(card, 44, 3, 94, title, &font_dashboard_12, COLOR_MUTED, LV_TEXT_ALIGN_LEFT);
  return text(card, 44, 19, 94, "0", &font_dashboard_20, COLOR_WHITE, LV_TEXT_ALIGN_LEFT);
}

static bool duty_card(lv_obj_t *screen, int x, const char *title, uint32_t accent,
                      lv_obj_t **value, lv_obj_t **fill)
{
  lv_obj_t *card = box(screen, x, 191, 153, 44, COLOR_PANEL, accent, 5);
  if (card == NULL) return false;
  (void)text(card, 8, 5, 83, title, &font_dashboard_12, COLOR_WHITE, LV_TEXT_ALIGN_LEFT);
  *value = text(card, 95, 5, 49, "0%", &font_dashboard_12, COLOR_WHITE, LV_TEXT_ALIGN_RIGHT);
  lv_obj_t *track = box(card, 8, 27, 137, 8, COLOR_TRACK, COLOR_TRACK, 4);
  if (track == NULL) return false;
  *fill = box(track, 0, 0, 1, 8, accent, accent, 4);
  return *value != NULL && *fill != NULL;
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
  (void)text(screen, 45, 7, 56, "E-BIKE", &font_dashboard_12, COLOR_WHITE, LV_TEXT_ALIGN_LEFT);

  lv_obj_t *battery = box(screen, 153, 6, 34, 14, COLOR_PANEL, COLOR_WHITE, 2);
  if (battery != NULL) ui.battery_fill = box(battery, 2, 2, 29, 10, COLOR_GREEN, COLOR_GREEN, 0);
  (void)box(screen, 187, 10, 3, 6, COLOR_WHITE, COLOR_WHITE, 1);
  ui.battery_text = text(screen, 193, 7, 45, "0%", &font_dashboard_12, COLOR_WHITE, LV_TEXT_ALIGN_LEFT);
  ui.headlight = text(screen, 247, 7, 50, "LIGHT", &font_dashboard_12, COLOR_CYAN, LV_TEXT_ALIGN_LEFT);
  ui.led = lv_led_create(screen);
  if (ui.led != NULL) {
    lv_obj_set_pos(ui.led, 303, 8);
    lv_obj_set_size(ui.led, 10, 10);
    lv_obj_set_style_bg_color(ui.led, lv_color_white(), 0);
    lv_obj_set_style_bg_opa(ui.led, LV_OPA_COVER, 0);
    lv_obj_set_style_radius(ui.led, LV_RADIUS_CIRCLE, 0);
    lv_led_on(ui.led);
  } else create_failed = true;

  ui.gauge = lv_arc_create(screen);
  if (ui.gauge != NULL) {
    lv_obj_set_pos(ui.gauge, 3, 29);
    lv_obj_set_size(ui.gauge, 160, 160);
    lv_obj_set_clickable(ui.gauge, false);
    lv_obj_set_style_bg_opa(ui.gauge, LV_OPA_TRANSP, LV_PART_MAIN);
    lv_obj_set_style_border_width(ui.gauge, 0, LV_PART_MAIN);
    lv_obj_set_style_pad_all(ui.gauge, 0, LV_PART_MAIN);
    lv_obj_set_style_arc_width(ui.gauge, 9, LV_PART_MAIN);
    lv_obj_set_style_arc_color(ui.gauge, lv_color_hex(COLOR_TRACK), LV_PART_MAIN);
    lv_obj_set_style_arc_width(ui.gauge, 9, LV_PART_INDICATOR);
    lv_obj_set_style_arc_color(ui.gauge, lv_color_hex(COLOR_CYAN), LV_PART_INDICATOR);
    lv_obj_set_style_arc_rounded(ui.gauge, true, LV_PART_INDICATOR);
    lv_obj_remove_style(ui.gauge, NULL, LV_PART_KNOB);
    lv_obj_set_style_bg_opa(ui.gauge, LV_OPA_TRANSP, LV_PART_KNOB);
    lv_arc_set_bg_angles(ui.gauge, 135, 45);
    lv_arc_set_range(ui.gauge, 0, 99);
  } else create_failed = true;
  (void)text(screen, 25, 62, 116, "SPEED", &font_dashboard_12, COLOR_MUTED, LV_TEXT_ALIGN_CENTER);
  ui.speed = text(screen, 14, 78, 140, "0", &font_speed_58, COLOR_WHITE, LV_TEXT_ALIGN_CENTER);
  (void)text(screen, 25, 145, 116, "km/h", &font_dashboard_12, COLOR_CYAN, LV_TEXT_ALIGN_CENTER);

  ui.voltage = metric_card(screen, 30, "Voltage", "V", COLOR_GREEN);
  ui.current = metric_card(screen, 82, "Current", "A", COLOR_CYAN);
  ui.power = metric_card(screen, 134, "Power", "W", COLOR_YELLOW);
  (void)duty_card(screen, 4, "BRAKE", COLOR_RED, &ui.brake_text, &ui.brake_fill);
  (void)duty_card(screen, 163, "THROTTLE", COLOR_GREEN, &ui.throttle_text, &ui.throttle_fill);

  return !create_failed && ui.speed && ui.gauge && ui.battery_fill && ui.battery_text &&
         ui.headlight && ui.led && ui.voltage && ui.current && ui.power &&
         ui.brake_text && ui.brake_fill && ui.throttle_text && ui.throttle_fill;
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

void Dashboard_Refresh(const DashboardData *data)
{
  if (data == NULL || create_failed) return;
  if (!previous_valid || data->current_speed_kmh != previous.current_speed_kmh) {
    lv_label_set_text_fmt(ui.speed, "%u", (unsigned)data->current_speed_kmh);
    lv_arc_set_value(ui.gauge, data->current_speed_kmh > 99U ? 99 : data->current_speed_kmh);
  }
  if (!previous_valid || data->battery_percent != previous.battery_percent) {
    uint8_t value = limit_percent(data->battery_percent);
    lv_label_set_text_fmt(ui.battery_text, "%u%%", (unsigned)value);
    set_bar(ui.battery_fill, value, 29);
  }
  if (!previous_valid || data->voltage_tenths_v != previous.voltage_tenths_v)
    lv_label_set_text_fmt(ui.voltage, "%u.%u V", (unsigned)(data->voltage_tenths_v / 10U), (unsigned)(data->voltage_tenths_v % 10U));
  if (!previous_valid || data->current_tenths_a != previous.current_tenths_a)
    lv_label_set_text_fmt(ui.current, "%u.%u A", (unsigned)(data->current_tenths_a / 10U), (unsigned)(data->current_tenths_a % 10U));
  if (!previous_valid || data->power_w != previous.power_w)
    lv_label_set_text_fmt(ui.power, "%u W", (unsigned)data->power_w);
  if (!previous_valid || data->brake_percent != previous.brake_percent) {
    uint8_t value = limit_percent(data->brake_percent);
    lv_label_set_text_fmt(ui.brake_text, "%u%%", (unsigned)value);
    set_bar(ui.brake_fill, value, 137);
  }
  if (!previous_valid || data->throttle_percent != previous.throttle_percent) {
    uint8_t value = limit_percent(data->throttle_percent);
    lv_label_set_text_fmt(ui.throttle_text, "%u%%", (unsigned)value);
    set_bar(ui.throttle_fill, value, 137);
  }
  if (!previous_valid || data->headlight_on != previous.headlight_on)
    lv_obj_set_style_text_color(ui.headlight, lv_color_hex(data->headlight_on ? COLOR_CYAN : COLOR_MUTED), 0);
  if (!previous_valid || data->led_state != previous.led_state) {
    uint32_t color = data->led_state == DASHBOARD_LED_BLUE ? 0x0000FF :
                     data->led_state == DASHBOARD_LED_GREEN ? COLOR_GREEN : COLOR_RED;
    lv_led_set_color(ui.led, lv_color_hex(color));
  }
  previous = *data;
  previous_valid = true;
}
