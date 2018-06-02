/* -*- mode: nesc; mode: flyspell-prog; -*- */

configuration DisplayC {
    provides {
        interface Led7Segs<uint16_t> as Frac;
        interface Led7Segs<uint16_t> as Temp;
        interface Led7Segs<uint16_t> as CentiSec;
    }
}
implementation {
#define MAX6951_RESOURCE "MAX6951_RESOURCE"
    components PlatformPinsC as PinsC;
    components new PlatformSpiC() as SpiMasterC;
    components new Max6951C(MAX6951_RESOURCE) as Max6951;
    components new Led7SegsP(MAX6951_RESOURCE, 2, uint16_t) as F;
    components new Led7SegsP(MAX6951_RESOURCE, 2, uint16_t) as T;
    components new Led7SegsP(MAX6951_RESOURCE, 2, uint16_t) as C;

    Frac = F;
    Temp = T;
    CentiSec = C;

    Max6951.SpiCS -> PinsC.SpiCS0;
    Max6951.SpiByte -> SpiMasterC;
    Max6951.SpiResource -> SpiMasterC;
    F.Led7Seg -> Max6951;
    T.Led7Seg -> Max6951;
    C.Led7Seg -> Max6951;
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
