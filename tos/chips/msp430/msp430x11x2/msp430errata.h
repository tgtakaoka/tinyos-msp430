#ifndef _H_msp430errata_h
#define _H_msp430errata_h

/* See SLAZ009 MSP430F11x2/12x2 Device Erratasheet, Revised April 2006 */

#if defined(__MSP430_1122__) || defined(__MSP430_1132__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'E'"
#define __MSP430_REV__ 'E'
#endif

#if __MSP430_REV__ == 'E'
#define ERRATA_BCL5
#define ERRATA_CPU4
#define ERRATA_PORT3
#define ERRATA_RES4
#define ERRATA_TA12
#define ERRATA_TA13
#define ERRATA_TA16
#define ERRATA_US13
#define ERRATA_US15
#define ERRATA_WDG2
#endif

#else
#error "This msp430errata.h is for MSP430F11x2"
#endif

#endif
