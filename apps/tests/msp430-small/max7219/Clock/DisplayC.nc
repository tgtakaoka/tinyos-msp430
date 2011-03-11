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
    components new HplMax7219C("HH:MM:SS");
    components new Max7219P();
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as S;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as M;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as H;

    Sec = S;
    Min = M;
    Hour = H;

    HplMax7219C.Boot -> MainC.Boot;
    HplMax7219C.Load -> GpioC.STE;
    HplMax7219C.SpiByte -> SpiC;
    HplMax7219C.SpiControl -> SpiC;

    Max7219P.Hpl -> HplMax7219C;

    S.Led7Seg -> Max7219P;
    M.Led7Seg -> Max7219P;
    H.Led7Seg -> Max7219P;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
