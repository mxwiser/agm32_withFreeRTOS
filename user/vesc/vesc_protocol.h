#ifndef USER_VESC_PROTOCOL_H
#define USER_VESC_PROTOCOL_H

#include <stdbool.h>
#include <stdint.h>

/* VESC COMM_GET_VALUES_SELECTIVE telemetry fields. */
#define VESC_VALUES_MASK 0x00000189UL
#define VESC_REQUEST_BYTES 10U
#define VESC_RESPONSE_PAYLOAD_BYTES 17U
#define VESC_CONFIG_REQUEST_BYTES 6U

typedef struct {
  int16_t fet_temp_tenths_c;
  int32_t input_current_hundredths_a;
  int32_t electrical_rpm;
  uint16_t input_voltage_tenths_v;
} VescTelemetry;

typedef struct {
  uint8_t state;
  uint16_t length;
  uint16_t index;
  uint8_t payload[VESC_RESPONSE_PAYLOAD_BYTES];
  uint16_t crc;
  uint16_t received_crc;
  uint8_t cells_502;
  uint8_t cells_503;
  uint8_t cells_600;
  uint8_t cells_701;
} VescParser;

typedef struct {
  VescTelemetry telemetry;
  uint32_t config_signature;
  uint8_t battery_cells;
  bool config_supported;
} VescResult;

typedef enum {
  VESC_EVENT_NONE,
  VESC_EVENT_TELEMETRY,
  VESC_EVENT_CONFIG
} VescEvent;

void VescProtocol_Request(uint8_t frame[VESC_REQUEST_BYTES]);
void VescProtocol_RequestConfig(uint8_t frame[VESC_CONFIG_REQUEST_BYTES]);
void VescProtocol_Reset(VescParser *parser);
VescEvent VescProtocol_Feed(VescParser *parser, uint8_t byte, VescResult *result);

#endif
