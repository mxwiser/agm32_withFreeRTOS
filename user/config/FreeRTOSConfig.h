#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

#include "alta.h"

/* RISC-V 硬件定时器地址及中断栈大小。 */
#define configMTIME_BASE_ADDRESS    (CLINT_BASE + 0xBFF8U) /* 时间计数器地址。 */
#define configMTIMECMP_BASE_ADDRESS (CLINT_BASE + 0x4000U) /* 时间比较器地址。 */

#define configISR_STACK_SIZE_WORDS 512 /* 中断栈大小，单位为字。 */

/* 调度配置：抢占、CPU 频率、1 毫秒节拍与任务优先级。 */
#define configUSE_PREEMPTION                    1 /* 启用抢占式调度。 */
#define configUSE_PORT_OPTIMISED_TASK_SELECTION 1 /* 使用移植层优化的任务选择。 */
#define configCPU_CLOCK_HZ BOARD_PLL_FREQUENCY     /* CPU 时钟频率。 */
#define configTICK_RATE_HZ                      1000 /* 系统节拍频率，Hz。 */
#define configMAX_PRIORITIES                    8 /* 可用优先级数量。 */
#define configMINIMAL_STACK_SIZE                256 /* 最小任务栈，单位为字。 */
#define configMAX_TASK_NAME_LEN                 16 /* 任务名称最大长度。 */
#define configUSE_16_BIT_TICKS                  0 /* 0 表示使用 32 位节拍计数。 */
#define configQUEUE_REGISTRY_SIZE               8 /* 可登记的队列数量。 */
#define configUSE_TIME_SLICING                  1 /* 同优先级任务时间片轮转。 */

/* 静态和动态内存分配；堆大小单位为字节。 */
#define configSUPPORT_STATIC_ALLOCATION             1 /* 启用静态分配。 */
#define configSUPPORT_DYNAMIC_ALLOCATION            1 /* 启用动态分配。 */
#define configTOTAL_HEAP_SIZE                       32768 /* RTOS 堆大小，字节。 */

/* 空闲、节拍、栈溢出及内存不足等钩子；1 启用，0 禁用。 */
#define configUSE_IDLE_HOOK                     0 /* 空闲钩子。 */
#define configUSE_TICK_HOOK                     0 /* 节拍钩子。 */
#define configCHECK_FOR_STACK_OVERFLOW          0 /* 任务栈溢出检查。 */
#define configUSE_MALLOC_FAILED_HOOK            0 /* 分配失败钩子。 */
#define configUSE_DAEMON_TASK_STARTUP_HOOK      0 /* 定时器任务启动钩子。 */

/* 运行时间与任务统计；1 启用，0 禁用。 */
#define configGENERATE_RUN_TIME_STATS           0 /* 运行时间统计。 */
#define configUSE_TRACE_FACILITY                0 /* 任务跟踪。 */
#define configUSE_STATS_FORMATTING_FUNCTIONS    0 /* 格式化统计输出。 */

/* 软件定时器配置；当前未启用。 */
#define configUSE_TIMERS                        0 /* 软件定时器开关。 */
#define configTIMER_TASK_PRIORITY               3 /* 定时器任务优先级。 */
#define configTIMER_QUEUE_LENGTH                8 /* 定时器命令队列长度。 */
#define configTIMER_TASK_STACK_DEPTH configMINIMAL_STACK_SIZE /* 定时器栈，单位为字。 */

/* 开发断言配置。 */
#define vAssertCalled()
#define configASSERT(x) if((x) == 0) vAssertCalled()

/* 以下为各项可选 FreeRTOS API 开关：1 包含，0 禁用。 */
#define INCLUDE_vTaskPrioritySet                1 /* 设置任务优先级。 */
#define INCLUDE_uxTaskPriorityGet               1 /* 获取任务优先级。 */
#define INCLUDE_vTaskDelete                     1 /* 删除任务。 */
#define INCLUDE_vTaskSuspend                    1 /* 暂停任务。 */
#define INCLUDE_xResumeFromISR                  1 /* 在中断中恢复任务。 */
#define INCLUDE_vTaskDelayUntil                 1 /* 周期性延时。 */
#define INCLUDE_vTaskDelay                      1 /* 相对延时。 */
#define INCLUDE_xTaskGetSchedulerState          1 /* 获取调度器状态。 */
#define INCLUDE_xTaskGetCurrentTaskHandle       1 /* 获取当前任务句柄。 */
#define INCLUDE_uxTaskGetStackHighWaterMark     1 /* 查询栈剩余最小值。 */
#define INCLUDE_uxTaskGetStackHighWaterMark2    1 /* 查询栈剩余最小值的扩展接口。 */
#define INCLUDE_xTaskGetIdleTaskHandle          1 /* 获取空闲任务句柄。 */
#define INCLUDE_eTaskGetState                   1 /* 获取任务状态。 */
#define INCLUDE_xEventGroupSetBitFromISR        1 /* 在中断中设置事件位。 */
#define INCLUDE_xTimerPendFunctionCall          0 /* 向定时器任务投递函数。 */
#define INCLUDE_xTaskAbortDelay                 1 /* 中止任务延时。 */
#define INCLUDE_xTaskGetHandle                  1 /* 按名称获取任务句柄。 */
#define INCLUDE_xTaskResumeFromISR              1 /* 在中断中恢复任务接口。 */

#endif
