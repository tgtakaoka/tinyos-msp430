tinyos-msp430
=============

This project ports TinyOS to small MSP430 chips that are not supported
officially.

This project is intended as a basis for electronics hobbyist.

Supported chips
---------------

* msp430f1121 (20pin, 8MHz, 4KB Flash, 256B RAM)
* msp430f1132 (20pin, 8MHz, 8KB Flash, 256B RAM)
* msp430f1232 (28pin, 8MHz, 8KB Flash, 256B RAM)
* msp430f2012 (14pin, 16MHz, 1KB Flash, 128B RAM)
* msp430f2013 (14pin, 16MHz, 1KB Flash, 128B RAM)
* msp430f2131 (20pin, 16MHz, 8KB Flash, 256B RAM)
* msp430f2132 (28pin, 16MHz, 8KB Flash, 512B RAM)
* msp430f2274 (38pin, 16MHz, 32KB Flash, 1KB RAM)
* msp430f2618 (64pin, 16MHz, 116KB Flash, 8KB RAM)
* msp430g2211 (14pin, 16MHz, 2KB Flash, 128B RAM)
* msp430g2231 (14pin, 16MHz, 2KB Flash, 128B RAM)
* msp430g2402 (20pin, 16MHz, 8KB Flash, 256B RAM)
* msp430g2452 (20pin, 16MHz, 8KB Flash, 256B RAM)
* msp430g2553 (28pin, 16MHz, 16KB Flash, 512B RAM)
* EZ430-F2013 and EZ430-T2012
* EZ430-RF2500
* MSP-EXP430G2
* msp430f1611 (64pin, 8MHz, 48KB Flash, 10KB RAM) as reference.

To do
-----

* support USART (UART, SPI, I2C)
* support USCI (UART, SPI, I2C)
* support USI (SPI, I2C)
* support ADC10, ADC12, SD16A
* support DAC12
* support Comparator
* support msp430f2418 (64pin, 16MHz, 116KB Flash, 8KB RAM)
* support msp430f2617 (64pin, 16MHz, 92KB Flash, 8KB RAM)
* support msp430f4270 (64pin, 8MHz, 32KB Flash, 256B RAM)
* support msp430f5172 (38pin, 25MHz, 32KB Flash, 2KB RAM)
* support msp430f5310 (48pin, 25MHz, 32kB Flash, 6KB RAM)
* support msp430f5510 (48pin, 25MHz, 32kB Flash, 6KB RAM, USB)
* support msp430fr5739 (38pin, 24MHz, 16KB FRAM, 1KB SRAM)
* support MSP-EXP430FR5739

Completed
---------

* 0.5 using mspgcc uniarch toolchain (gcc 4.5.2)
* 0.4 support SPI on USI, USCI, USART and GPIO.
* 0.3 support msp430g2402, msp430g2452
* 0.2.3 support USCI/UART in msp430f2132 and msp430f2274
* 0.2.2 support USART/UART in msp430f1232 and msp430f1611
* 0.2 support msp430g2211, msp430g2231 and MSP-EXP430G2
* 0.1.2 support max7219 LED driver
* 0.1.1 support msp430f2012
* 0.1 support msp430f2132, msp430f1232, msp430f1132
* 0.1 support msp430f1611 as reference
* 0.1 support msp430f2131
* 0.1 support 16bit Timer, Timer16
* 0.1 support msp430f2274 and EZ430RF2500
* 0.1 support msp430f2013 and EZ430F2013
* 0.1 support VLO oscillator
* 0.1 support TimerA only chips
