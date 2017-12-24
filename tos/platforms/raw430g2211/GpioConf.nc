/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

configuration GpioConf {
    provides {
        interface GeneralIO as STE;
#ifdef USE_BIT_BANG_SPI_MASTER
        interface GeneralIO as SIMO;
        interface GeneralIO as SOMI;
        interface GeneralIO as CLK;
#endif

#ifdef USE_BIT_BANG_I2C_MASTER
        interface GeneralIO as SCL;
        interface GeneralIO as SDA;
#endif
    }
}
implementation {
    components HplMsp430GeneralIOC as IOC;

    components new Msp430GpioC() as STE0;
    STE0  -> IOC.Port15;
    STE  = STE0;

#ifdef USE_BIT_BANG_SPI_MASTER
    components new Msp430GpioC() as SIMO0;
    components new Msp430GpioC() as SOMI0;
    components new Msp430GpioC() as CLK0;
    CLK0  -> IOC.Port14;
    SIMO0 -> IOC.Port12;
    SOMI0 -> IOC.Port11;
    CLK  = CLK0;
    SIMO = SIMO0;
    SOMI = SOMI0;
#endif

#ifdef USE_BIT_BANG_I2C_MASTER
    components new Msp430GpioC() as SCL0;
    components new Msp430GpioC() as SDA0;
    SCL0 -> IOC.Port16;
    SDA0 -> IOC.Port17;
    SCL = SCL0;
    SDA = SDA0;
#endif
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
