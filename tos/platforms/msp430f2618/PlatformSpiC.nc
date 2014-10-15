/* -*- mode: nesc; mode: flyspell-prog; -*- */

#ifdef USE_BIT_BANG_SPI_MASTER
#include_next "PlatformSpiC.nc"
#else

#include "msp430usci.h"

configuration PlatformSpiC {
    provides interface StdControl as SpiControl;
    provides interface SpiByte;
    provides interface SpiPacket;
}
implementation {
    components new Msp430Spi0C() as SpiC;
    SpiByte = SpiC;
    SpiPacket = SpiC;

    components UsciConf;
    SpiControl = UsciConf.SpiControl;
    UsciConf.Msp430SpiConfigure <- SpiC;
    UsciConf.SpiResource -> SpiC;
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
