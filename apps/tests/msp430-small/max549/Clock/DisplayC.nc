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
    components GpioConf as GpioC;
    components PlatformSpiC as SpiC;
    components new Max6951P("HH:MM:SS") as LED8Digits;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as S;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as M;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as H;

    Sec = S;
    Min = M;
    Hour = H;

    LED8Digits.Boot -> MainC.Boot;
    LED8Digits.CS -> GpioC.STE;
    LED8Digits.SpiByte -> SpiC;
    LED8Digits.SpiControl -> SpiC;

    S.Led7Seg -> LED8Digits;
    M.Led7Seg -> LED8Digits;
    H.Led7Seg -> LED8Digits;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
