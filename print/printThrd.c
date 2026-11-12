#include "stdio.h"
#include "FreeRTOS.h"
#include "semphr.h"
#include "ringbuff.h"
#include "uart.h"

#define IS_OPEN_LOG 1   //0 关log； 1 开log

#define DBG_UART (UARTx(LOGGER_UART))

// 打印缓冲
#define ONE_ITEM_BUFF_LEN	(256)      //每条log的最大缓存
#define TOT_PRINT_BUFF_LEN	(1024 * 2)  //log总缓存的大小
static uint8 gDebugBuff[TOT_PRINT_BUFF_LEN];      //串口接收缓存
HY_RINGBUF gDebugRingBuf;    //debug打印的ringBuff


// 打印信息初始化
void DBG_Print_Init()
{
    //串口初始化已经在board_init里做过了。
    //如果自己的工程对board_init做过修改，并且删除了log串口的初始化。那么，请在这里再次初始化。

    HY_RingBuf_Init(&gDebugRingBuf, gDebugBuff, TOT_PRINT_BUFF_LEN);
}


char g_printBuff[ONE_ITEM_BUFF_LEN]; //全局，放到这里，不再占用 栈 的空间。
// 注意：每条的长度控制不要超过 ONE_ITEM_BUFF_LEN 字节。
void DBG_Printf(char *fmt, ...)
{
    if (IS_OPEN_LOG == 0)
    {
        return;
    }

    char *tmpBuff = g_printBuff;
    tmpBuff[0] = 0; //clear

    // write real print-info
    va_list valist;
	va_start(valist, fmt);
	vsprintf(tmpBuff + strlen(tmpBuff), fmt, valist);
	va_end(valist);
   
    //option...
    //format
    if (tmpBuff[strlen(tmpBuff)-2] != '\r' && tmpBuff[strlen(tmpBuff)-1] == '\n')
    {
        tmpBuff[strlen(tmpBuff)-1] = 0;
    }
    // write nail
    if (tmpBuff[strlen(tmpBuff)-2] != '\r' || tmpBuff[strlen(tmpBuff)-1] != '\n')
    {
        strcat(tmpBuff, "\r\n");
    }
    
    //add to buff
    taskENTER_CRITICAL();
    HY_RingBuf_Write(&gDebugRingBuf, (uint8 *)tmpBuff, strlen(tmpBuff));
    taskEXIT_CRITICAL();
}

void DBG_Printf_irq(char *fmt, ...)
{
    //to do...
}
void checkMoveIrqLog2NormalLog()
{
    //to do ...
}

// print线程 默默从buff中读取内容，然后打印出来
void threadPrintToUart()
{
    uint8 tmpBuff[32];
    uint8 realLen = 0;

    if (IS_OPEN_LOG == 0)
    {
        return;
    }

    //checkMoveIrqLog2NormalLog(); //先收取中断的
    
    // 每次32个字节读吧
    taskENTER_CRITICAL();
    realLen = HY_RingBuf_Read(&gDebugRingBuf, tmpBuff, 32);
    taskEXIT_CRITICAL();

    if (realLen == 0) return;
    
    for (uint8 i = 0; i < realLen; i++)
    {
        while (!UART_IsTxFifoEmpty(DBG_UART))
        { // if uart busy
            vTaskDelay(2);
        }
        UART_SendCh(DBG_UART, tmpBuff[i]);
    }
}

// 专门用于打印的线程
void Task_PrintLog(void *pvParameters)
{
    while(1)
    {
        threadPrintToUart();
        vTaskDelay(5);
    }
}

