#ifndef LV_CONF_H
#define LV_CONF_H

/* LVGL 由单个 FreeRTOS 任务独占；颜色格式、内存和刷新周期。 */
#define LV_USE_OS LV_OS_NONE                    /* LVGL 自身不使用操作系统锁。 */
#define LV_COLOR_FORMAT_DEFAULT LV_COLOR_FORMAT_RGB565 /* 默认 16 位 RGB565。 */
#define LV_MEM_SIZE (32U * 1024U)               /* LVGL 内存池大小，字节。 */
#define LV_DEF_REFR_PERIOD 33                   /* 默认界面刷新周期，毫秒。 */
/* 界面字体使用 user/user_fonts 下的精简字库。 */
#define LV_FONT_MONTSERRAT_14 0 /* 关闭内置 14 号字体。 */
#define LV_FONT_MONTSERRAT_18 0 /* 关闭内置 18 号字体。 */
#define LV_FONT_MONTSERRAT_48 0 /* 采用自定义精简字体，避免完整字库占用过多 Flash。 */
#define LV_FONT_CUSTOM_DECLARE LV_FONT_DECLARE(font_dashboard_14) /* 声明自定义字体。 */
#define LV_FONT_DEFAULT (&font_dashboard_14) /* 默认字体。 */

/* 为节省 Flash，仅启用当前界面需要的主题、渲染格式与控件。 */
#define LV_USE_THEME_DEFAULT 0 /* 默认主题。 */
#define LV_USE_THEME_SIMPLE 1  /* 精简主题。 */
#define LV_USE_THEME_MONO 0    /* 单色主题。 */
/* 当前界面使用固定坐标，不使用自动布局。 */
#define LV_USE_FLEX 0     /* 弹性布局。 */
#define LV_USE_GRID 0     /* 网格布局。 */
#define LV_USE_OBSERVER 0 /* 数据观察者。 */
#define LV_DRAW_SW_SUPPORT_RGB565_SWAPPED 0 /* 字节交换的 RGB565 软件绘制。 */
#define LV_DRAW_SW_SUPPORT_RGB565A8 0      /* 带独立透明通道的 RGB565 绘制。 */
#define LV_DRAW_SW_SUPPORT_RGB888 0        /* RGB888 绘制。 */
#define LV_DRAW_SW_SUPPORT_XRGB8888 0      /* XRGB8888 绘制。 */
#define LV_DRAW_SW_SUPPORT_ARGB8888 0      /* ARGB8888 绘制。 */
#define LV_DRAW_SW_SUPPORT_ARGB8888_PREMULTIPLIED 0 /* 预乘透明度 ARGB 绘制。 */
#define LV_DRAW_SW_SUPPORT_L8 0   /* 8 位灰度绘制。 */
#define LV_DRAW_SW_SUPPORT_AL88 0 /* 灰度加透明度绘制。 */
#define LV_DRAW_SW_SUPPORT_A8 0   /* 8 位透明度绘制。 */
#define LV_DRAW_SW_SUPPORT_I1 0   /* 1 位索引颜色绘制。 */
/* 以下为控件开关：1 启用，0 禁用。 */
#define LV_USE_ANIMIMG 0      /* 动画图片。 */
#define LV_USE_ARC 1          /* 圆弧。 */
#define LV_USE_ARCLABEL 0     /* 弧形文字。 */
#define LV_USE_BAR 0          /* 进度条控件。 */
#define LV_USE_BUTTON 0       /* 按钮。 */
#define LV_USE_BUTTONMATRIX 0 /* 按钮矩阵。 */
#define LV_USE_CALENDAR 0     /* 日历。 */
#define LV_USE_CANVAS 0       /* 画布。 */
#define LV_USE_CHART 0        /* 图表。 */
#define LV_USE_CHECKBOX 0     /* 复选框。 */
#define LV_USE_DROPDOWN 0     /* 下拉选择框。 */
#define LV_USE_IMAGE 0        /* 图片。 */
#define LV_USE_IMAGEBUTTON 0  /* 图片按钮。 */
#define LV_USE_KEYBOARD 0     /* 键盘。 */
#define LV_USE_LED 0          /* 指示灯控件。 */
#define LV_USE_LINE 1         /* 线段。 */
#define LV_USE_LIST 0         /* 列表。 */
#define LV_USE_MENU 0         /* 菜单。 */
#define LV_USE_MSGBOX 0       /* 消息框。 */
#define LV_USE_ROLLER 0       /* 滚轮选择器。 */
#define LV_USE_SCALE 0        /* 刻度。 */
#define LV_USE_SLIDER 0       /* 滑块。 */
#define LV_USE_SPAN 0         /* 富文本。 */
#define LV_USE_SPINBOX 0      /* 数值输入框。 */
#define LV_USE_SPINNER 0      /* 加载动画。 */
#define LV_USE_SWITCH 0       /* 开关。 */
#define LV_USE_TEXTAREA 0     /* 文本输入区。 */
#define LV_USE_TABLE 0        /* 表格。 */
#define LV_USE_TABVIEW 0      /* 标签页。 */
#define LV_USE_TILEVIEW 0     /* 平铺页面。 */
#define LV_USE_WIN 0          /* 窗口。 */

#endif
