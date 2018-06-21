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
    components PlatformPinsC as PinsC;
    components PlatformSpiC as SpiC;
    components new HplMax7219P("HH:MM:SS");
    components new Max7219P();
    components new Led7SegsP("HH:MM:SS", 2, uint16_t) as S;
    components new Led7SegsP("HH:MM:SS", 2, uint16_t) as M;
    components new Led7SegsP("HH:MM:SS", 2, uint16_t) as H;

    Sec = S;
    Min = M;
    Hour = H;

    HplMax7219P.Boot -> MainC.Boot;
    HplMax7219P.Load -> PinsC.SpiCS0;
    HplMax7219P.SpiByte -> SpiC;
    HplMax7219P.SpiControl -> SpiC;

    Max7219P.Hpl -> HplMax7219P;

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
