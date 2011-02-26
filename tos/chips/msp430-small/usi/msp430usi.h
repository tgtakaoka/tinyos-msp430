/* -*- mode: nesc; mode: flyspell-prog; -*- */
/* Copyright (c) 2011, Tadashi G Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef _H_MSP430USI_H
#define _H_MSP430USI_H

// USI: SPI, I2C
#define MSP430_HPLUSI_RESOURCE "Msp430Usi.Resource"
#define MSP430_HPLUSI_RESOURCE "Msp430Usi.Resource"
#define MSP430_SPI_BUS          MSP430_HPLUSI_RESOURCE
#define MSP430_I2C_BUS          MSP430_HPLUSI_RESOURCE

typedef struct {
    unsigned int usiswrst : 1;  // software reset (1=held in reset state)
    unsigned int usioe    : 1;  // data output enable (1=enabled)
    unsigned int usige    : 1;  // output latch control (1=transparent; 0=gated by clock)
    unsigned int usimst   : 1;  // master select (1=master)
    unsigned int usilsb   : 1;  // lsb first select (1=lsb first)
    unsigned int usipe5   : 1;  // SCLK port enable (1=function enabled)
    unsigned int usipe6   : 1;  // SDO/SCL port enable (1=function enabled)
    unsigned int usipe7   : 1;  // SDI/SDA port enable (1=function enabled)
} __attribute__((packed)) msp430_usictl0_t;

typedef struct {
    unsigned int usiifg   : 1;  // counter interrupt flag (1=pending)
    unsigned int usisttifg: 1;  // start condition interrupt flag (1=pending)
    unsigned int usistp   : 1;  // stop condition received (1=received)
    unsigned int usial    : 1;  // arbitration lost (1=detected)
    unsigned int usiiie   : 1;  // counter interrupt enable (1=enabled)
    unsigned int usisttie : 1;  // start condition interrupt enable (1=enabled)
    unsigned int usii2c   : 1;  // i2c mode enable (1=i2c; 0=spi)
    unsigned int usickph  : 1;  // clock phase select (0=output then capture;
                                // 1=capture then output)
} __attribute__((packed)) msp430_usictl1_t;

typedef struct {
    unsigned int usiswclk : 1;  // software clock (SWCLK)
    unsigned int usickpl  : 1;  // clock polarity select (0=inactive low; 1=inactive high)
    unsigned int usissel  : 3;  // clock source select (0=SCLK; 1=ACLK; 2=SMCLK; 4=SWCLK;
                                // 5=TACCR0; 6=TACCR1; 7=TACCR2)
    unsigned int usidiv   : 3;  // clock divider select (0=/1; 1=/2; ... 7=/128)
} __attribute__((packed)) msp430_usickctl_t;

typedef struct {
    unsigned int usicnt   : 5;  // bit count
    unsigned int usiifgcc : 1;  // interrupt flag clear control (0=cleared on USICNT write)
    unsigned int usi16b   : 1;  // 16-bit shift register enabled (0=8-bit; 1=16-bit)
    unsigned int usisclrel: 1;  // SCL release (1=released; 0=held low if USIIFG set)
} __attribute__((packed)) msp430_usicnt_t;

//converts from typedefstructs to uint8_t
DEFINE_UNION_CAST(usictl02int, uint8_t, msp430_usictl0_t)
DEFINE_UNION_CAST(int2usictl0, msp430_usictl0_t, uint8_t)
DEFINE_UNION_CAST(usictl12int, uint8_t, msp430_usictl1_t)
DEFINE_UNION_CAST(int2usictl1, msp430_usictl1_t, uint8_t)
DEFINE_UNION_CAST(usickctl2int, uint8_t, msp430_usickctl_t)
DEFINE_UNION_CAST(int2usickctl, msp430_usickctl_t, uint8_t)
DEFINE_UNION_CAST(usicnt2int, uint8_t, msp430_usicnt_t)
DEFINE_UNION_CAST(int2usicnt, msp430_usicnt_t, uint8_t)

typedef enum {
    USI_SPI = 0,
    USI_I2C = 1,
} msp430_usimode_t;

/*
 * SPI
 */

typedef struct {
    // USICKCTL, USI Clock Control Register
    unsigned int          : 1;
    unsigned int usickpl  : 1;  // clock polarity select
    unsigned int usissel  : 3;  // clock source select
    unsigned int usidiv   : 3;  // clock divider select

    // USICTL0, USI Control Register 0
    unsigned int          : 1;  // software rest
    unsigned int          : 2;  // data output controls
    unsigned int usimst   : 1;  // 1: master mode
    unsigned int usilsb   : 1;  // 1: lsb first
    unsigned int          : 3;  // port enables

    // USICTL1, USI Control Register 1
    unsigned int          : 4;  // interrupt flags
    unsigned int          : 2;  // interrupt enables
    unsigned int          : 1;  // i2c mode enable
    unsigned int usickph  : 1;  // clock phase select
} msp430_spi_config_t;


typedef struct {
    uint8_t usickctl;
    uint8_t  usictl0;
    uint8_t  usictl1;
} msp430_spi_registers_t;

typedef union {
    msp430_spi_config_t spiConfig;
    msp430_spi_registers_t spiRegisters;
} msp430_spi_union_config_t;


const msp430_spi_union_config_t msp430_spi_default_config = {
    {
    usimst    : 1,            // master
    usilsb    : 0,            // msb first
    usickpl   : 0,
    usickph   : 1,
    usissel   : 2,            // SMCLK
    usidiv    : 1,            // SMCLK/2
    },
};
    
#endif  /* _H_MSP430USI_H */

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
