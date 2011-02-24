/* -*- mode: nesc; mode: flyspell-prog; -*- */

configuration DisplayC {
    provides {
        interface Led7Segs<uint16_t> as Sec;
        interface Led7Segs<uint16_t> as Min;
        interface Led7Segs<uint16_t> as Hour;
    }
}
implementation {
    components MainC;
    components HplMsp430GeneralIOC as GeneralIOC;
    components new Msp430GpioC() as CS;
    components PlatformSpiC as SpiC;
    components new Max6951SpiP("Max6951") as Max6951;
    components new Led7SegsC("Max6951", 2, uint16_t) as S;
    components new Led7SegsC("Max6951", 2, uint16_t) as M;
    components new Led7SegsC("Max6951", 2, uint16_t) as H;

    CS -> GeneralIOC.Port30;

    Sec = S;
    Min = M;
    Hour = H;

    Max6951.Boot -> MainC.Boot;
    Max6951.CS -> CS;
    Max6951.SpiByte -> SpiC;
    Max6951.SpiControl -> SpiC;

    S.Led7Seg -> Max6951;
    M.Led7Seg -> Max6951;
    H.Led7Seg -> Max6951;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
