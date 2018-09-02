configuration Msp430VloCalibC {
    provides {
        interface Msp430VloCalib as VloCalib;
        interface Msp430VloCalibInfo as VloCalibInfo;
    }
}
implementation {
    components Msp430VloCalibP as CalibP;

    components Msp430VloCalibP, Msp430TimerC;

    VloCalib = Msp430VloCalibP;
    VloCalibInfo = Msp430VloCalibP;
    Msp430VloCalibP.Timer -> Msp430TimerC.TimerA;
#if defined(__MSP430_HAS_TA2__)
    Msp430VloCalibP.Control -> Msp430TimerC.ControlA0;
    Msp430VloCalibP.Capture -> Msp430TimerC.CaptureA0;
#elif defined(__MSP430_HAS_TA3__)
#if defined(__MSP430G2402) || defined(__MSP430G2452) || defined(__MSP430G2553)
    /* Some MSP430G2xx have TA3 but ACLK is connected to CCR0.CCIB */
    Msp430VloCalibP.Control -> Msp430TimerC.ControlA0;
    Msp430VloCalibP.Capture -> Msp430TimerC.CaptureA0;
#else
    Msp430VloCalibP.Control -> Msp430TimerC.ControlA2;
    Msp430VloCalibP.Capture -> Msp430TimerC.CaptureA2;
#endif
#endif
}
