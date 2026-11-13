#include "FreeRTOS.h"
#include "task.h"
#include "board.h"
#include "lvgl_task.h"
#include "input_task.h"
#include "ppm_task.h"
#include "buzzer.h"

#define LED_TOGGLE_INTERVAL_MS 500

static void prvLedTask(void *pvParameters)
{
  (void)pvParameters;

  for (;;) {
    // D1: GPIO4 bit 4 -> L48 pin 43 (schematic PB7), active high.
    GPIO_Toggle(LED_GPIO, LED_GPIO_BITS);
    vTaskDelay(pdMS_TO_TICKS(LED_TOGGLE_INTERVAL_MS));
  }
}

int main(void)
{
  board_init();
  INT_DisableIntGlobal(); // The FreeRTOS scheduler enables interrupts.
  board_led_write(false);

  if (xTaskCreate(prvLedTask,
                  "LED",
                  configMINIMAL_STACK_SIZE,
                  NULL,
                  tskIDLE_PRIORITY + 1,
                  NULL) == pdPASS &&
      xTaskCreate(LVGL_Task,
                  "LVGL",
                  2048,
                  NULL,
                  tskIDLE_PRIORITY + 1,
                  NULL) == pdPASS &&
      xTaskCreate(Input_Task,
                  "INPUT",
                  configMINIMAL_STACK_SIZE,
                  NULL,
                  tskIDLE_PRIORITY + 2,
                  NULL) == pdPASS &&
      xTaskCreate(Ppm_Task,
                  "PPM",
                  configMINIMAL_STACK_SIZE,
                  NULL,
                  tskIDLE_PRIORITY + 2,
                  NULL) == pdPASS &&
      Buzzer_Init()) {
    vTaskStartScheduler();
  }

  // Reached only if task creation or scheduler startup failed.
  board_led_write(false);
  for (;;) {
  }
}

#if (configSUPPORT_STATIC_ALLOCATION == 1)
// Required by FreeRTOS for its idle task when static allocation is enabled.
void vApplicationGetIdleTaskMemory(StaticTask_t **ppxIdleTaskTCBBuffer,
                                   StackType_t **ppxIdleTaskStackBuffer,
                                   uint32_t *pulIdleTaskStackSize)
{
  static StaticTask_t xIdleTaskTCB;
  static StackType_t uxIdleTaskStack[configMINIMAL_STACK_SIZE];

  *ppxIdleTaskTCBBuffer = &xIdleTaskTCB;
  *ppxIdleTaskStackBuffer = uxIdleTaskStack;
  *pulIdleTaskStackSize = configMINIMAL_STACK_SIZE;
}
#endif
