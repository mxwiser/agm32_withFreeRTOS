# 蜂鸣器

Q1/BZ1 使用 PIN_45，配置为 GPTIMER4_CH0 硬件 PWM，频率约 2.7 kHz、占空比约 50%；PWM 停止时输出低电平。系统时钟为 200 MHz 时，定时器预分频为 2，周期计数为 37037。

开机蜂鸣一次，时长由 `BUZZER_STARTUP_MS` 指定，默认 120 ms。任务上下文调用：

```c
#include "buzzer.h"
buzzerd(100);  // 异步响 100 ms
buzzerd(0);    // 停止
```

接口不会等待响铃结束；新请求替换当前时长，并从请求处理时重新计时。初始化失败时返回 false；不能在中断中直接调用。实际响铃结束时间受 FreeRTOS 调度和 tick 精度影响。
