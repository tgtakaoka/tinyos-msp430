tinyos-msp430
=============

NEWS: Compiling with [TI MSP430-GCC][] is supported.

This project ports [TinyOS prod][] to small MSP430 chips that are not
supported officially, is designed with [TinyOS prod for msp430][].

This project is intended as a basis for electronics hobbyist.

You may find that [Homebrew][], [Linuxbrew][], and the following taps
are quite handy for develoipment.

- [tgtakaoka/mspgcc][]: `msp430-gcc` and tools. MSP430 port of `gcc
  4.7` known as `mspgcc4`.

- [tgtakaoka/msp430-elf][]: `msp430-elf-gcc` and tools. MSP430 port of
  `gcc 7.3` known as `TI MSP430-GCC`.

- [tgtakaoka/tinyos-msp430][]: this project and modified `tinyos-main`
  tree to support `gcc 7.3`.  Also conatins the latest `mspdebug` and
  `MSP Debug Stack from TI` formulae.

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

* support configurable clock and timer.
* support USI (I2C)
* support ADC10, ADC12, SD16A
* support DAC12
* support Comparator
* support msp430f2418 (64pin, 16MHz, 116KB Flash, 8KB RAM)
* support msp430f2617 (64pin, 16MHz, 92KB Flash, 8KB RAM)
* support msp430f4270 (64pin, 8MHz, 32KB Flash, 256B RAM)
* support msp430f5172 (38pin, 25MHz, 32KB Flash, 2KB RAM)
* support msp430f5310 (48pin, 25MHz, 32kB Flash, 6KB RAM)
* support msp430f5510 (48pin, 25MHz, 32kB Flash, 6KB RAM, USB)
* support msp430fr2111 (16pin, 16MHz, 3.75KB FRAM, 1KB RAM)
* support msp430fr2311 (20pin, 16MHz, 3.75KB FRAM, 1KB RAM)
* support msp430fr2422 (16pin, 16MHz, 7.5KB FRAM, 2KB RAM)
* support msp430fr2533 (32pin, 16MHz, 15.5KB FRAM, 2KB RAM)
* support msp430fr2633 (32pin, 16MHz, 15.5KB FRAM, 4KB RAM)
* support msp430fr5739 (38pin, 24MHz, 16KB FRAM, 1KB RAM)
* support msp430g2955 (38pin, 16MHz, 56KB Flash, 4KB RAM)
* support msp430i2041 (28pin, 16MHz, 32KB Flash, 2KB RAM)
* support msp430afe253 (24pin, 12MHz, 16KB Flash, 512B RAM)
* support MSP-EXP430FR2311
* support MSP-EXP430FR2433
* support MSP-EXP430FR5739

Completed
---------

* support TI MSP430-GCC, gcc 7.3.
* support USART (UART, SPI, I2C) from upstream.
* support USCI (UART, SPI, I2C) from upstream.
* support GNU gcc 7.2
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

[TI MSP430-GCC]: http://www.ti.com/tool/MSP430-GCC-OPENSOURCE
[TinyOS prod]: https://github.com/tp-freeforall/prod
[TinyOS prod for msp430]: https://github.com/tgtakaoka/tinyos-main/tree/msp430-elf
[Homebrew]: https://github.com/Homebrew/brew
[Linuxbrew]: https://github.com/Linuxbrew/brew
[tgtakaoka/mspgcc]: https://github.com/tgtakaoka/homebrew-mspgcc
[tgtakaoka/msp430-elf]: https://github.com/tgtakaoka/homebrew-msp430-elf
[tgtakaoka/tinyos-msp430]: https://github.com/tgtakaoka/homebrew-tinyos-msp430