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
    components new HplMax6951C("HH:MM:SS");
    components new Max6951P();
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as S;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as M;
    components new Led7SegsC("HH:MM:SS", 2, uint16_t) as H;

    Sec = S;
    Min = M;
    Hour = H;

    HplMax6951C.Boot -> MainC.Boot;
    HplMax6951C.CS -> GpioC.STE;
    HplMax6951C.SpiByte -> SpiC;
    HplMax6951C.SpiControl -> SpiC;

    Max6951P.Hpl -> HplMax6951C;

    S.Led7Seg -> Max6951P;
    M.Led7Seg -> Max6951P;
    H.Led7Seg -> Max6951P;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
