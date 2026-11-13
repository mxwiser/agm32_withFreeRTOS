#ifndef USER_LCD_ST7789_CONFIG_H
#define USER_LCD_ST7789_CONFIG_H

#include "board.h"

// AGRV2K_303 L48 的 J6 接口；PA/PB 名称为原理图管脚，非 SDK GPIO 编号。
#define LCD_SPI              SPI0
#define LCD_SPI_CLOCK_MASK   APB_MASK_SPI0
#define LCD_DMA_CHANNEL      DMAC_CHANNEL6
#define LCD_SCK_GPIO         GPIO4
#define LCD_SCK_BIT          GPIO_BIT5 // PIN_28, PB15, J6.3
#define LCD_SDA_GPIO         GPIO0
#define LCD_SDA_BIT          GPIO_BIT0 // PIN_29, PA8,  J6.4
#define LCD_CS_GPIO          GPIO4
#define LCD_CS_BIT           GPIO_BIT6 // PIN_32, PA11, J6.7
#define LCD_CONTROL_GPIO     GPIO5
#define LCD_RESET_BIT        GPIO_BIT1 // PIN_30, PA9,  J6.5
#define LCD_DC_BIT           GPIO_BIT2 // PIN_31, PA10, J6.6
// 背光管脚定义与 board_init() 共用，位于 board.h（J6.8）。

// SPI 最高频率：200 MHz 外设时钟下分频为 4，得到 50 MHz。
// 若屏幕或连线无法稳定工作，可降低至 25000000 或 12500000。
// 实际分频依据外设时钟计算并向上取偶数；超时单位为毫秒。
#define LCD_SPI_MAX_HZ       50000000UL
#define LCD_SPI_TIMEOUT_MS   100U

// J6 无 TE 引脚；为 1 时尝试 SDA 读回，不支持读回的屏仍可显示。
// SDA 只能写入时可设为 0，禁用读回探测。
#ifndef LCD_TRY_SDA_READ
#define LCD_TRY_SDA_READ     1
#endif
// 无 TE 参考方案采用模式 3 进行双向 SDA 读取。
#define LCD_READ_MODE3       1
// 读取 GSCAN 扫描行之前丢弃的虚拟位数，不同屏幕型号可能不同。
#ifndef LCD_SCANLINE_DUMMY_BITS
#define LCD_SCANLINE_DUMMY_BITS 8U
#endif

#endif
