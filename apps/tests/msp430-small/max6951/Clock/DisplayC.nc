/* -*- mode: nesc; mode: flyspell-prog; -*- */

configuration DisplayC {
    provides {
        interface Led7Segs<uint16_t> as Sec;
        interface Led7Segs<uint16_t> as Min;
        interface Led7Segs<uint16_t> as Hour;
    }
}
implementation {
#define MAX6951_RESOURCE "MAX6951_RESOURCE"
    components PlatformPinsC as PinsC;
    components new PlatformSpiC() as SpiMasterC;
    components new Max6951C(MAX6951_RESOURCE) as Max6951;
    components new Led7SegsP(MAX6951_RESOURCE, 2, uint16_t) as S;
    components new Led7SegsP(MAX6951_RESOURCE, 2, uint16_t) as M;
    components new Led7SegsP(MAX6951_RESOURCE, 2, uint16_t) as H;

    Sec = S;
    Min = M;
    Hour = H;

    Max6951.SpiCS -> PinsC.SpiCS0;
    Max6951.SpiByte -> SpiMasterC;
    Max6951.SpiResource -> SpiMasterC;
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
