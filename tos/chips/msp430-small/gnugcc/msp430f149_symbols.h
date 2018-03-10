/* ============================================================================ */
/* Copyright (c) 2017, Texas Instruments Incorporated                           */
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

/* This file supports MSP430F149 devices. */
/* Version: 1.204 */

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
#define ME1_	0x0004
#define IE2_	0x0001
#define IFG2_	0x0003
#define ME2_	0x0005
/************************************************************
* WATCHDOG TIMER
************************************************************/
#define WDTCTL_	0x0120
/************************************************************
* HARDWARE MULTIPLIER
************************************************************/
#define MPY_	0x0130
#define MPYS_	0x0132
#define MAC_	0x0134
#define MACS_	0x0136
#define OP2_	0x0138
#define RESLO_	0x013A
#define RESHI_	0x013C
#define SUMEXT_	0x013E
/************************************************************
* DIGITAL I/O Port1/2
************************************************************/
#define P1IN_	0x0020
#define P1OUT_	0x0021
#define P1DIR_	0x0022
#define P1IFG_	0x0023
#define P1IES_	0x0024
#define P1IE_	0x0025
#define P1SEL_	0x0026
#define P2IN_	0x0028
#define P2OUT_	0x0029
#define P2DIR_	0x002A
#define P2IFG_	0x002B
#define P2IES_	0x002C
#define P2IE_	0x002D
#define P2SEL_	0x002E
/************************************************************
* DIGITAL I/O Port3/4
************************************************************/
#define P3IN_	0x0018
#define P3OUT_	0x0019
#define P3DIR_	0x001A
#define P3SEL_	0x001B
#define P4IN_	0x001C
#define P4OUT_	0x001D
#define P4DIR_	0x001E
#define P4SEL_	0x001F
/************************************************************
* DIGITAL I/O Port5/6
************************************************************/
#define P5IN_	0x0030
#define P5OUT_	0x0031
#define P5DIR_	0x0032
#define P5SEL_	0x0033
#define P6IN_	0x0034
#define P6OUT_	0x0035
#define P6DIR_	0x0036
#define P6SEL_	0x0037
/************************************************************
* USART
************************************************************/
/************************************************************
* USART 0
************************************************************/
#define U0CTL_	0x0070
#define U0TCTL_	0x0071
#define U0RCTL_	0x0072
#define U0MCTL_	0x0073
#define U0BR0_	0x0074
#define U0BR1_	0x0075
#define U0RXBUF_	0x0076
#define U0TXBUF_	0x0077
/************************************************************
* USART 1
************************************************************/
#define U1CTL_	0x0078
#define U1TCTL_	0x0079
#define U1RCTL_	0x007A
#define U1MCTL_	0x007B
#define U1BR0_	0x007C
#define U1BR1_	0x007D
#define U1RXBUF_	0x007E
#define U1TXBUF_	0x007F
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
* Timer B7
************************************************************/
#define TBIV_	0x011E
#define TBCTL_	0x0180
#define TBCCTL0_	0x0182
#define TBCCTL1_	0x0184
#define TBCCTL2_	0x0186
#define TBCCTL3_	0x0188
#define TBCCTL4_	0x018A
#define TBCCTL5_	0x018C
#define TBCCTL6_	0x018E
#define TBR_	0x0190
#define TBCCR0_	0x0192
#define TBCCR1_	0x0194
#define TBCCR2_	0x0196
#define TBCCR3_	0x0198
#define TBCCR4_	0x019A
#define TBCCR5_	0x019C
#define TBCCR6_	0x019E
/************************************************************
* Basic Clock Module
************************************************************/
#define DCOCTL_	0x0056
#define BCSCTL1_	0x0057
#define BCSCTL2_	0x0058
/*************************************************************
* Flash Memory
*************************************************************/
#define FCTL1_	0x0128
#define FCTL2_	0x012A
#define FCTL3_	0x012C
/************************************************************
* Comparator A
************************************************************/
#define CACTL1_	0x0059
#define CACTL2_	0x005A
#define CAPD_	0x005B
/************************************************************
* ADC12
************************************************************/
#define ADC12CTL0_	0x01A0
#define ADC12CTL1_	0x01A2
#define ADC12IFG_	0x01A4
#define ADC12IE_	0x01A6
#define ADC12IV_	0x01A8
#define ADC12MEM0_	0x0140
#define ADC12MEM1_	0x0142
#define ADC12MEM2_	0x0144
#define ADC12MEM3_	0x0146
#define ADC12MEM4_	0x0148
#define ADC12MEM5_	0x014A
#define ADC12MEM6_	0x014C
#define ADC12MEM7_	0x014E
#define ADC12MEM8_	0x0150
#define ADC12MEM9_	0x0152
#define ADC12MEM10_	0x0154
#define ADC12MEM11_	0x0156
#define ADC12MEM12_	0x0158
#define ADC12MEM13_	0x015A
#define ADC12MEM14_	0x015C
#define ADC12MEM15_	0x015E
#define ADC12MCTL0_	0x0080
#define ADC12MCTL1_	0x0081
#define ADC12MCTL2_	0x0082
#define ADC12MCTL3_	0x0083
#define ADC12MCTL4_	0x0084
#define ADC12MCTL5_	0x0085
#define ADC12MCTL6_	0x0086
#define ADC12MCTL7_	0x0087
#define ADC12MCTL8_	0x0088
#define ADC12MCTL9_	0x0089
#define ADC12MCTL10_	0x008A
#define ADC12MCTL11_	0x008B
#define ADC12MCTL12_	0x008C
#define ADC12MCTL13_	0x008D
#define ADC12MCTL14_	0x008E
#define ADC12MCTL15_	0x008F
/************************************************************
* Interrupt Vectors (offset from 0xFFE0)
************************************************************/
/************************************************************
* End of Modules
************************************************************/
