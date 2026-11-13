#include "vesc_protocol.h"
#include <stddef.h>

#define VESC_COMM_GET_VALUES_SELECTIVE 50U /* Read-only telemetry request. */

static uint16_t crc16(const uint8_t *data, uint8_t length)
{
  uint16_t crc = 0;
  while (length-- != 0U) {
    crc ^= (uint16_t)*data++ << 8;
    for (unsigned i = 0; i < 8U; ++i)
      crc = (uint16_t)((crc & 0x8000U) ? (crc << 1) ^ 0x1021U : crc << 1);
  }
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

void VescProtocol_Reset(VescParser *parser)
{
  parser->state = 0;
  parser->index = 0;
  parser->crc = 0;
}

bool VescProtocol_Feed(VescParser *p, uint8_t byte, VescTelemetry *result)
{
  if (p == NULL || result == NULL) return false;
  switch (p->state) {
  case 0: if (byte == 2U) p->state = 1; break;
  case 1:
    if (byte == VESC_RESPONSE_PAYLOAD_BYTES) { p->index = 0; p->state = 2; }
    else p->state = byte == 2U ? 1U : 0U;
    break;
  case 2:
    p->payload[p->index++] = byte;
    if (p->index == VESC_RESPONSE_PAYLOAD_BYTES) p->state = 3;
    break;
  case 3: p->crc = (uint16_t)byte << 8; p->state = 4; break;
  case 4: p->crc |= byte; p->state = 5; break;
  case 5: {
    bool valid = byte == 3U && p->payload[0] == VESC_COMM_GET_VALUES_SELECTIVE &&
                 be32(&p->payload[1]) == VESC_VALUES_MASK &&
                 crc16(p->payload, VESC_RESPONSE_PAYLOAD_BYTES) == p->crc;
    if (valid) {
      result->fet_temp_tenths_c = (int16_t)be16(&p->payload[5]);
      result->input_current_hundredths_a = (int32_t)be32(&p->payload[7]);
      result->electrical_rpm = (int32_t)be32(&p->payload[11]);
      result->input_voltage_tenths_v = be16(&p->payload[15]);
    }
    VescProtocol_Reset(p);
    return valid;
  }
  default: VescProtocol_Reset(p); break;
  }
  return false;
}
