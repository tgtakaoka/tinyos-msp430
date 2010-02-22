#ifndef _H_msp430errata_h
#define _H_msp430errata_h

/* See SLAZ041C MSP430F21x2 Device Erratasheet, Revised January 2010 */

#if defined(__MSP430_2112__) || defined(__MSP430_2122__) || defined(__MSP430_2132__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif

#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B'
#define ERRATA_BCL12
#define ERRATA_CPU19
#define ERRATA_FLASH19
#define ERRATA_FLASH24
#define ERRATA_FLASH27
#define ERRATA_PORT12
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#define ERRATA_USCI20
#define ERRATA_USCI21
#define ERRATA_USCI22
#define ERRATA_USCI23
#define ERRATA_USCI24
#define ERRATA_USCI25
#define ERRATA_USCI26
#define ERRATA_USCI28
#define ERRATA_XOSC5
#define ERRATA_XOSC8
#endif

#if __MSP430_REV__ == 'A'
#define ERRATA_BCL13
#endif

#else
#error "This msp430errata.h is for MSP430F21x2"
#endif

#endif
