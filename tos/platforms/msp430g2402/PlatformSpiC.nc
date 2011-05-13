/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "hardware.h"

#ifdef USE_SPI_MASTER
#include_next "PlatformSpiC.nc"
#else

#include "msp430usi.h"

configuration PlatformSpiC {
    provides {
        interface StdControl as SpiControl;
        interface SpiByte;
        interface SpiPacket;
    }
}
implementation {
    components new Msp430Spi0C() as SpiC;
    SpiByte = SpiC;
    SpiPacket = SpiC;

    components UsiConf;
    SpiControl = UsiConf.SpiControl;
    UsiConf.Msp430SpiConfigure <- SpiC;
    UsiConf.SpiResource -> SpiC;
}
#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
