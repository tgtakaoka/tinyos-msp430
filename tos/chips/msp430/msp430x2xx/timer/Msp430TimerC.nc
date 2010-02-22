configuration Msp430TimerC
{
    provides interface Msp430Timer as TimerA;
    provides interface Msp430TimerControl as ControlA0;
    provides interface Msp430Compare as CompareA0;
    provides interface Msp430Capture as CaptureA0;
    provides interface Msp430TimerControl as ControlA1;
    provides interface Msp430Compare as CompareA1;
    provides interface Msp430Capture as CaptureA1;
#if defined(__MSP430_HAS_TA3__)
    provides interface Msp430TimerControl as ControlA2;
    provides interface Msp430Compare as CompareA2;
    provides interface Msp430Capture as CaptureA2;
#endif
#if defined(__MSP430_HAS_T1A2__)
    provides interface Msp430Timer as Timer1A;
    provides interface Msp430TimerControl as Control1A0;
    provides interface Msp430Compare as Compare1A0;
    provides interface Msp430Capture as Capture1A0;
    provides interface Msp430TimerControl as Control1A1;
    provides interface Msp430Compare as Compare1A1;
    provides interface Msp430Capture as Capture1A1;
#endif
#if defined(__MSP430_HAS_TB3__)
    provides interface Msp430Timer as TimerB;
    provides interface Msp430TimerControl as ControlB0;
    provides interface Msp430TimerControl as ControlB1;
    provides interface Msp430TimerControl as ControlB2;
    provides interface Msp430Compare as CompareB0;
    provides interface Msp430Compare as CompareB1;
    provides interface Msp430Compare as CompareB2;
    provides interface Msp430Capture as CaptureB0;
    provides interface Msp430Capture as CaptureB1;
    provides interface Msp430Capture as CaptureB2;
#endif
}
implementation
{
    components new Msp430TimerP(TAIV_, TAR_, TACTL_, TAIFG, TACLR, TAIE,
                                TASSEL0, TASSEL1, FALSE) as Msp430TimerA;
    components new Msp430TimerCapComP(TACCTL0_, TACCR0_) as Msp430TimerA0;
    components new Msp430TimerCapComP(TACCTL1_, TACCR1_) as Msp430TimerA1;
#if defined(__MSP430_HAS_TA3__)
    components new Msp430TimerCapComP(TACCTL2_, TACCR2_) as Msp430TimerA2;
#endif
#if defined(__MSP430_HAS_T1A2__)
    components new Msp430TimerP(TA1IV_, TAR1_, TA1CTL_, TAIFG, TACLR, TAIE,
                                TASSEL0, TASSEL1, FALSE) as Msp430Timer1A;
    components new Msp430TimerCapComP(TACCTL0_, TACCR0_) as Msp430Timer1A0;
    components new Msp430TimerCapComP(TACCTL1_, TACCR1_) as Msp430Timer1A1;
#endif
#if defined(__MSP430_HAS_TB3__)
    components new Msp430TimerP(TBIV_, TBR_, TBCTL_, TBIFG, TBCLR, TBIE,
                                TBSSEL0, TBSSEL1, FALSE) as Msp430TimerB;
    components new Msp430TimerCapComP(TBCCTL0_, TBCCR0_) as Msp430TimerB0;
    components new Msp430TimerCapComP(TBCCTL1_, TBCCR1_) as Msp430TimerB1;
    components new Msp430TimerCapComP(TBCCTL2_, TBCCR2_) as Msp430TimerB2;
#endif
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

#if defined(__MSP430_HAS_TA3__)
    // Timer A2
    ControlA2 = Msp430TimerA2.Control;
    CompareA2 = Msp430TimerA2.Compare;
    CaptureA2 = Msp430TimerA2.Capture;
    Msp430TimerA2.Timer -> Msp430TimerA.Timer;
    Msp430TimerA2.Event -> Msp430TimerA.Event[2];
#endif

#if defined(__MSP430_HAS_T1A2__)
    // Timer1 A
    Timer1A = Msp430Timer1A.Timer;
    Msp430Timer1A.Overflow -> Msp430Timer1A.Event[5];
    Msp430Timer1A.VectorTimerX0 -> Common.VectorTimer1A0;
    Msp430Timer1A.VectorTimerX1 -> Common.VectorTimer1A1;

    // Timer1 A0
    Control1A0 = Msp430Timer1A0.Control;
    Compare1A0 = Msp430Timer1A0.Compare;
    Capture1A0 = Msp430Timer1A0.Capture;
    Msp430Timer1A0.Timer -> Msp430Timer1A.Timer;
    Msp430Timer1A0.Event -> Msp430Timer1A.Event[0];

    // Timer1 A1
    Control1A1 = Msp430Timer1A1.Control;
    Compare1A1 = Msp430Timer1A1.Compare;
    Capture1A1 = Msp430Timer1A1.Capture;
    Msp430Timer1A1.Timer -> Msp430Timer1A.Timer;
    Msp430Timer1A1.Event -> Msp430Timer1A.Event[1];
#endif

#if defined(__MSP430_HAS_TB3__)
    // Timer B
    TimerB = Msp430TimerB.Timer;
    Msp430TimerB.Overflow -> Msp430TimerB.Event[7];
    Msp430TimerB.VectorTimerX0 -> Common.VectorTimerB0;
    Msp430TimerB.VectorTimerX1 -> Common.VectorTimerB1;

    // Timer B0
    ControlB0 = Msp430TimerB0.Control;
    CompareB0 = Msp430TimerB0.Compare;
    CaptureB0 = Msp430TimerB0.Capture;
    Msp430TimerB0.Timer -> Msp430TimerB.Timer;
    Msp430TimerB0.Event -> Msp430TimerB.Event[0];

    // Timer B1
    ControlB1 = Msp430TimerB1.Control;
    CompareB1 = Msp430TimerB1.Compare;
    CaptureB1 = Msp430TimerB1.Capture;
    Msp430TimerB1.Timer -> Msp430TimerB.Timer;
    Msp430TimerB1.Event -> Msp430TimerB.Event[1];

    // Timer B2
    ControlB2 = Msp430TimerB2.Control;
    CompareB2 = Msp430TimerB2.Compare;
    CaptureB2 = Msp430TimerB2.Capture;
    Msp430TimerB2.Timer -> Msp430TimerB.Timer;
    Msp430TimerB2.Event -> Msp430TimerB.Event[2];
#endif
}
