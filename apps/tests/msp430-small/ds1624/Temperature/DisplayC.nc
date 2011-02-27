/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "SpiMaster.h"

configuration DisplayC {
    provides {
        interface Led7Segs<uint16_t> as Frac;
        interface Led7Segs<uint16_t> as Temp;
        interface Led7Segs<uint16_t> as Sec;
        interface Led7Segs<uint16_t> as Min;
    }
}

implementation {
    components MainC;
    components GpioConf as GpioC;
#if defined(__MSP430_HAS_USCI__)
    components PlatformSpiC as SpiC;
#else
    components new SpiMasterC(SPI_MASTER_MODE0, SPI_MASTER_MSB) as SpiC;
    components new NCGeneralIOC() as SOMI;
    SpiC.SIMO -> GpioC.SIMO;
    SpiC.SOMI -> SOMI;
    SpiC.CLK -> GpioC.CLK;
#endif
    components new HplMax6951C("HH:MM TT.FF");
    components new Max6951P();
    components new Led7SegsC("HH:MM TT.FF", 2, uint16_t) as F;
    components new Led7SegsC("HH:MM TT.FF", 2, uint16_t) as T;
    components new Led7SegsC("HH:MM TT.FF", 2, uint16_t) as S;
    components new Led7SegsC("HH:MM TT.FF", 2, uint16_t) as M;

    Frac = F;
    Temp = T;
    Sec = S;
    Min = M;

    HplMax6951C.Boot -> MainC.Boot;
    HplMax6951C.CS -> GpioC.STE;
    HplMax6951C.SpiByte -> SpiC;
    HplMax6951C.SpiControl -> SpiC;

    Max6951P.Hpl -> HplMax6951C;

    F.Led7Seg -> Max6951P;
    T.Led7Seg -> Max6951P;
    S.Led7Seg -> Max6951P;
    M.Led7Seg -> Max6951P;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
