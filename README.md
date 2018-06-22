tinyos-msp430
=============

NEWS: Compiling with [TI MSP430-GCC][] is supported.

This project ports [TinyOS prod][] to small MSP430 chips that are not
supported officially, is designed with [TinyOS prod for msp430-elf][].

This project is intended as a basis for electronics hobbyist.

You may find that [Homebrew][], [Linuxbrew][], and the following taps
are quite handy for develoipment.

- [tgtakaoka/mspgcc][]: `msp430-gcc` and tools. MSP430 port of `gcc
  4.7` known as `mspgcc4`.

- [tgtakaoka/msp430-elf][]: `msp430-elf-gcc` and tools. MSP430 port of
  `gcc 7.3` known as `TI MSP430-GCC`.

- [tgtakaoka/tinyos-msp430][]: this project and modified `tinyos-prod`
  tree to support `gcc 7.3`.  Also conatins the latest `mspdebug` and
  `MSP Debug Stack from TI` formulae.

Supported targets
-----------------

* [MSP430F1121A](http://www.ti.com/product/MSP430F1121A) (20pin, 8MHz, 4KB Flash, 256B RAM)
* [MSP430F1132](http://www.ti.com/product/MSP430F1132) (20pin, 8MHz, 8KB Flash, 256B RAM)
* [MSP430F1232](http://www.ti.com/product/MSP430F1232) (28pin, 8MHz, 8KB Flash, 256B RAM)
* [MSP430F1611](http://www.ti.com/product/MSP430F1611) (64pin, 8MHz, 48KB Flash, 10KB RAM)
* [MSP430F2131](http://www.ti.com/product/MSP430F2131) (20pin, 16MHz, 8KB Flash, 256B RAM)
* [MSP430F2132](http://www.ti.com/product/MSP430F2132) (28pin, 16MHz, 8KB Flash, 512B RAM)
* [MSP430F2274](http://www.ti.com/product/MSP430F2274) (38pin, 16MHz, 32KB Flash, 1KB RAM)
* [MSP430F2618](http://www.ti.com/product/MSP430F2618) (64pin, 16MHz, 116KB Flash, 8KB RAM)
* [MSP430G2402](http://www.ti.com/product/MSP430G2402) (20pin, 16MHz, 8KB Flash, 256B RAM)
* [MSP430G2452](http://www.ti.com/product/MSP430G2452) (20pin, 16MHz, 8KB Flash, 256B RAM)
* [MSP430G2553](http://www.ti.com/product/MSP430G2553) (28pin, 16MHz, 16KB Flash, 512B RAM)
* [eZ430-RF2500T](http://www.ti.com/lit/pdf/slau227) and [eZ430-RF2500-SEH](http://www.ti.com/tool/ez430-rf2500-seh)
* [MSP-EXP430G2](http://www.ti.com/tool/MSP-EXP430G2)

Unconfirmed (should work)
-------------------------
* [MSP430F2418](http://www.ti.com/product/MSP430F2418) (64pin, 16MHz, 116KB Flash, 8KB RAM)
* [MSP430F2617](http://www.ti.com/product/MSP430F2617) (64pin, 16MHz, 92KB Flash, 8KB RAM)
* [MSP430G2955](http://www.ti.com/product/MSP430G2955) (38pin, 16MHz, 56KB Flash, 4KB RAM)
* ADC12, CRC16, DMA (in TinyOS prod)

To do
-----
* configurable timer
* USI I2C Master
* Bit-bang UART
* ADC10, SD16A, DAC12, Comparator
* [MSP430F4270](http://www.ti.com/product/MSP430F4270) (64pin, 8MHz, 32KB Flash, 256B RAM)
* [MSP430F5172](http://www.ti.com/product/MSP430F5172) (38pin, 25MHz, 32KB Flash, 2KB RAM)
* [MSP430F5310](http://www.ti.com/product/MSP430F5310) (48pin, 25MHz, 32kB Flash, 6KB RAM)
* [MSP430F5510](http://www.ti.com/product/MSP430F5510) (48pin, 25MHz, 32kB Flash, 6KB RAM, USB)
* [MSP430FR2033](http://www.ti.com/product/MSP430FR2033) (48pin, 16MHz, 16KB FRAM, 2KB RAM)
* [MSP430FR2111](http://www.ti.com/product/MSP430FR2111) (16pin, 16MHz, 4KB FRAM, 1KB RAM)
* [MSP430FR2155](http://www.ti.com/product/MSP430FR2155) (38pin, 24MHz, 32KB FRAM, 4KB RAM)
* [MSP430FR2311](http://www.ti.com/product/MSP430FR2311) (20pin, 16MHz, 4KB FRAM, 1KB RAM)
* [MSP430FR2355](http://www.ti.com/product/MSP430FR2355) (38pin, 24MHz, 32KB FRAM, 4KB RAM)
* [MSP430FR2422](http://www.ti.com/product/MSP430FR2422) (16pin, 16MHz, 8KB FRAM, 2KB RAM)
* [MSP430FR2533](http://www.ti.com/product/MSP430FR2533) (32pin, 16MHz, 16KB FRAM, 2KB RAM)
* [MSP430FR2633](http://www.ti.com/product/MSP430FR2633) (32pin, 16MHz, 16KB FRAM, 4KB RAM)
* [MSP430FR4133](http://www.ti.com/product/MSP430FR4133) (48pin, 16MHz, 16KB FRAM, 2KB RAM)
* [MSP430FR5739](http://www.ti.com/product/MSP430FR5739) (38pin, 24MHz, 16KB FRAM, 1KB RAM)
* [MSP430I2041](http://www.ti.com/product/MSP430I2041) (28pin, 16MHz, 32KB Flash, 2KB RAM)
* [MSP430AFE253](http://www.ti.com/product/MSP430AFE253) (24pin, 12MHz, 16KB Flash, 512B RAM)
* [MSP-EXP430FR2311](http://www.ti.com/tool/MSP-EXP430FR2311)
* [MSP-EXP430FR2355](http://www.ti.com/tool/MSP-EXP430FR2355)
* [MSP-EXP430FR2433](http://www.ti.com/tool/MSP-EXP430FR2433)
* [MSP-EXP430FR4133](http://www.ti.com/tool/MSP-EXP430FR4133)
* [MSP-EXP430FR5739](http://www.ti.com/tool/MSP-EXP430FR5739)

Deprecated targets
------------------
* [MSP430F2012](http://www.ti.com/product/MSP430F2012) (14pin, 16MHz, 2KB Flash, 128B RAM)
* [MSP430F2013](http://www.ti.com/product/MSP430F2013) (14pin, 16MHz, 2KB Flash, 128B RAM)
* [MSP430G2211](http://www.ti.com/product/MSP430G2211) (14pin, 16MHz, 2KB Flash, 128B RAM)
* [MSP430G2231](http://www.ti.com/product/MSP430G2231) (14pin, 16MHz, 2KB Flash, 128B RAM)
* [EZ430-F2013](http://www.ti.com/tool/EZ430-F2013) and [EZ430-T2012](http://www.ti.com/tool/EZ430-T2012)

[TI MSP430-GCC]: http://www.ti.com/tool/MSP430-GCC-OPENSOURCE
[TinyOS prod]: https://github.com/tp-freeforall/prod
[TinyOS prod for msp430-elf]: https://github.com/tgtakaoka/tinyos-prod/tree/msp430-elf
[Homebrew]: https://github.com/Homebrew/brew
[Linuxbrew]: https://github.com/Linuxbrew/brew
[tgtakaoka/mspgcc]: https://github.com/tgtakaoka/homebrew-mspgcc
[tgtakaoka/msp430-elf]: https://github.com/tgtakaoka/homebrew-msp430-elf
[tgtakaoka/tinyos-msp430]: https://github.com/tgtakaoka/homebrew-tinyos-msp430