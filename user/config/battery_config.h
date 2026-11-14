#ifndef USER_BATTERY_CONFIG_H
#define USER_BATTERY_CONFIG_H

/* 电池串数和类型读取自 VESC；电压估算仅供界面显示，不用于电池保护。 */
#define BATTERY_MAX_SERIES_CELLS 32U         /* 接受的最大串数，异常配置不用于估算。 */
#define BATTERY_LOW_PERCENT 20U              /* 低于此百分比时电池图标变红。 */
#define BATTERY_DISPLAY_EMPTY_CELL_MV 3300U  /* 锂离子显示 0% 的单节电压，毫伏。 */
#define BATTERY_FULL_CELL_MV 4200U           /* 锂离子显示 100% 的单节电压，毫伏。 */
#define BATTERY_LIFEPO4_EMPTY_CELL_MV 2600U  /* 磷酸铁锂显示估算范围，非保护值。 */
#define BATTERY_LIFEPO4_FULL_CELL_MV 3600U
#define BATTERY_LEAD_EMPTY_CELL_MV 2100U    /* 铅酸显示估算范围，非保护值。 */
#define BATTERY_LEAD_FULL_CELL_MV 2360U

#if BATTERY_DISPLAY_EMPTY_CELL_MV >= 3500U || BATTERY_FULL_CELL_MV <= 4050U || \
    BATTERY_LIFEPO4_EMPTY_CELL_MV >= BATTERY_LIFEPO4_FULL_CELL_MV || \
    BATTERY_LEAD_EMPTY_CELL_MV >= BATTERY_LEAD_FULL_CELL_MV
#error "Battery display curve voltages must be strictly increasing"
#endif
#endif
