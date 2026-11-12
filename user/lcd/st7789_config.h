#ifndef USER_LCD_ST7789_CONFIG_H
#define USER_LCD_ST7789_CONFIG_H

#include "board.h"

// AGRV2K_303 L48, J6; PA/PB names are schematic pad names, not SDK GPIO IDs.
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
// Backlight definitions are shared with board_init() in board.h (J6.8).

// Performance profile: 200 MHz PCLK / 4 = 50 MHz, verified on the actual panel.
// This exceeds the conservative 66 ns ST7789V datasheet write cycle; lower to
// 25000000 or 12500000 for modules/cabling that cannot sustain this setting.
// The divisor is calculated from actual PCLK and rounded up to an even value.
#define LCD_SPI_MAX_HZ       50000000UL
#define LCD_SPI_TIMEOUT_MS   100U

// There is no TE pad on J6. Try SDA readback; unsupported panels still display.
// Set to 0 to disable probes on a panel with a write-only SDA connection.
#ifndef LCD_TRY_SDA_READ
#define LCD_TRY_SDA_READ     1
#endif
// GSCAN 0x45: discard its dummy read before the two scanline bytes.
// Some panel variants use different serial dummy timing; this is configurable.
#ifndef LCD_SCANLINE_DUMMY_BITS
#define LCD_SCANLINE_DUMMY_BITS 8U
#endif

#endif
