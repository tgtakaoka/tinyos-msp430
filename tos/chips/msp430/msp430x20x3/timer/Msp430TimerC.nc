configuration Msp430TimerC
{
    provides interface Msp430Timer as TimerA;
    provides interface Msp430TimerControl as ControlA0;
    provides interface Msp430Compare as CompareA0;
    provides interface Msp430Capture as CaptureA0;
    provides interface Msp430TimerControl as ControlA1;
    provides interface Msp430Compare as CompareA1;
    provides interface Msp430Capture as CaptureA1;
}
implementation
{
    components new Msp430TimerP(TAIV_, TAR_, TACTL_, TAIFG, TACLR, TAIE,
                                TASSEL0, TASSEL1, FALSE) as Msp430TimerA;
    components new Msp430TimerCapComP(TACCTL0_, TACCR0_) as Msp430TimerA0;
    components new Msp430TimerCapComP(TACCTL1_, TACCR1_) as Msp430TimerA1;
    components Msp430TimerCommonP as Common;

    // Timer A
    TimerA = Msp430TimerA.Timer;
    Msp430TimerA.Overflow -> Msp430TimerA.Event[5];
    Msp430TimerA.VectorTimerX0 -> Common.VectorTimerA0;
    Msp430TimerA.VectorTimerX1 -> Common.VectorTimerA1;

    // Timer A0
    ControlA0 = Msp430TimerA0.Control;
    CompareA0 = Msp430TimerA0.Compare;
    CaptureA0 = Msp430TimerA0.Capture;
    Msp430TimerA0.Timer -> Msp430TimerA.Timer;
    Msp430TimerA0.Event -> Msp430TimerA.Event[0];

    // Timer A1
    ControlA1 = Msp430TimerA1.Control;
    CompareA1 = Msp430TimerA1.Compare;
    CaptureA1 = Msp430TimerA1.Capture;
    Msp430TimerA1.Timer -> Msp430TimerA.Timer;
    Msp430TimerA1.Event -> Msp430TimerA.Event[1];
}
