#include <errno.h>
#include <limits.h>
#include <stdint.h>
#include <sys/types.h>
#include <unistd.h>

#include "uart.h"

// This MCU has no POSIX processes. Keep the single-process ID stable.
pid_t _getpid(void)
{
  return 1;
}

int _kill(pid_t pid, int sig)
{
  (void)pid;
  (void)sig;
  errno = EINVAL;
  return -1;
}

// stdout/stderr use the same UART selected for the SDK logger.
int _write(int fd, const void *buffer, size_t length)
{
  if (fd != STDOUT_FILENO && fd != STDERR_FILENO) {
    errno = EBADF;
    return -1;
  }
  if (length == 0) {
    return 0;
  }
  if (buffer == NULL) {
    errno = EFAULT;
    return -1;
  }
  if (length > INT_MAX) {
    errno = EINVAL;
    return -1;
  }

#ifdef LOGGER_UART
  UART_TypeDef *uart = UARTx(LOGGER_UART);
  if (!UART_IsEnabled(uart)) {
    errno = ENODEV;
    return -1;
  }
  UART_Send(uart, (const unsigned char *)buffer, (unsigned int)length);
  return (int)length;
#else
  errno = ENOSYS;
  return -1;
#endif
}

// stdin is nonblocking: return available bytes, or EAGAIN when RX is empty.
int _read(int fd, void *buffer, size_t length)
{
  if (fd != STDIN_FILENO) {
    errno = EBADF;
    return -1;
  }
  if (length == 0) {
    return 0;
  }
  if (buffer == NULL) {
    errno = EFAULT;
    return -1;
  }
  if (length > INT_MAX) {
    errno = EINVAL;
    return -1;
  }

#ifdef LOGGER_UART
  UART_TypeDef *uart = UARTx(LOGGER_UART);
  if (!UART_IsEnabled(uart)) {
    errno = ENODEV;
    return -1;
  }

  unsigned char *bytes = buffer;
  size_t received = 0;
  while (received < length && !UART_IsRxFifoEmpty(uart)) {
    bytes[received++] = UART_ReceiveData(uart);
  }
  if (received != 0) {
    return (int)received;
  }
  errno = EAGAIN;
  return -1;
#else
  errno = ENOSYS;
  return -1;
#endif
}
