
#define GPIO_ADDR 0x10012000
#define gpio_in_val 0x00
#define gpio_in_en 0x04
#define gpio_out_en 0x08
#define gpio_out_val 0x0C
#define gpio_pue 0x10
#define gpio_ds 0x14
#define gpio_rise_ie 0x18
#define gpio_rise_ip 0x1C
#define gpio_fall_ie 0x20
#define gpio_fall_ip 0x24
#define gpio_high_ie 0x28
#define gpio_high_ip 0x2C
#define gpio_low_ie 0x38
#define gpio_low_ip 0x34
#define gpio_iof_en 0x38
#define gpio_iof_sel 0x3C
#define gpio_out_xor 0x40
#define gpio_passthru_high_ie 0x44
#define gpio_passthru_low_ie 0x48

#define gpio_pin0 0x1
#define gpio_pin1 0x2
#define gpio_pin2 0x4
#define gpio_pin3 0x8
#define gpio_pin4 0x10
#define gpio_pin5 0x20
#define gpio_pin6 0x40
#define gpio_pin7 0x80
#define gpio_pin8 0x100
#define gpio_pin9 0x200
#define gpio_pin10 0x400
#define gpio_pin11 0x800
#define gpio_pin12 0x1000
#define gpio_pin13 0x2000
#define gpio_pin14 0x4000
#define gpio_pin15 0x8000
#define gpio_pin16 0x10000
#define gpio_pin17 0x20000
#define gpio_pin18 0x40000
#define gpio_pin19 0x80000
#define gpio_pin20 0x100000
#define gpio_pin21 0x200000
#define gpio_pin22 0x400000
#define gpio_pin23 0x800000
#define gpio_pin24 0x1000000
#define gpio_pin25 0x2000000
#define gpio_pin26 0x4000000
#define gpio_pin27 0x8000000
#define gpio_pin28 0x10000000
#define gpio_pin29 0x20000000
#define gpio_pin30 0x40000000
#define gpio_pin31 0x80000000
#define gpio_pin32 0x100000000

#define UART0_ADDR 0x10013000
#define UART0_PIN_RX gpio_pin16
#define UART0_PIN_TX gpio_pin17

#define UART1_ADDR 0x10023000
#define UART1_PIN_RX gpio_pin18
#define UART1_PIN_TX gpio_pin23


#define UART_TXDATA 0x00
#define UART_RXDATA 0x04
#define UART_TXCTRL 0x08
#define UART_RXCTRL 0x0c
#define UART_IE     0x10
#define UART_IP     0x14
#define UART_DIV    0x18


#define PRCI_ADDR 0x10008000

#define OTP_ADDR 0x20000
#define OTP_TRIM 0x7fb

.section .text
.globl _start

_start:
  call setup_clock
  call setup_uart

  # Transmit a byte
  la a3, 'x'
  call print_byte

  # Turn on red led
  li t0, GPIO_ADDR
  li t1, gpio_pin21 | gpio_pin22
  sw t1, gpio_out_en(t0)
  sw t1, gpio_out_xor(t0)
  sw t1, gpio_out_val(t0)

main_loop:
  jal main_loop


print_byte:
  li t0, UART0_ADDR
  sb a3, UART_TXDATA(t0)
  ret
  
setup_clock:
  // Set the clock to run at 14.4MHz 
  la t0, PRCI_ADDR
  lw t1, 0(t0)
  li t2, 0b11111
  not t2, t2
  and t1, t2, t1
  li t2, 0x4
  or t1, t2, t1
  sw t1, 0(t0)

  // Trim clock calibration value
  li t2, 0x23
  sb t2, 2(t0)

  ret

setup_uart:
  # enable UART0 TX PIN
  li t0, GPIO_ADDR
  li t1, UART0_PIN_TX
  sw t1, gpio_iof_en(t0)
  li t1, 0x0 # set the pin in UART mode
  sw t1, gpio_iof_sel(t0)

  # Enable UART0 TX
  li t0, UART0_ADDR
  li t1, 0x00001
  sw t1, UART_TXCTRL(t0)
  li t1, 124 # divider to achieve a 115200 rate on a 14.4MHz clock
  sw t1, UART_DIV(t0)
  ret

