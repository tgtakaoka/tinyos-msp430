/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usci.h"

configuration PlatformSpiC {
    provides interface StdControl;
    provides interface SpiByte;
    provides interface SpiPacket;
}
implementation {
    components new Msp430SpiB0C() as SpiC;
    SpiByte = SpiC;
    SpiPacket = SpiC;

    components UsciConf;
    StdControl = UsciConf.SpiControl;
    UsciConf.Msp430SpiConfigure <- SpiC.Msp430SpiConfigure;
    UsciConf.SpiResource -> SpiC.Resource;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
