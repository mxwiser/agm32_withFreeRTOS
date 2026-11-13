#ifndef USER_LCD_ST7789_PORT_H
#define USER_LCD_ST7789_PORT_H

#include "st7789.h"

// Board transport. Kept separate so panel commands can be tested without MMIO.
ST7789_Status ST7789_PortInit(void);
void ST7789_PortReset(bool asserted);
void ST7789_PortBacklight(bool on);
void ST7789_PortBegin(bool data);
void ST7789_PortDataMode(void);
void ST7789_PortEnd(void);
ST7789_Status ST7789_PortWrite(const uint8_t *data, size_t length);
// Buffer must have one extra guard word after its rounded length.
// It must be 4-byte aligned and length must be <= 4092 bytes.
ST7789_Status ST7789_PortWriteDMA(const uint32_t *data, size_t length);
ST7789_Status ST7789_PortRead(uint8_t command, uint8_t dummy_bits,
                               uint8_t *data, size_t length);
ST7789_Status ST7789_PortReadScanline(uint8_t *data);
void ST7789_PortDelayMs(uint32_t ms);
uint32_t ST7789_PortMillis(void);

#endif
