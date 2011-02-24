/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usci.h"

configuration PlatformSpiC {
    provides interface StdControl as SpiControl;
    provides interface SpiByte;
    provides interface SpiPacket;
}
implementation {
    components new Msp430SpiB0C() as SpiC;
    SpiByte = SpiC;
    SpiPacket = SpiC;

    components UsciConf;
    SpiControl = UsciConf.SpiControl;
    UsciConf.Msp430SpiConfigure <- SpiC;
    UsciConf.SpiResource -> SpiC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
