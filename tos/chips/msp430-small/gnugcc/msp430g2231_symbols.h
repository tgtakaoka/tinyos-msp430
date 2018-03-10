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

/* This file supports MSP430G2231 devices. */
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
/************************************************************
* ADC10
************************************************************/
#define ADC10DTC0_	0x0048
#define ADC10DTC1_	0x0049
#define ADC10AE0_	0x004A
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
* Timer A2
************************************************************/
#define TAIV_	0x012E
#define TACTL_	0x0160
#define TACCTL0_	0x0162
#define TACCTL1_	0x0164
#define TAR_	0x0170
#define TACCR0_	0x0172
#define TACCR1_	0x0174
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
#define CALDCO_1MHZ_	0x10FE
#define CALBC1_1MHZ_	0x10FF
/************************************************************
* Interrupt Vectors (offset from 0xFFE0)
************************************************************/
/************************************************************
* End of Modules
************************************************************/
