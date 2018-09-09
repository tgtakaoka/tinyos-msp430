module PlatformClockP {
    uses {
        interface Msp430ClockInit;
        interface Msp430DcoCalib as DcoCalib;
    }
}
implementation {
    event void Msp430ClockInit.initClocks() {
        call DcoCalib.busyWaitCalibrateDco();
        call Msp430ClockInit.defaultInitClocks();
    }

    event void Msp430ClockInit.initTimerMicro() {
        call Msp430ClockInit.defaultInitTimerMicro();
    }

    event void Msp430ClockInit.initTimerMilli() {
        call Msp430ClockInit.defaultInitTimerMilli();
    }
}
