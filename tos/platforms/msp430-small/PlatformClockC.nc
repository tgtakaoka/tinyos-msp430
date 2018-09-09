configuration PlatformClockC {
    uses interface Msp430ClockInit;
}
implementation {
    components PlatformClockP;
    components Msp430DcoCalibC;

    Msp430ClockInit = PlatformClockP;
    PlatformClockP.DcoCalib -> Msp430DcoCalibC;
}
