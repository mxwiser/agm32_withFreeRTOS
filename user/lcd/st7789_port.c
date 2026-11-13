#include "st7789_port.h"
#include "config/st7789_config.h"
#include "FreeRTOS.h"
#include "task.h"

static SPI_SclkDivTypeDef spi_divisor;

// Stable RV32 cycle read across a low-word rollover.
static uint64_t cycles(void)
{
  uint32_t high, low, check;
  do {
    high = read_csr(mcycleh);
    low = read_csr(mcycle);
    check = read_csr(mcycleh);
  } while (high != check);
  return ((uint64_t)high << 32) | low;
}

uint32_t ST7789_PortMillis(void)
{
  return (uint32_t)(cycles() / (SYS_GetSysClkFreq() / 1000U));
}

void ST7789_PortDelayMs(uint32_t ms)
{
  if (xTaskGetSchedulerState() == taskSCHEDULER_RUNNING) {
    // Round up; vTaskDelay(n) may return after only n-1 full tick periods.
    vTaskDelay(pdMS_TO_TICKS(ms) + 1U);
  } else {
    UTIL_IdleMs(ms);
  }
}

void ST7789_PortReset(bool asserted)
{
  GPIO_SetValue(LCD_CONTROL_GPIO, LCD_RESET_BIT, asserted ? 0 : LCD_RESET_BIT);
}

void ST7789_PortBacklight(bool on)
{
  GPIO_SetValue(LCD_BLK_GPIO, LCD_BLK_GPIO_BITS, on ? LCD_BLK_GPIO_BITS : 0);
}

void ST7789_PortBegin(bool data)
{
  GPIO_SetValue(LCD_CONTROL_GPIO, LCD_DC_BIT, data ? LCD_DC_BIT : 0);
  GPIO_SetLow(LCD_CS_GPIO, LCD_CS_BIT);
}

void ST7789_PortDataMode(void) { GPIO_SetHigh(LCD_CONTROL_GPIO, LCD_DC_BIT); }
void ST7789_PortEnd(void) { GPIO_SetHigh(LCD_CS_GPIO, LCD_CS_BIT); }

ST7789_Status ST7789_PortInit(void)
{
  SYS_EnableAPBClock(LCD_SPI_CLOCK_MASK | APB_MASK_GPIO0 |
                     APB_MASK_GPIO4 | APB_MASK_GPIO5);
  // CS is software controlled so it remains low across command/data/DMA chunks.
  GPIO_SetSoftwareMode(LCD_CS_GPIO, LCD_CS_BIT);
  GPIO_SetOutput(LCD_CS_GPIO, LCD_CS_BIT);
  ST7789_PortEnd();
  GPIO_SetSoftwareMode(LCD_CONTROL_GPIO, LCD_RESET_BIT | LCD_DC_BIT | LCD_BLK_GPIO_BITS);
  GPIO_SetOutput(LCD_CONTROL_GPIO, LCD_RESET_BIT | LCD_DC_BIT | LCD_BLK_GPIO_BITS);
  ST7789_PortReset(false);
  ST7789_PortDataMode();

  uint32_t divisor = (SYS_GetPclkFreq() + LCD_SPI_MAX_HZ - 1U) / LCD_SPI_MAX_HZ;
  divisor = (divisor + 1U) & ~1U;
  if (divisor < 2U) {
    divisor = 2U;
  }
  if (divisor > 256U) {
    return ST7789_INVALID_ARGUMENT;
  }
  spi_divisor = (SPI_SclkDivTypeDef)((divisor & 0xffU) << SPI_CTRL_SCLK_DIV_OFFSET);
  SPI_Init(LCD_SPI, spi_divisor); // mode 0, MSB first within each byte
  GPIO_AF_ENABLE(SPI0_SCK);
  GPIO_AF_ENABLE(SPI0_SI_IO0);
  // board_init() already initializes DMAC. Do not reset other DMA channels here.
  SYS_EnableAHBClock(AHB_MASK_DMAC0);
  DMAC->Configuration |= ENABLE;
  DMAC_DisableChannel(LCD_DMA_CHANNEL);
  DMAC_DisableSyncRequest(SPI_TX_DMA_REQ(LCD_SPI));
  return ST7789_OK;
}

static ST7789_Status wait_spi(bool dma)
{
  uint32_t start = ST7789_PortMillis();
  ST7789_Status result = ST7789_OK;
  while (!SPI_IsDone(LCD_SPI)) {
    if (SPI_IsError(LCD_SPI) ||
        (dma && DMAC_IsChannelRawIntErrorActive(LCD_DMA_CHANNEL))) {
      result = ST7789_IO_ERROR;
      break;
    }
    if ((uint32_t)(ST7789_PortMillis() - start) >= LCD_SPI_TIMEOUT_MS) {
      result = ST7789_TIMEOUT;
      break;
    }
  }
  if (SPI_IsError(LCD_SPI) ||
      (dma && DMAC_IsChannelRawIntErrorActive(LCD_DMA_CHANNEL))) {
    result = ST7789_IO_ERROR;
  }
  if (dma) {
    DMAC->Channels[LCD_DMA_CHANNEL].Configuration |= (1U << DMAC_CHANNEL_HALT_OFFSET);
    while (DMAC_GetConfiguration(LCD_DMA_CHANNEL) & (1U << DMAC_CHANNEL_ACTIVE_OFFSET)) {
      if ((uint32_t)(ST7789_PortMillis() - start) >= LCD_SPI_TIMEOUT_MS) {
        result = ST7789_TIMEOUT;
        break;
      }
    }
    DMAC_DisableChannel(LCD_DMA_CHANNEL);
  }
  if (result != ST7789_OK) {
    SPI_Init(LCD_SPI, spi_divisor);
  }
  return result;
}

ST7789_Status ST7789_PortWrite(const uint8_t *data, size_t length)
{
  while (length != 0) {
    size_t count = length > 4U ? 4U : length;
    uint32_t word = 0;
    for (size_t i = 0; i < count; ++i) {
      word |= (uint32_t)data[i] << (i * 8U);
    }
    SPI_SetPhaseCtrl(LCD_SPI, SPI_PHASE_0, SPI_PHASE_ACTION_TX, SPI_PHASE_MODE_SINGLE, count);
    SPI_SetPhaseData(LCD_SPI, SPI_PHASE_0, word);
    SPI_Start(LCD_SPI, SPI_CTRL_PHASE_CNT1, SPI_CTRL_DMA_OFF, SPI_INTERRUPT_OFF);
    ST7789_Status result = wait_spi(false);
    if (result != ST7789_OK) {
      return result;
    }
    data += count;
    length -= count;
  }
  return ST7789_OK;
}

ST7789_Status ST7789_PortWriteDMA(const uint32_t *data, size_t length)
{
  if (length == 0 || length > SPI_PHASE_BYTE_CNT_MAX || ((uintptr_t)data & 3U)) {
    return ST7789_INVALID_ARGUMENT;
  }
  SPI_SetPhaseCtrl(LCD_SPI, SPI_PHASE_0, SPI_PHASE_ACTION_TX, SPI_PHASE_MODE_SINGLE, length);
  // Load the first word with DMA before starting SPI, then let the SPI
  // request line feed the remaining words. CS stays asserted throughout.
  DMAC_Config(LCD_DMA_CHANNEL, (uint32_t)data, (uint32_t)&LCD_SPI->PHASE_DATA[0],
              DMAC_ADDR_INCR_OFF, DMAC_ADDR_INCR_OFF,
              DMAC_WIDTH_32_BIT, DMAC_WIDTH_32_BIT, DMAC_BURST_1, DMAC_BURST_1,
              1, DMAC_MEM_TO_MEM_DMA_CTRL, 0, 0);
  uint32_t start = ST7789_PortMillis();
  while (!DMAC_IsChannelRawIntTCActive(LCD_DMA_CHANNEL)) {
    if (DMAC_IsChannelRawIntErrorActive(LCD_DMA_CHANNEL) ||
        (uint32_t)(ST7789_PortMillis() - start) >= LCD_SPI_TIMEOUT_MS) {
      ST7789_Status result = DMAC_IsChannelRawIntErrorActive(LCD_DMA_CHANNEL)
                               ? ST7789_IO_ERROR : ST7789_TIMEOUT;
      DMAC_DisableChannel(LCD_DMA_CHANNEL);
      SPI_Init(LCD_SPI, spi_divisor);
      return result;
    }
  }
  DMAC_DisableChannel(LCD_DMA_CHANNEL);
  if (length <= 4U) {
    SPI_Start(LCD_SPI, SPI_CTRL_PHASE_CNT1, SPI_CTRL_DMA_OFF, SPI_INTERRUPT_OFF);
    return wait_spi(false);
  }
  DMAC_Config(LCD_DMA_CHANNEL, (uint32_t)(data + 1), (uint32_t)&LCD_SPI->PHASE_DATA[0],
                DMAC_ADDR_INCR_ON, DMAC_ADDR_INCR_OFF,
                DMAC_WIDTH_32_BIT, DMAC_WIDTH_32_BIT, DMAC_BURST_1, DMAC_BURST_1,
                0, DMAC_MEM_TO_PERIPHERAL_PERIPHERAL_CTRL, 0, SPI_TX_DMA_REQ(LCD_SPI));
  SPI_Start(LCD_SPI, SPI_CTRL_PHASE_CNT1, SPI_CTRL_DMA_ON, SPI_INTERRUPT_OFF);
  return wait_spi(true);
}

#if LCD_TRY_SDA_READ
// Hardware SPI's single-line RX uses SO_IO1, which is NOT on J6. For readback
// only, switch the same SCK/SDA pins to GPIO and perform slow half-duplex SPI.
static uint8_t read_bit(void)
{
#if LCD_READ_MODE3
  GPIO_SetLow(LCD_SCK_GPIO, LCD_SCK_BIT);
  UTIL_IdleUs(1);
  GPIO_SetHigh(LCD_SCK_GPIO, LCD_SCK_BIT);
  UTIL_IdleUs(1);
  return GPIO_GetValue(LCD_SDA_GPIO, LCD_SDA_BIT) != 0;
#else
  GPIO_SetHigh(LCD_SCK_GPIO, LCD_SCK_BIT);
  UTIL_IdleUs(1);
  uint8_t bit = GPIO_GetValue(LCD_SDA_GPIO, LCD_SDA_BIT) != 0;
  GPIO_SetLow(LCD_SCK_GPIO, LCD_SCK_BIT);
  UTIL_IdleUs(1);
  return bit;
#endif
}
#endif

ST7789_Status ST7789_PortRead(uint8_t cmd, uint8_t dummy_bits,
                               uint8_t *data, size_t length)
{
#if LCD_TRY_SDA_READ
  ST7789_PortEnd();
  GPIO_AF_DISABLE(SPI0_SCK);
  GPIO_AF_DISABLE(SPI0_SI_IO0);
  GPIO_SetOutput(LCD_SCK_GPIO, LCD_SCK_BIT);
#if LCD_READ_MODE3
  GPIO_SetHigh(LCD_SCK_GPIO, LCD_SCK_BIT);
#else
  GPIO_SetLow(LCD_SCK_GPIO, LCD_SCK_BIT);
#endif
  GPIO_SetOutput(LCD_SDA_GPIO, LCD_SDA_BIT);
  ST7789_PortBegin(false);
  for (int bit = 7; bit >= 0; --bit) {
#if LCD_READ_MODE3
    GPIO_SetLow(LCD_SCK_GPIO, LCD_SCK_BIT);
#endif
    GPIO_SetValue(LCD_SDA_GPIO, LCD_SDA_BIT, (cmd & (1U << bit)) ? LCD_SDA_BIT : 0);
    UTIL_IdleUs(1);
    GPIO_SetHigh(LCD_SCK_GPIO, LCD_SCK_BIT);
    UTIL_IdleUs(1);
    if (bit == 0) {
      // Release SDA before the next falling edge can make the panel drive it.
      GPIO_SetInput(LCD_SDA_GPIO, LCD_SDA_BIT);
      ST7789_PortDataMode();
    }
#if !LCD_READ_MODE3
    GPIO_SetLow(LCD_SCK_GPIO, LCD_SCK_BIT);
#endif
  }
  UTIL_IdleUs(1);
  for (uint8_t i = 0; i < dummy_bits; ++i) {
    (void)read_bit();
  }
  for (size_t i = 0; i < length; ++i) {
    uint8_t value = 0;
    for (int bit = 0; bit < 8; ++bit) {
      value = (uint8_t)((value << 1) | read_bit());
    }
    data[i] = value;
  }
  ST7789_PortEnd();
  UTIL_IdleUs(1);
  GPIO_SetLow(LCD_SCK_GPIO, LCD_SCK_BIT);
  GPIO_AF_ENABLE(SPI0_SCK);
  GPIO_AF_ENABLE(SPI0_SI_IO0);
  return ST7789_OK;
#else
  (void)cmd;
  (void)dummy_bits;
  (void)data;
  (void)length;
  return ST7789_READ_UNSUPPORTED;
#endif
}

ST7789_Status ST7789_PortReadScanline(uint8_t *data)
{
  return ST7789_PortRead(0x45, LCD_SCANLINE_DUMMY_BITS, data, 2);
}
