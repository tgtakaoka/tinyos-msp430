#ifndef _H_msp430port_compat_h
#define _H_msp430port_compat_h

#ifdef __MSP430_HAS_PORT1_R__
#define __msp430_have_port1
#endif
#ifdef __MSP430_HAS_PORT2_R__
#define __msp430_have_port2
#endif
#ifdef __MSP430_HAS_PORT3_R__
#define __msp430_have_port3
#endif
#ifdef __MSP430_HAS_PORT4_R__
#define __msp430_have_port4
#endif
#ifdef __MSP430_HAS_PORT5_R__
#define __msp430_have_port5
#endif
#ifdef __MSP430_HAS_PORT6_R__
#define __msp430_have_port6
#endif
#ifdef __MSP430_HAS_PORT7_R__
#define __msp430_have_port7
#endif
#ifdef __MSP430_HAS_PORT8_R__
#define __msp430_have_port8
#endif
#ifdef __MSP430_HAS_PORT9_R__
#define __msp430_have_port9
#endif
#ifdef __MSP430_HAS_PORT10_R__
#define __msp430_have_port10
#endif

#define TYPE_PORT_REN uint8_t

#endif
