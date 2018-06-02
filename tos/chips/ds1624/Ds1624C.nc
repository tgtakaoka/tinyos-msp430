#include "I2C.h"

generic configuration Ds1624C(uint8_t devAddr) {
    provides interface Ds1624;
    uses {
        interface Resource as I2CResource;
        interface I2CPacket<TI2CBasicAddr>;
    }
}
implementation {
    components new HplDs1624P(devAddr) as Hpl;
    components new Ds1624P();
    components new Timer16MilliC() as Timer16;

    Ds1624 = Ds1624P;
    I2CResource = Hpl;
    I2CPacket = Hpl;

    Ds1624P.Hpl -> Hpl;
    Ds1624P.Timer16 -> Timer16;
}
