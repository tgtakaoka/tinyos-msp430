interface Msp430ClockInit
{
    event void initClocks();
    command void defaultInitClocks();

    event void initTimerA();
    command void defaultInitTimerA();
}
