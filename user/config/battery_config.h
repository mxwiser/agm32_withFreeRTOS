#ifndef USER_BATTERY_CONFIG_H
#define USER_BATTERY_CONFIG_H

/* 电池串数读取自 VESC；电压估算仅供界面显示，不用于电池保护。 */
#define BATTERY_MAX_SERIES_CELLS 32U         /* 接受的最大串数，异常配置不用于估算。 */
#define BATTERY_LOW_PERCENT 20U              /* 低于此百分比时电池图标变红。 */
#define BATTERY_DISPLAY_EMPTY_CELL_MV 3300U  /* 显示 0% 对应的单节电压，毫伏。 */
#define BATTERY_FULL_CELL_MV 4200U           /* 显示 100% 对应的单节电压，毫伏。 */
#endif
