#include "vesc_protocol.h"
#include <stddef.h>

#define VESC_COMM_GET_MCCONF 14U
#define VESC_COMM_GET_VALUES_SELECTIVE 50U
#define VESC_MAX_PAYLOAD_BYTES 1024U

/* 官方 5.02、5.03、6.00 和 7.01 的配置签名及串数偏移。偏移包含命令字节。 */
#define VESC_SIG_502 2211848314UL
#define VESC_SIG_503 2525666056UL
#define VESC_SIG_600 776184161UL
#define VESC_SIG_701 471314414UL
#define VESC_CELLS_OFFSET_502 444U
#define VESC_CELLS_OFFSET_503 466U
#define VESC_CELLS_OFFSET_600 462U
#define VESC_CELLS_OFFSET_701 467U

static uint16_t crc16_byte(uint16_t crc, uint8_t byte)
{
  crc ^= (uint16_t)byte << 8;
  for (unsigned i = 0; i < 8U; ++i)
    crc = (uint16_t)((crc & 0x8000U) ? (crc << 1) ^ 0x1021U : crc << 1);
  return crc;
}

static uint16_t crc16(const uint8_t *data, uint8_t length)
{
  uint16_t crc = 0;
  while (length-- != 0U) crc = crc16_byte(crc, *data++);
  return crc;
}

static uint16_t be16(const uint8_t *p)
{
  return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static uint32_t be32(const uint8_t *p)
{
  return ((uint32_t)p[0] << 24) | ((uint32_t)p[1] << 16) |
         ((uint32_t)p[2] << 8) | p[3];
}

void VescProtocol_Request(uint8_t frame[VESC_REQUEST_BYTES])
{
  frame[0] = 2; frame[1] = 5; frame[2] = VESC_COMM_GET_VALUES_SELECTIVE;
  frame[3] = (uint8_t)(VESC_VALUES_MASK >> 24);
  frame[4] = (uint8_t)(VESC_VALUES_MASK >> 16);
  frame[5] = (uint8_t)(VESC_VALUES_MASK >> 8);
  frame[6] = (uint8_t)(VESC_VALUES_MASK & 0xffU);
  uint16_t crc = crc16(&frame[2], 5);
  frame[7] = (uint8_t)(crc >> 8); frame[8] = (uint8_t)crc; frame[9] = 3;
}

void VescProtocol_RequestConfig(uint8_t frame[VESC_CONFIG_REQUEST_BYTES])
{
  frame[0] = 2; frame[1] = 1; frame[2] = VESC_COMM_GET_MCCONF;
  uint16_t crc = crc16(&frame[2], 1);
  frame[3] = (uint8_t)(crc >> 8); frame[4] = (uint8_t)crc; frame[5] = 3;
}

void VescProtocol_Reset(VescParser *p)
{
  p->state = 0; p->length = 0; p->index = 0; p->crc = 0; p->received_crc = 0;
  p->cells_502 = 0; p->cells_503 = 0; p->cells_600 = 0; p->cells_701 = 0;
}

VescEvent VescProtocol_Feed(VescParser *p, uint8_t byte, VescResult *result)
{
  if (p == NULL || result == NULL) return VESC_EVENT_NONE;
  switch (p->state) {
  case 0:
    if (byte == 2U) p->state = 1;
    else if (byte == 3U) p->state = 2;
    break;
  case 1: /* 短帧：一字节长度。 */
    p->length = byte;
    p->state = (byte != 0U) ? 4U : 0U;
    break;
  case 2: p->length = (uint16_t)byte << 8; p->state = 3; break;
  case 3: /* 长帧：两字节长度。 */
    p->length |= byte;
    p->state = (p->length > 255U && p->length <= VESC_MAX_PAYLOAD_BYTES) ? 4U : 0U;
    break;
  case 4:
    if (p->index < sizeof(p->payload)) p->payload[p->index] = byte;
    if (p->index == VESC_CELLS_OFFSET_502) p->cells_502 = byte;
    if (p->index == VESC_CELLS_OFFSET_503) p->cells_503 = byte;
    if (p->index == VESC_CELLS_OFFSET_600) p->cells_600 = byte;
    if (p->index == VESC_CELLS_OFFSET_701) p->cells_701 = byte;
    p->crc = crc16_byte(p->crc, byte);
    if (++p->index == p->length) p->state = 5;
    break;
  case 5: p->received_crc = (uint16_t)byte << 8; p->state = 6; break;
  case 6: p->received_crc |= byte; p->state = 7; break;
  case 7: {
    VescEvent event = VESC_EVENT_NONE;
    if (byte == 3U && p->received_crc == p->crc) {
      if (p->length == VESC_RESPONSE_PAYLOAD_BYTES &&
          p->payload[0] == VESC_COMM_GET_VALUES_SELECTIVE &&
          be32(&p->payload[1]) == VESC_VALUES_MASK) {
        result->telemetry.fet_temp_tenths_c = (int16_t)be16(&p->payload[5]);
        result->telemetry.input_current_hundredths_a = (int32_t)be32(&p->payload[7]);
        result->telemetry.electrical_rpm = (int32_t)be32(&p->payload[11]);
        result->telemetry.input_voltage_tenths_v = be16(&p->payload[15]);
        event = VESC_EVENT_TELEMETRY;
      } else if (p->length >= 5U && p->payload[0] == VESC_COMM_GET_MCCONF) {
        result->config_signature = be32(&p->payload[1]);
        result->config_supported = true;
        if (result->config_signature == VESC_SIG_502 && p->length == 458U)
          result->battery_cells = p->cells_502;
        else if (result->config_signature == VESC_SIG_503 && p->length == 485U)
          result->battery_cells = p->cells_503;
        else if (result->config_signature == VESC_SIG_600 && p->length == 482U)
          result->battery_cells = p->cells_600;
        else if (result->config_signature == VESC_SIG_701 && p->length == 493U)
          result->battery_cells = p->cells_701;
        else {
          result->config_supported = false;
          result->battery_cells = 0;
        }
        event = VESC_EVENT_CONFIG;
      }
    }
    VescProtocol_Reset(p);
    return event;
  }
  default: VescProtocol_Reset(p); break;
  }
  return VESC_EVENT_NONE;
}
