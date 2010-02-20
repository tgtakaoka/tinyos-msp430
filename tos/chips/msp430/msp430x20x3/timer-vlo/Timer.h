#ifndef TIMER_H
#define TIMER_H

typedef struct { int notUsed; } TMilli;
typedef struct { int notUsed; } T32khz;
typedef struct { int notUsed; } TMicro;

#define UQ_TIMER_MILLI "HilTimerMilliC.Timer"
#define UQ_TIMER_32KHZ "HilTimer32khzC.Timer"
#define UQ_TIMER_MICRO "HilTimerMicroC.Timer"

typedef struct { int notUsed; } TVlo;
#define VLO_HZ 12300

#endif
