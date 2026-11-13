#ifndef USER_VESC_PROTOCOL_H
#define USER_VESC_PROTOCOL_H

#include <stdbool.h>
#include <stdint.h>

/* VESC COMM_GET_VALUES_SELECTIVE telemetry fields. */
#define VESC_VALUES_MASK 0x00000189UL
#define VESC_REQUEST_BYTES 10U
#define VESC_RESPONSE_PAYLOAD_BYTES 17U

typedef struct {
  int16_t fet_temp_tenths_c;
  int32_t input_current_hundredths_a;
  int32_t electrical_rpm;
  uint16_t input_voltage_tenths_v;
} VescTelemetry;

typedef struct {
  uint8_t state;
  uint8_t index;
  uint8_t payload[VESC_RESPONSE_PAYLOAD_BYTES];
  uint16_t crc;
} VescParser;

void VescProtocol_Request(uint8_t frame[VESC_REQUEST_BYTES]);
void VescProtocol_Reset(VescParser *parser);
bool VescProtocol_Feed(VescParser *parser, uint8_t byte, VescTelemetry *result);

#endif
