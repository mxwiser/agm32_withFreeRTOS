#ifndef LV_CONF_H
#define LV_CONF_H

/* A single FreeRTOS task owns LVGL and the LCD. */
#define LV_USE_OS LV_OS_NONE
#define LV_COLOR_FORMAT_DEFAULT LV_COLOR_FORMAT_RGB565
#define LV_MEM_SIZE (32U * 1024U)
#define LV_DEF_REFR_PERIOD 33
/* Keep only the 48 px ASCII font used by the interface. */
#define LV_FONT_MONTSERRAT_14 0
#define LV_FONT_MONTSERRAT_18 0
#define LV_FONT_MONTSERRAT_48 0 /* Full 48 px font is replaced by user_fonts/font_bike_48.c. */
#define LV_FONT_CUSTOM_DECLARE LV_FONT_DECLARE(lv_font_bike_48)
#define LV_FONT_DEFAULT (&lv_font_bike_48)

/* The firmware shares 256 KiB flash with the compressed FPGA image. */
#define LV_USE_THEME_DEFAULT 0
#define LV_USE_THEME_SIMPLE 1
#define LV_USE_THEME_MONO 0
/* The current interface uses explicit positioning, not automatic layouts. */
#define LV_USE_FLEX 0
#define LV_USE_GRID 0
#define LV_USE_OBSERVER 0
#define LV_DRAW_SW_SUPPORT_RGB565_SWAPPED 0
#define LV_DRAW_SW_SUPPORT_RGB565A8 0
#define LV_DRAW_SW_SUPPORT_RGB888 0
#define LV_DRAW_SW_SUPPORT_XRGB8888 0
#define LV_DRAW_SW_SUPPORT_ARGB8888 0
#define LV_DRAW_SW_SUPPORT_ARGB8888_PREMULTIPLIED 0
#define LV_DRAW_SW_SUPPORT_L8 0
#define LV_DRAW_SW_SUPPORT_AL88 0
#define LV_DRAW_SW_SUPPORT_A8 0
#define LV_DRAW_SW_SUPPORT_I1 0
#define LV_USE_ANIMIMG 0
#define LV_USE_ARC 1
#define LV_USE_ARCLABEL 0
#define LV_USE_BAR 0
#define LV_USE_BUTTON 0
#define LV_USE_BUTTONMATRIX 0
#define LV_USE_CALENDAR 0
#define LV_USE_CANVAS 0
#define LV_USE_CHART 0
#define LV_USE_CHECKBOX 0
#define LV_USE_DROPDOWN 0
#define LV_USE_IMAGE 0
#define LV_USE_IMAGEBUTTON 0
#define LV_USE_KEYBOARD 0
#define LV_USE_LED 1
#define LV_USE_LINE 1
#define LV_USE_LIST 0
#define LV_USE_MENU 0
#define LV_USE_MSGBOX 0
#define LV_USE_ROLLER 0
#define LV_USE_SCALE 0
#define LV_USE_SLIDER 0
#define LV_USE_SPAN 0
#define LV_USE_SPINBOX 0
#define LV_USE_SPINNER 0
#define LV_USE_SWITCH 0
#define LV_USE_TEXTAREA 0
#define LV_USE_TABLE 0
#define LV_USE_TABVIEW 0
#define LV_USE_TILEVIEW 0
#define LV_USE_WIN 0

#endif
