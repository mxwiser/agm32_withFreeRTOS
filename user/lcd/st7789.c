#include "st7789.h"
#include "st7789_port.h"

// The panel's tuned values come from 2.4TFTST7789参考代码/2.4TFT7P.C,
// TFT_init(). Keep the power, porch, frame-rate and gamma values together.
typedef struct {
  uint8_t command;
  uint8_t length;
  uint8_t data[14];
} InitCommand;

#define DEFAULT_MADCTL 0x60U // rotation 1: landscape, RGB

static const InitCommand panel_init[] = {
  {0x3a, 1, {0x05}}, // RGB565, as in the vendor example
  {0xc5, 1, {0x1a}},
  {0x36, 1, {DEFAULT_MADCTL}},
  {0xb2, 5, {0x05, 0x05, 0x00, 0x33, 0x33}},
  {0xb7, 1, {0x05}},
  {0xbb, 1, {0x3f}},
  {0xc0, 1, {0x2c}},
  {0xc2, 1, {0x01}},
  {0xc3, 1, {0x0f}},
  {0xc4, 1, {0x20}},
  {0xc6, 1, {0x01}}, // vendor setting, approximately 111 Hz (not MCU FPS)
  {0xd0, 2, {0xa4, 0xa1}},
  {0xe8, 1, {0x03}},
  {0xe9, 3, {0x09, 0x09, 0x08}},
  {0xe0, 14, {0xd0, 0x05, 0x09, 0x09, 0x08, 0x14, 0x28,
              0x33, 0x3f, 0x07, 0x13, 0x14, 0x28, 0x30}},
  {0xe1, 14, {0xd0, 0x05, 0x09, 0x09, 0x08, 0x03, 0x24,
              0x32, 0x32, 0x3b, 0x14, 0x13, 0x28, 0x2f}},
};

#define TRANSFER_PIXELS 512U
#define MAX_SCANLINE    511U

static uint32_t pixel_buffer[TRANSFER_PIXELS / 2U]; // 1024 bytes, DMA aligned
static uint16_t screen_width = ST7789_NATIVE_HEIGHT;
static uint16_t screen_height = ST7789_NATIVE_WIDTH;
static uint8_t madctl = DEFAULT_MADCTL;
static bool initialized;
static bool readback_ready;

static ST7789_Status command(uint8_t cmd, const uint8_t *data, size_t length)
{
  ST7789_PortBegin(false);
  ST7789_Status result = ST7789_PortWrite(&cmd, 1);
  if (result == ST7789_OK && length != 0) {
    ST7789_PortDataMode();
    result = ST7789_PortWrite(data, length);
  }
  ST7789_PortEnd();
  return result;
}

static bool valid_rect(uint16_t x, uint16_t y, uint16_t width, uint16_t height)
{
  return width != 0 && height != 0 && x < screen_width && y < screen_height &&
         width <= screen_width - x && height <= screen_height - y;
}

// Leave CS asserted with DC high after RAMWR. Caller must always PortEnd().
static ST7789_Status begin_pixels(uint16_t x, uint16_t y,
                                   uint16_t width, uint16_t height)
{
  uint16_t end = x + width - 1U;
  uint8_t address[4] = {x >> 8, x & 0xffU, end >> 8, end & 0xffU};
  ST7789_Status result = command(0x2a, address, sizeof(address));
  if (result != ST7789_OK) {
    return result;
  }
  end = y + height - 1U;
  address[0] = y >> 8;
  address[1] = y & 0xffU;
  address[2] = end >> 8;
  address[3] = end & 0xffU;
  result = command(0x2b, address, sizeof(address));
  if (result == ST7789_OK) {
    const uint8_t ramwr = 0x2c;
    ST7789_PortBegin(false);
    result = ST7789_PortWrite(&ramwr, 1);
    ST7789_PortDataMode();
  }
  return result;
}

ST7789_Status ST7789_Init(void)
{
  initialized = false;
  readback_ready = false;
  ST7789_Status result = ST7789_PortInit();
  if (result != ST7789_OK) {
    return result;
  }
  ST7789_PortBacklight(false);
  ST7789_PortReset(true);
  ST7789_PortDelayMs(10);
  ST7789_PortReset(false);
  ST7789_PortDelayMs(120);
  result = command(0x01, NULL, 0); // software reset
  if (result != ST7789_OK) {
    return result;
  }
  ST7789_PortDelayMs(120);
  result = command(0x11, NULL, 0); // sleep out
  if (result != ST7789_OK) {
    return result;
  }
  ST7789_PortDelayMs(120);
  for (size_t i = 0; i < sizeof(panel_init) / sizeof(panel_init[0]); ++i) {
    result = command(panel_init[i].command, panel_init[i].data, panel_init[i].length);
    if (result != ST7789_OK) {
      return result;
    }
  }
  result = command(0x20, NULL, 0); // vendor inversion OFF, not INVON (0x21)
  if (result != ST7789_OK) {
    return result;
  }
  ST7789_PortDelayMs(120);
  screen_width = ST7789_NATIVE_HEIGHT;
  screen_height = ST7789_NATIVE_WIDTH;
  madctl = DEFAULT_MADCTL;
  initialized = true;
  // Clear random GRAM before enabling the display/backlight.
  result = ST7789_FillScreen(ST7789_BLACK);
  if (result == ST7789_OK) {
    result = command(0x29, NULL, 0);
  }
  if (result != ST7789_OK) {
    initialized = false;
    return result;
  }
  ST7789_PortBacklight(true);
  return ST7789_OK;
}

ST7789_Status ST7789_SetRotation(uint8_t rotation)
{
  static const uint8_t directions[4] = {0x00, DEFAULT_MADCTL, 0xc0, 0xa0};
  if (!initialized) {
    return ST7789_NOT_INITIALIZED;
  }
  if (rotation > 3) {
    return ST7789_INVALID_ARGUMENT;
  }
  ST7789_Status result = command(0x36, &directions[rotation], 1);
  if (result == ST7789_OK) {
    madctl = directions[rotation];
    screen_width = (rotation & 1U) ? ST7789_NATIVE_HEIGHT : ST7789_NATIVE_WIDTH;
    screen_height = (rotation & 1U) ? ST7789_NATIVE_WIDTH : ST7789_NATIVE_HEIGHT;
  }
  return result;
}

uint16_t ST7789_Width(void) { return screen_width; }
uint16_t ST7789_Height(void) { return screen_height; }
void ST7789_SetBacklight(bool on) { ST7789_PortBacklight(on); }

ST7789_Status ST7789_FillScreen(uint16_t color)
{
  return ST7789_FillRect(0, 0, screen_width, screen_height, color);
}

ST7789_Status ST7789_FillRect(uint16_t x, uint16_t y, uint16_t width,
                               uint16_t height, uint16_t color)
{
  if (!initialized) {
    return ST7789_NOT_INITIALIZED;
  }
  if (!valid_rect(x, y, width, height)) {
    return ST7789_INVALID_ARGUMENT;
  }
  // CPU and SPI are little endian; ST7789 expects each RGB565 high byte first.
  uint32_t pair = ((uint32_t)(color & 0xffU) << 8) | (color >> 8);
  pair |= pair << 16;
  for (size_t i = 0; i < sizeof(pixel_buffer) / sizeof(pixel_buffer[0]); ++i) {
    pixel_buffer[i] = pair;
  }
  ST7789_Status result = begin_pixels(x, y, width, height);
  uint32_t remaining = (uint32_t)width * height;
  while (result == ST7789_OK && remaining != 0) {
    uint32_t count = remaining > TRANSFER_PIXELS ? TRANSFER_PIXELS : remaining;
    result = ST7789_PortWriteDMA(pixel_buffer, count * 2U);
    remaining -= count;
  }
  ST7789_PortEnd();
  return result;
}

ST7789_Status ST7789_DrawRGB565(uint16_t x, uint16_t y, uint16_t width,
                                 uint16_t height, const uint16_t *pixels)
{
  if (!initialized) {
    return ST7789_NOT_INITIALIZED;
  }
  if (pixels == NULL || !valid_rect(x, y, width, height)) {
    return ST7789_INVALID_ARGUMENT;
  }
  ST7789_Status result = begin_pixels(x, y, width, height);
  uint32_t remaining = (uint32_t)width * height;
  uint8_t *bytes = (uint8_t *)pixel_buffer;
  while (result == ST7789_OK && remaining != 0) {
    uint32_t count = remaining > TRANSFER_PIXELS ? TRANSFER_PIXELS : remaining;
    for (uint32_t i = 0; i < count; ++i) {
      bytes[i * 2U] = pixels[i] >> 8;
      bytes[i * 2U + 1U] = pixels[i] & 0xffU;
    }
    result = ST7789_PortWriteDMA(pixel_buffer, count * 2U);
    pixels += count;
    remaining -= count;
  }
  ST7789_PortEnd();
  return result;
}

ST7789_Status ST7789_ReadRegister(uint8_t cmd, uint8_t dummy_bits,
                                   uint8_t *data, size_t length)
{
  if (!initialized) {
    return ST7789_NOT_INITIALIZED;
  }
  if (data == NULL || length == 0 || length > 32 || dummy_bits > 32) {
    return ST7789_INVALID_ARGUMENT;
  }
  return ST7789_PortRead(cmd, dummy_bits, data, length);
}

ST7789_Status ST7789_ProbeReadback(void)
{
  if (!initialized) {
    return ST7789_NOT_INITIALIZED;
  }
  readback_ready = false;
  // 8-bit serial register reads normally have no dummy clock. Accommodate
  // panel variants, but require TWO different known register values to pass.
  static const uint8_t dummy_options[] = {0, 1, 8};
  for (size_t i = 0; i < sizeof(dummy_options); ++i) {
    uint8_t test = madctl ^ 0x40U;
    uint8_t changed = 0;
    uint8_t restored = 0;
    uint8_t format = 0;
    ST7789_Status result = command(0x36, &test, 1);
    if (result != ST7789_OK) {
      return result;
    }
    result = ST7789_PortRead(0x0b, dummy_options[i], &changed, 1);
    // Always restore orientation, even when the panel cannot return data.
    ST7789_Status restore_result = command(0x36, &madctl, 1);
    if (restore_result != ST7789_OK) {
      return restore_result;
    }
    if (result == ST7789_READ_UNSUPPORTED) {
      return result;
    }
    if (result != ST7789_OK) {
      return result;
    }
    result = ST7789_PortRead(0x0b, dummy_options[i], &restored, 1);
    if (result != ST7789_OK) {
      return result;
    }
    result = ST7789_PortRead(0x0c, dummy_options[i], &format, 1);
    if (result != ST7789_OK) {
      return result;
    }
    if (changed == test && restored == madctl && (format & 0x07U) == 0x05U) {
      readback_ready = true;
      return ST7789_OK;
    }
  }
  return ST7789_READ_UNSUPPORTED;
}

bool ST7789_CanRead(void) { return readback_ready; }

ST7789_Status ST7789_ReadScanline(uint16_t *line)
{
  if (!initialized) {
    return ST7789_NOT_INITIALIZED;
  }
  if (line == NULL) {
    return ST7789_INVALID_ARGUMENT;
  }
  if (!readback_ready) {
    return ST7789_READ_UNSUPPORTED;
  }
  // Dummy timing for GSCAN is independent of the 8-bit register read timing.
  uint8_t data[2];
  ST7789_Status result = ST7789_PortReadScanline(data);
  if (result == ST7789_OK) {
    uint16_t value = ((uint16_t)data[0] << 8) | data[1];
    if (value > MAX_SCANLINE) {
      return ST7789_IO_ERROR;
    }
    *line = value;
  }
  return result;
}

ST7789_Status ST7789_WaitFrameStart(uint32_t timeout_ms)
{
  if (timeout_ms == 0 || timeout_ms > 1000U) {
    return ST7789_INVALID_ARGUMENT;
  }
  uint16_t previous;
  ST7789_Status result = ST7789_ReadScanline(&previous);
  if (result != ST7789_OK) {
    return result;
  }
  uint32_t start = ST7789_PortMillis();
  while ((uint32_t)(ST7789_PortMillis() - start) < timeout_ms) {
    uint16_t current;
    result = ST7789_ReadScanline(&current);
    if (result != ST7789_OK) {
      return result;
    }
    if (current < previous) {
      return ST7789_OK;
    }
    previous = current;
  }
  return ST7789_TIMEOUT; // Includes a disconnected SDA stuck at zero.
}

ST7789_Status ST7789_FillScreenSync(uint16_t color, uint32_t timeout_ms)
{
  ST7789_Status result = ST7789_WaitFrameStart(timeout_ms);
  return result == ST7789_OK ? ST7789_FillScreen(color) : result;
}
