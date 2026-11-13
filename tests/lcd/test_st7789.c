// Host-side command/transport contract tests. No MCU registers are accessed.
#include "st7789_port.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

static uint8_t payload[160000];
static size_t payload_length;
static uint8_t current_command, simulated_madctl;
static uint8_t column[4], row[4];
static bool data_mode, selected, read_supported = true;
static bool transfer_failure, freeze_scan, bad_scan;
static uint16_t scanline;
static uint32_t milliseconds;
static FILE *init_log;

ST7789_Status ST7789_PortInit(void) { return ST7789_OK; }
void ST7789_PortReset(bool asserted) { (void)asserted; }
void ST7789_PortBacklight(bool on) { (void)on; }
void ST7789_PortBegin(bool data) { selected = true; data_mode = data; }
void ST7789_PortDataMode(void) { data_mode = true; }
void ST7789_PortEnd(void) { selected = false; }
void ST7789_PortDelayMs(uint32_t ms) { milliseconds += ms; }
uint32_t ST7789_PortMillis(void) { return milliseconds++; }

ST7789_Status ST7789_PortWrite(const uint8_t *data, size_t length)
{
  assert(selected);
  if (transfer_failure) {
    return ST7789_IO_ERROR;
  }
  if (!data_mode) {
    assert(length == 1);
    current_command = data[0];
    if (init_log) {
      fprintf(init_log, "\n%02x:", current_command);
    }
    if (current_command == 0x2c) {
      payload_length = 0;
    }
  } else {
    if (init_log) {
      for (size_t i = 0; i < length; ++i) {
        fprintf(init_log, "%02x", data[i]);
      }
    }
    if (current_command == 0x2c) {
      assert(!"Pixel data must be sent using DMA");
    } else if (current_command == 0x36) {
      simulated_madctl = data[0];
    } else if (current_command == 0x2a) {
      assert(length == sizeof(column));
      memcpy(column, data, length);
    } else if (current_command == 0x2b) {
      assert(length == sizeof(row));
      memcpy(row, data, length);
    }
  }
  return ST7789_OK;
}

ST7789_Status ST7789_PortWriteDMA(const uint32_t *data, size_t length)
{
  assert(selected && data_mode && current_command == 0x2c);
  assert(((uintptr_t)data & 3U) == 0);
  assert(length != 0 && length <= 4092);
  if (transfer_failure) {
    return ST7789_IO_ERROR;
  }
  assert(payload_length + length <= sizeof(payload));
  memcpy(payload + payload_length, data, length);
  payload_length += length;
  return ST7789_OK;
}

ST7789_Status ST7789_PortRead(uint8_t command, uint8_t dummy_bits,
                               uint8_t *data, size_t length)
{
  (void)dummy_bits;
  assert(length == 1);
  // Simulate an input held low on an unreadable module, not a transport error.
  data[0] = !read_supported ? 0 : command == 0x0b ? simulated_madctl : 0x05;
  return ST7789_OK;
}

ST7789_Status ST7789_PortReadScanline(uint8_t *data)
{
  if (!freeze_scan) {
    scanline = (scanline + 20U) % 331U;
  }
  uint16_t value = bad_scan ? 0xffffU : scanline;
  data[0] = value >> 8;
  data[1] = value & 0xff;
  return ST7789_OK;
}

int main(int argc, char **argv)
{
  assert(ST7789_FillScreen(ST7789_RED) == ST7789_NOT_INITIALIZED);
  if (argc > 1) {
    init_log = fopen(argv[1], "w");
    assert(init_log);
  }
  assert(ST7789_Init() == ST7789_OK);
  if (init_log) {
    fclose(init_log);
    init_log = NULL;
  }
  assert(!selected);
  assert(ST7789_Width() == 320 && ST7789_Height() == 240);
  assert(simulated_madctl == 0x60);
  assert(payload_length == 240U * 320U * 2U);
  for (size_t i = 0; i < payload_length; ++i) {
    assert(payload[i] == 0);
  }
  assert(ST7789_FillScreen(ST7789_RED) == ST7789_OK);
  assert(payload_length == 153600U);
  for (size_t i = 0; i < payload_length; i += 2) {
    assert(payload[i] == 0xf8 && payload[i + 1] == 0);
  }
  const uint8_t last_column[4] = {0, 0, 1, 63};
  const uint8_t last_row[4] = {0, 0, 0, 239};
  assert(memcmp(column, last_column, 4) == 0);
  assert(memcmp(row, last_row, 4) == 0);

  // A single last pixel must not be dropped or extended to two pixels by DMA.
  assert(ST7789_FillRect(319, 239, 1, 1, ST7789_BLUE) == ST7789_OK);
  assert(payload_length == 2 && payload[0] == 0 && payload[1] == 0x1f);
  assert(ST7789_FillRect(319, 239, 2, 1, 0) == ST7789_INVALID_ARGUMENT);
  assert(ST7789_FillRect(0, 0, 0, 10, 0) == ST7789_INVALID_ARGUMENT);
  assert(ST7789_FillRect(0, 0, 65535, 65535, 0) == ST7789_INVALID_ARGUMENT);
  assert(ST7789_DrawRGB565(0, 0, 1, 1, NULL) == ST7789_INVALID_ARGUMENT);

  uint16_t image[513]; // crosses the chunk boundary with an odd tail
  for (size_t i = 0; i < 513; ++i) {
    image[i] = (uint16_t)(i * 97U);
  }
  const uint16_t small_image[] = {ST7789_RED, ST7789_BLUE};
  assert(ST7789_DrawRGB565(0, 0, 1, 1, small_image) == ST7789_OK);
  assert(payload_length == 2 && payload[0] == 0xf8 && payload[1] == 0x00);
  assert(ST7789_DrawRGB565(0, 0, 2, 1, small_image) == ST7789_OK);
  assert(payload_length == 4 && payload[2] == 0x00 && payload[3] == 0x1f);
  assert(ST7789_DrawRGB565(0, 0, 171, 3, image) == ST7789_OK);
  assert(payload_length == sizeof(image));
  for (size_t i = 0; i < 513; ++i) {
    assert(payload[i * 2] == image[i] >> 8);
    assert(payload[i * 2 + 1] == (image[i] & 0xff));
  }
  for (uint8_t rotation = 0; rotation < 4; ++rotation) {
    assert(ST7789_SetRotation(rotation) == ST7789_OK);
    assert(ST7789_Width() == ((rotation & 1) ? 320 : 240));
    assert(ST7789_Height() == ((rotation & 1) ? 240 : 320));
  }
  assert(ST7789_SetRotation(4) == ST7789_INVALID_ARGUMENT);
  assert(ST7789_SetRotation(0) == ST7789_OK);

  assert(ST7789_FillScreenSync(0, 100) == ST7789_READ_UNSUPPORTED);
  read_supported = false;
  assert(ST7789_ProbeReadback() == ST7789_READ_UNSUPPORTED);
  assert(!ST7789_CanRead() && simulated_madctl == 0);
  read_supported = true;
  assert(ST7789_ProbeReadback() == ST7789_OK && ST7789_CanRead());
  assert(ST7789_FillScreenSync(ST7789_GREEN, 100) == ST7789_OK);
  freeze_scan = true;
  milliseconds = UINT32_MAX - 4U; // timeout must also work across timer rollover
  size_t old_payload_length = payload_length;
  assert(ST7789_FillScreenSync(0, 100) == ST7789_TIMEOUT);
  assert(payload_length == old_payload_length);
  bad_scan = true;
  uint16_t line = 0;
  assert(ST7789_ReadScanline(&line) == ST7789_IO_ERROR);
  assert(ST7789_WaitFrameStart(0) == ST7789_INVALID_ARGUMENT);
  transfer_failure = true;
  assert(ST7789_FillScreen(0) == ST7789_IO_ERROR && !selected);
  assert(ST7789_Init() == ST7789_IO_ERROR);
  assert(ST7789_FillScreen(0) == ST7789_NOT_INITIALIZED);
  assert(ST7789_RGB565(255, 0, 0) == ST7789_RED);
  assert(ST7789_RGB565(0, 255, 0) == ST7789_GREEN);
  assert(ST7789_RGB565(0, 0, 255) == ST7789_BLUE);
  puts("ST7789: pixel order, dimensions, odd DMA tail, bounds, rotation, readback, sync and error checks passed.");
  return 0;
}
