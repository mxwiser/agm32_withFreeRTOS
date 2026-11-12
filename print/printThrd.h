#ifndef __PRINT_THD_H__
#define __PRINT_THD_H__

void DBG_Print_Init();
void Task_PrintLog(void *pvParameters);

void DBG_Printf(char *fmt, ...);
void DBG_Printf_irq(char *fmt, ...);


#endif //__PRINT_THD_H__

