/* -*- mode: nesc; mode: flyspell-prog; -*- */

#include "BitBangSpiMaster.h"

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
    components PlatformPinsC as PinsC;
    components PlatformSpiC as SpiC;
    components new HplMax6951P("HH:MM TT.FF");
    components new Max6951P();
    components new Led7SegsP("HH:MM TT.FF", 2, uint16_t) as F;
    components new Led7SegsP("HH:MM TT.FF", 2, uint16_t) as T;
    components new Led7SegsP("HH:MM TT.FF", 2, uint16_t) as S;
    components new Led7SegsP("HH:MM TT.FF", 2, uint16_t) as M;

    Frac = F;
    Temp = T;
    Sec = S;
    Min = M;

    HplMax6951P.Boot -> MainC.Boot;
    HplMax6951P.CS -> PinsC.SpiCS0;
    HplMax6951P.SpiByte -> SpiC;
    HplMax6951P.SpiControl -> SpiC;

    Max6951P.Hpl -> HplMax6951P;

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
