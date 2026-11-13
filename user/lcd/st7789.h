#ifndef USER_LCD_ST7789_H
#define USER_LCD_ST7789_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define ST7789_NATIVE_WIDTH  240U
#define ST7789_NATIVE_HEIGHT 320U

#define ST7789_BLACK   0x0000U
#define ST7789_WHITE   0xffffU
#define ST7789_RED     0xf800U
#define ST7789_GREEN   0x07e0U
#define ST7789_BLUE    0x001fU
#define ST7789_YELLOW  0xffe0U
#define ST7789_CYAN    0x07ffU
#define ST7789_MAGENTA 0xf81fU

typedef enum {
  ST7789_OK = 0,
  ST7789_INVALID_ARGUMENT,
  ST7789_NOT_INITIALIZED,
  ST7789_TIMEOUT,
  ST7789_IO_ERROR,
  ST7789_READ_UNSUPPORTED
} ST7789_Status;

static inline uint16_t ST7789_RGB565(uint8_t red, uint8_t green, uint8_t blue)
{
  return ((uint16_t)(red & 0xf8U) << 8) |
         ((uint16_t)(green & 0xfcU) << 3) | (blue >> 3);
}

// Call after board_init(), from task context or before starting the scheduler.
// Initial orientation is rotation 1: 320 x 240 landscape.
// All calls are blocking: the SPI/DMA transfer is complete when they return.
// Use one LCD task, or protect ALL calls with the same external mutex.
ST7789_Status ST7789_Init(void);
ST7789_Status ST7789_SetRotation(uint8_t rotation); // 0, 1, 2, 3 (90-degree steps)
uint16_t ST7789_Width(void);
uint16_t ST7789_Height(void);
void ST7789_SetBacklight(bool on);

ST7789_Status ST7789_FillScreen(uint16_t color);
// Coordinates use x, y, width, height; rectangles must fit entirely on screen.
ST7789_Status ST7789_FillRect(uint16_t x, uint16_t y, uint16_t width,
                               uint16_t height, uint16_t color);
// Row-major RGB565 values in CPU byte order; no byte swapping by the caller.
// pixels must contain at least width * height uint16_t values.
ST7789_Status ST7789_DrawRGB565(uint16_t x, uint16_t y, uint16_t width,
                                 uint16_t height, const uint16_t *pixels);

// J6 has no MISO or TE. Readback is possible ONLY on panels that return data
// through SDA (bidirectional serial interface I). Writes always use hardware SPI.
// Probe checks changing MADCTL values, then restores the current orientation.
ST7789_Status ST7789_ProbeReadback(void);
bool ST7789_CanRead(void);
ST7789_Status ST7789_ReadRegister(uint8_t command, uint8_t dummy_bits,
                                   uint8_t *data, size_t length);
ST7789_Status ST7789_ReadScanline(uint16_t *line);
// Wait for a measured scanline wrap, with a finite timeout. This aligns the
// START of a transfer to a frame; it does not make a slow full-screen write atomic.
ST7789_Status ST7789_WaitFrameStart(uint32_t timeout_ms);
ST7789_Status ST7789_FillScreenSync(uint16_t color, uint32_t timeout_ms);

#ifdef __cplusplus
}
#endif
#endif
