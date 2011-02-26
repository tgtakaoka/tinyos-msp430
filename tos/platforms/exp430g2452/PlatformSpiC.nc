/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "msp430usi.h"

configuration PlatformSpiC {
    provides interface StdControl as SpiControl;
    provides interface SpiByte;
    provides interface SpiPacket;
}
implementation {
    components new Msp430SpiC() as SpiC;
    SpiByte = SpiC;
    SpiPacket = SpiC;

    components UsiConf;
    SpiControl = UsiConf.SpiControl;
    UsiConf.Msp430SpiConfigure <- SpiC;
    UsiConf.SpiResource -> SpiC;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
