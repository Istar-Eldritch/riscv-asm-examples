.section .text
.globl _start

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

#define RED_LED   gpio_pin22
#define GREEN_LED gpio_pin19
#define BLUE_LED  gpio_pin21

_start:

    li t0, GPIO_ADDR

    li a0, gpio_pin19 
    li t1, gpio_pin21
    li t2, gpio_pin22

    or a0, a0, t1
    or a0, a0, t2

    // enable all leds
    sw a0, gpio_out_en(t0)
    sw a0, gpio_out_xor(t0)

    // turn on red and blue led
    sw t1, gpio_out_val(t0)

