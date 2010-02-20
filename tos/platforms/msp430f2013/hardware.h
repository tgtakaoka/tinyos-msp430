#ifndef _H_hardware_h
#define _H_hardware_h
#include "msp430hardware.h"

// LED
TOSH_ASSIGN_PIN(RED_LED, 1, 0);

// GIO pins
TOSH_ASSIGN_PIN(GIO1, 1, 1);
TOSH_ASSIGN_PIN(GIO2, 1, 2);
TOSH_ASSIGN_PIN(GIO3, 1, 3);
TOSH_ASSIGN_PIN(GIO4, 1, 4);
TOSH_ASSIGN_PIN(GIO5, 1, 5);
TOSH_ASSIGN_PIN(GIO6, 1, 6);
TOSH_ASSIGN_PIN(GIO7, 1, 7);

// P2.6=XIN, P2.7=XOUT
//TOSH_ASSIGN_PIN(GIO8, 2, 6);
//TOSH_ASSIGN_PIN(GIO9, 2, 7);

#endif // _H_hardware_h
