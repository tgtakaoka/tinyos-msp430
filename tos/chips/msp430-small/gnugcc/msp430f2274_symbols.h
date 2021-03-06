/* ============================================================================ */
/* Copyright (c) 2018, Texas Instruments Incorporated                           */
/*  All rights reserved.                                                        */
/*                                                                              */
/*  Redistribution and use in source and binary forms, with or without          */
/*  modification, are permitted provided that the following conditions          */
/*  are met:                                                                    */
/*                                                                              */
/*  *  Redistributions of source code must retain the above copyright           */
/*     notice, this list of conditions and the following disclaimer.            */
/*                                                                              */
/*  *  Redistributions in binary form must reproduce the above copyright        */
/*     notice, this list of conditions and the following disclaimer in the      */
/*     documentation and/or other materials provided with the distribution.     */
/*                                                                              */
/*  *  Neither the name of Texas Instruments Incorporated nor the names of      */
/*     its contributors may be used to endorse or promote products derived      */
/*     from this software without specific prior written permission.            */
/*                                                                              */
/*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" */
/*  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,       */
/*  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR      */
/*  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR            */
/*  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,       */
/*  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,         */
/*  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; */
/*  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,    */
/*  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR     */
/*  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,              */
/*  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                          */
/* ============================================================================ */

/* This file supports MSP430F2274 devices. */
/* Version: 1.206 */

/************************************************************
* STANDARD BITS
************************************************************/
/************************************************************
* STATUS REGISTER BITS
************************************************************/
/************************************************************
* PERIPHERAL FILE MAP
************************************************************/
/************************************************************
* SPECIAL FUNCTION REGISTER ADDRESSES + CONTROL BITS
************************************************************/
#define IE1_	0x0000
#define IFG1_	0x0002
#define IE2_	0x0001
#define IFG2_	0x0003
/************************************************************
* ADC10
************************************************************/
#define ADC10DTC0_	0x0048
#define ADC10DTC1_	0x0049
#define ADC10AE0_	0x004A
#define ADC10AE1_	0x004B
#define ADC10CTL0_	0x01B0
#define ADC10CTL1_	0x01B2
#define ADC10MEM_	0x01B4
#define ADC10SA_	0x01BC
/************************************************************
* Basic Clock Module
************************************************************/
#define DCOCTL_	0x0056
#define BCSCTL1_	0x0057
#define BCSCTL2_	0x0058
#define BCSCTL3_	0x0053
/*************************************************************
* Flash Memory
*************************************************************/
#define FCTL1_	0x0128
#define FCTL2_	0x012A
#define FCTL3_	0x012C
/************************************************************
* Operational Amplifier
************************************************************/
#define OA0CTL0_	0x00C0
#define OA0CTL1_	0x00C1
#define OA1CTL0_	0x00C2
#define OA1CTL1_	0x00C3
/************************************************************
* DIGITAL I/O Port1/2 Pull up / Pull down Resistors
************************************************************/
#define P1IN_	0x0020
#define P1OUT_	0x0021
#define P1DIR_	0x0022
#define P1IFG_	0x0023
#define P1IES_	0x0024
#define P1IE_	0x0025
#define P1SEL_	0x0026
#define P1REN_	0x0027
#define P2IN_	0x0028
#define P2OUT_	0x0029
#define P2DIR_	0x002A
#define P2IFG_	0x002B
#define P2IES_	0x002C
#define P2IE_	0x002D
#define P2SEL_	0x002E
#define P2REN_	0x002F
/************************************************************
* DIGITAL I/O Port3/4 Pull up / Pull down Resistors
************************************************************/
#define P3IN_	0x0018
#define P3OUT_	0x0019
#define P3DIR_	0x001A
#define P3SEL_	0x001B
#define P3REN_	0x0010
#define P4IN_	0x001C
#define P4OUT_	0x001D
#define P4DIR_	0x001E
#define P4SEL_	0x001F
#define P4REN_	0x0011
/************************************************************
* Timer A3
************************************************************/
#define TAIV_	0x012E
#define TACTL_	0x0160
#define TACCTL0_	0x0162
#define TACCTL1_	0x0164
#define TACCTL2_	0x0166
#define TAR_	0x0170
#define TACCR0_	0x0172
#define TACCR1_	0x0174
#define TACCR2_	0x0176
/************************************************************
* Timer B3
************************************************************/
#define TBIV_	0x011E
#define TBCTL_	0x0180
#define TBCCTL0_	0x0182
#define TBCCTL1_	0x0184
#define TBCCTL2_	0x0186
#define TBR_	0x0190
#define TBCCR0_	0x0192
#define TBCCR1_	0x0194
#define TBCCR2_	0x0196
/************************************************************
* USCI
************************************************************/
#define UCA0CTL0_	0x0060
#define UCA0CTL1_	0x0061
#define UCA0BR0_	0x0062
#define UCA0BR1_	0x0063
#define UCA0MCTL_	0x0064
#define UCA0STAT_	0x0065
#define UCA0RXBUF_	0x0066
#define UCA0TXBUF_	0x0067
#define UCA0ABCTL_	0x005D
#define UCA0IRTCTL_	0x005E
#define UCA0IRRCTL_	0x005F
#define UCB0CTL0_	0x0068
#define UCB0CTL1_	0x0069
#define UCB0BR0_	0x006A
#define UCB0BR1_	0x006B
#define UCB0I2CIE_	0x006C
#define UCB0STAT_	0x006D
#define UCB0RXBUF_	0x006E
#define UCB0TXBUF_	0x006F
#define UCB0I2COA_	0x0118
#define UCB0I2CSA_	0x011A
/************************************************************
* WATCHDOG TIMER
************************************************************/
#define WDTCTL_	0x0120
/************************************************************
* Calibration Data in Info Mem
************************************************************/
#define CALDCO_16MHZ_	0x10F8
#define CALBC1_16MHZ_	0x10F9
#define CALDCO_12MHZ_	0x10FA
#define CALBC1_12MHZ_	0x10FB
#define CALDCO_8MHZ_	0x10FC
#define CALBC1_8MHZ_	0x10FD
#define CALDCO_1MHZ_	0x10FE
#define CALBC1_1MHZ_	0x10FF
/************************************************************
* Interrupt Vectors (offset from 0xFFE0)
************************************************************/
/************************************************************
* End of Modules
************************************************************/
