# LVGL 接入

`main` 启动 `LVGL_Task`，由该 FreeRTOS 任务初始化 ST7789、LVGL 和显示设备，
创建示例文字，并循环调用 `lv_timer_handler()`。屏幕默认为横屏 320×240，RGB565，
使用 10 行的局部绘图缓冲；刷新经过现有的同步 SPI/DMA 驱动，驱动负责像素字节序转换。
LVGL 时钟使用 `board_millis()`，不依赖其他任务或 FreeRTOS tick hook。
LVGL 创建设备时读取驱动当前宽高；若以后在运行中更改屏幕方向，还需同步更新
LVGL 的显示分辨率并确认绘图缓冲大小。

所有 LVGL API 和 ST7789 操作都应在该任务执行；其他任务可以通过 FreeRTOS 队列
发送数据，由 LVGL 任务更新界面。当前不接入触摸或其他输入设备。
调试器可观察 `lvgl_lcd_status` 和 `lvgl_flush_errors`；刷新错误会计数，
但当前不会自动重新绘制失败的区域。

`user/lv_conf.h` 使用 32 KiB LVGL 内存池和简单主题。受 156 KiB 程序 Flash 区域限制，
当前只启用标签等基础功能，关闭了多数控件和非 RGB565 软件渲染格式。
添加界面时可按需启用控件，并重新检查链接结果是否仍处于程序区内。
字体默认仅包含 Montserrat 18，中文需要另外配置字体并检查空间。
当前关闭 Flex、Grid 自动布局和 Observer 数据绑定；如界面需要，可以在
`user/lv_conf.h` 中重新启用。圆弧、圆角等复杂软件绘制能力仍然保留。

示例界面可在 `lvgl_task.c` 中修改。若恢复 LCD 纯色测试，应在 `main` 中以
`LCD_ColorTestTask` 替换 LVGL 任务，避免同时操作屏幕。
