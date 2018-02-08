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

/* This file supports MSP430G2402 devices. */
/* Version: 1.203 */

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
* DIGITAL I/O Port1/2 Pull up / Pull down Resistors
************************************************************/
#define P1IN_	0x0020
#define P1OUT_	0x0021
#define P1DIR_	0x0022
#define P1IFG_	0x0023
#define P1IES_	0x0024
#define P1IE_	0x0025
#define P1SEL_	0x0026
#define P1SEL2_	0x0041
#define P1REN_	0x0027
#define P2IN_	0x0028
#define P2OUT_	0x0029
#define P2DIR_	0x002A
#define P2IFG_	0x002B
#define P2IES_	0x002C
#define P2IE_	0x002D
#define P2SEL_	0x002E
#define P2SEL2_	0x0042
#define P2REN_	0x002F
/************************************************************
* Timer0_A3
************************************************************/
#define TA0IV_	0x012E
#define TA0CTL_	0x0160
#define TA0CCTL0_	0x0162
#define TA0CCTL1_	0x0164
#define TA0CCTL2_	0x0166
#define TA0R_	0x0170
#define TA0CCR0_	0x0172
#define TA0CCR1_	0x0174
#define TA0CCR2_	0x0176
/************************************************************
* USI
************************************************************/
#define USICTL0_	0x0078
#define USICTL1_	0x0079
#define USICKCTL_	0x007A
#define USICNT_	0x007B
#define USISRL_	0x007C
#define USISRH_	0x007D
#define USICTL_	0x0078
#define USICCTL_	0x007A
#define USISR_	0x007C
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
* Calibration Data in Info Mem
************************************************************/
#define TLV_CHECKSUM_	0x10C0
#define TLV_DCO_30_TAG_	0x10F6
#define TLV_DCO_30_LEN_	0x10F7
#define TLV_ADC10_1_TAG_	0x10DA
#define TLV_ADC10_1_LEN_	0x10DB
/************************************************************
* Interrupt Vectors (offset from 0xFFE0)
************************************************************/
/************************************************************
* End of Modules
************************************************************/
