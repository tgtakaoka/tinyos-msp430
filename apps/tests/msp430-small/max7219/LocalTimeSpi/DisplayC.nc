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
    components new Msp430GpioC() as Load;
    components PlatformSpiC as SpiC;
    components new Max7219SpiP("Max7219") as Max7219;
    components new Led7SegsC("Max7219", 2, uint16_t) as S;
    components new Led7SegsC("Max7219", 2, uint16_t) as M;
    components new Led7SegsC("Max7219", 2, uint16_t) as H;

    Load -> GeneralIOC.Port30;

    Sec = S;
    Min = M;
    Hour = H;

    Max7219.Boot -> MainC.Boot;
    Max7219.Load -> Load;
    Max7219.SpiByte -> SpiC;
    Max7219.SpiControl -> SpiC;

    S.Led7Seg -> Max7219;
    M.Led7Seg -> Max7219;
    H.Led7Seg -> Max7219;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
