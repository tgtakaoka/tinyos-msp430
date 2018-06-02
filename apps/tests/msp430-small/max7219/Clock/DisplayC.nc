/* -*- mode: nesc; mode: flyspell-prog; -*- */

configuration DisplayC {
    provides {
        interface Led7Segs<uint16_t> as Sec;
        interface Led7Segs<uint16_t> as Min;
        interface Led7Segs<uint16_t> as Hour;
    }
}
implementation {
#define MAX7219_RESOURCE "MAX7219_RESOURCE"
    components PlatformSpiC as SpiC;
    components new Max7219C(MAX7219_RESOURCE);
    components new Led7SegsP(MAX7219_RESOURCE, 2, uint16_t) as S;
    components new Led7SegsP(MAX7219_RESOURCE, 2, uint16_t) as M;
    components new Led7SegsP(MAX7219_RESOURCE, 2, uint16_t) as H;

    Sec = S;
    Min = M;
    Hour = H;

    Max7219C.Load -> SpiC.CS0;
    S.Led7Seg -> Max7219C;
    M.Led7Seg -> Max7219C;
    H.Led7Seg -> Max7219C;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
