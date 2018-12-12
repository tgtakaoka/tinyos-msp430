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

/* This file supports MSP430F5438A devices. */
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
* ADC12 PLUS
************************************************************/
#define ADC12CTL0_	0x0700
#define ADC12CTL0_L_	0x0700
#define ADC12CTL0_H_	0x0701
#define ADC12CTL1_	0x0702
#define ADC12CTL1_L_	0x0702
#define ADC12CTL1_H_	0x0703
#define ADC12CTL2_	0x0704
#define ADC12CTL2_L_	0x0704
#define ADC12CTL2_H_	0x0705
#define ADC12IFG_	0x070A
#define ADC12IFG_L_	0x070A
#define ADC12IFG_H_	0x070B
#define ADC12IE_	0x070C
#define ADC12IE_L_	0x070C
#define ADC12IE_H_	0x070D
#define ADC12IV_	0x070E
#define ADC12IV_L_	0x070E
#define ADC12IV_H_	0x070F
#define ADC12MEM0_	0x0720
#define ADC12MEM0_L_	0x0720
#define ADC12MEM0_H_	0x0721
#define ADC12MEM1_	0x0722
#define ADC12MEM1_L_	0x0722
#define ADC12MEM1_H_	0x0723
#define ADC12MEM2_	0x0724
#define ADC12MEM2_L_	0x0724
#define ADC12MEM2_H_	0x0725
#define ADC12MEM3_	0x0726
#define ADC12MEM3_L_	0x0726
#define ADC12MEM3_H_	0x0727
#define ADC12MEM4_	0x0728
#define ADC12MEM4_L_	0x0728
#define ADC12MEM4_H_	0x0729
#define ADC12MEM5_	0x072A
#define ADC12MEM5_L_	0x072A
#define ADC12MEM5_H_	0x072B
#define ADC12MEM6_	0x072C
#define ADC12MEM6_L_	0x072C
#define ADC12MEM6_H_	0x072D
#define ADC12MEM7_	0x072E
#define ADC12MEM7_L_	0x072E
#define ADC12MEM7_H_	0x072F
#define ADC12MEM8_	0x0730
#define ADC12MEM8_L_	0x0730
#define ADC12MEM8_H_	0x0731
#define ADC12MEM9_	0x0732
#define ADC12MEM9_L_	0x0732
#define ADC12MEM9_H_	0x0733
#define ADC12MEM10_	0x0734
#define ADC12MEM10_L_	0x0734
#define ADC12MEM10_H_	0x0735
#define ADC12MEM11_	0x0736
#define ADC12MEM11_L_	0x0736
#define ADC12MEM11_H_	0x0737
#define ADC12MEM12_	0x0738
#define ADC12MEM12_L_	0x0738
#define ADC12MEM12_H_	0x0739
#define ADC12MEM13_	0x073A
#define ADC12MEM13_L_	0x073A
#define ADC12MEM13_H_	0x073B
#define ADC12MEM14_	0x073C
#define ADC12MEM14_L_	0x073C
#define ADC12MEM14_H_	0x073D
#define ADC12MEM15_	0x073E
#define ADC12MEM15_L_	0x073E
#define ADC12MEM15_H_	0x073F
#define ADC12MCTL0_	0x0710
#define ADC12MCTL1_	0x0711
#define ADC12MCTL2_	0x0712
#define ADC12MCTL3_	0x0713
#define ADC12MCTL4_	0x0714
#define ADC12MCTL5_	0x0715
#define ADC12MCTL6_	0x0716
#define ADC12MCTL7_	0x0717
#define ADC12MCTL8_	0x0718
#define ADC12MCTL9_	0x0719
#define ADC12MCTL10_	0x071A
#define ADC12MCTL11_	0x071B
#define ADC12MCTL12_	0x071C
#define ADC12MCTL13_	0x071D
#define ADC12MCTL14_	0x071E
#define ADC12MCTL15_	0x071F
/*************************************************************
* CRC Module
*************************************************************/
#define CRCDI_	0x0150
#define CRCDI_L_	0x0150
#define CRCDI_H_	0x0151
#define CRCDIRB_	0x0152
#define CRCDIRB_L_	0x0152
#define CRCDIRB_H_	0x0153
#define CRCINIRES_	0x0154
#define CRCINIRES_L_	0x0154
#define CRCINIRES_H_	0x0155
#define CRCRESR_	0x0156
#define CRCRESR_L_	0x0156
#define CRCRESR_H_	0x0157
/************************************************************
* DMA_X
************************************************************/
#define DMACTL0_	0x0500
#define DMACTL0_L_	0x0500
#define DMACTL0_H_	0x0501
#define DMACTL1_	0x0502
#define DMACTL1_L_	0x0502
#define DMACTL1_H_	0x0503
#define DMACTL2_	0x0504
#define DMACTL2_L_	0x0504
#define DMACTL2_H_	0x0505
#define DMACTL3_	0x0506
#define DMACTL3_L_	0x0506
#define DMACTL3_H_	0x0507
#define DMACTL4_	0x0508
#define DMACTL4_L_	0x0508
#define DMACTL4_H_	0x0509
#define DMAIV_	0x050E
#define DMAIV_L_	0x050E
#define DMAIV_H_	0x050F
#define DMA0CTL_	0x0510
#define DMA0CTL_L_	0x0510
#define DMA0CTL_H_	0x0511
#define DMA0SA_	0x0512
#define DMA0SAL_	0x0512
#define DMA0DA_	0x0516
#define DMA0DAL_	0x0516
#define DMA0SZ_	0x051A
#define DMA1CTL_	0x0520
#define DMA1CTL_L_	0x0520
#define DMA1CTL_H_	0x0521
#define DMA1SA_	0x0522
#define DMA1SAL_	0x0522
#define DMA1DA_	0x0526
#define DMA1DAL_	0x0526
#define DMA1SZ_	0x052A
#define DMA2CTL_	0x0530
#define DMA2CTL_L_	0x0530
#define DMA2CTL_H_	0x0531
#define DMA2SA_	0x0532
#define DMA2SAL_	0x0532
#define DMA2DA_	0x0536
#define DMA2DAL_	0x0536
#define DMA2SZ_	0x053A
/*************************************************************
* Flash Memory
*************************************************************/
#define FCTL1_	0x0140
#define FCTL1_L_	0x0140
#define FCTL1_H_	0x0141
#define FCTL3_	0x0144
#define FCTL3_L_	0x0144
#define FCTL3_H_	0x0145
#define FCTL4_	0x0146
#define FCTL4_L_	0x0146
#define FCTL4_H_	0x0147
/************************************************************
* HARDWARE MULTIPLIER 32Bit
************************************************************/
#define MPY_	0x04C0
#define MPY_L_	0x04C0
#define MPY_H_	0x04C1
#define MPYS_	0x04C2
#define MPYS_L_	0x04C2
#define MPYS_H_	0x04C3
#define MAC_	0x04C4
#define MAC_L_	0x04C4
#define MAC_H_	0x04C5
#define MACS_	0x04C6
#define MACS_L_	0x04C6
#define MACS_H_	0x04C7
#define OP2_	0x04C8
#define OP2_L_	0x04C8
#define OP2_H_	0x04C9
#define RESLO_	0x04CA
#define RESLO_L_	0x04CA
#define RESLO_H_	0x04CB
#define RESHI_	0x04CC
#define RESHI_L_	0x04CC
#define RESHI_H_	0x04CD
#define SUMEXT_	0x04CE
#define SUMEXT_L_	0x04CE
#define SUMEXT_H_	0x04CF
#define MPY32L_	0x04D0
#define MPY32L_L_	0x04D0
#define MPY32L_H_	0x04D1
#define MPY32H_	0x04D2
#define MPY32H_L_	0x04D2
#define MPY32H_H_	0x04D3
#define MPYS32L_	0x04D4
#define MPYS32L_L_	0x04D4
#define MPYS32L_H_	0x04D5
#define MPYS32H_	0x04D6
#define MPYS32H_L_	0x04D6
#define MPYS32H_H_	0x04D7
#define MAC32L_	0x04D8
#define MAC32L_L_	0x04D8
#define MAC32L_H_	0x04D9
#define MAC32H_	0x04DA
#define MAC32H_L_	0x04DA
#define MAC32H_H_	0x04DB
#define MACS32L_	0x04DC
#define MACS32L_L_	0x04DC
#define MACS32L_H_	0x04DD
#define MACS32H_	0x04DE
#define MACS32H_L_	0x04DE
#define MACS32H_H_	0x04DF
#define OP2L_	0x04E0
#define OP2L_L_	0x04E0
#define OP2L_H_	0x04E1
#define OP2H_	0x04E2
#define OP2H_L_	0x04E2
#define OP2H_H_	0x04E3
#define RES0_	0x04E4
#define RES0_L_	0x04E4
#define RES0_H_	0x04E5
#define RES1_	0x04E6
#define RES1_L_	0x04E6
#define RES1_H_	0x04E7
#define RES2_	0x04E8
#define RES2_L_	0x04E8
#define RES2_H_	0x04E9
#define RES3_	0x04EA
#define RES3_L_	0x04EA
#define RES3_H_	0x04EB
#define MPY32CTL0_	0x04EC
#define MPY32CTL0_L_	0x04EC
#define MPY32CTL0_H_	0x04ED
/************************************************************
* DIGITAL I/O Port1/2 Pull up / Pull down Resistors
************************************************************/
#define PAIN_	0x0200
#define PAIN_L_	0x0200
#define PAIN_H_	0x0201
#define PAOUT_	0x0202
#define PAOUT_L_	0x0202
#define PAOUT_H_	0x0203
#define PADIR_	0x0204
#define PADIR_L_	0x0204
#define PADIR_H_	0x0205
#define PAREN_	0x0206
#define PAREN_L_	0x0206
#define PAREN_H_	0x0207
#define PADS_	0x0208
#define PADS_L_	0x0208
#define PADS_H_	0x0209
#define PASEL_	0x020A
#define PASEL_L_	0x020A
#define PASEL_H_	0x020B
#define PAIES_	0x0218
#define PAIES_L_	0x0218
#define PAIES_H_	0x0219
#define PAIE_	0x021A
#define PAIE_L_	0x021A
#define PAIE_H_	0x021B
#define PAIFG_	0x021C
#define PAIFG_L_	0x021C
#define PAIFG_H_	0x021D
#define P1IV_	0x020E
#define P2IV_	0x021E
/************************************************************
* DIGITAL I/O Port3/4 Pull up / Pull down Resistors
************************************************************/
#define PBIN_	0x0220
#define PBIN_L_	0x0220
#define PBIN_H_	0x0221
#define PBOUT_	0x0222
#define PBOUT_L_	0x0222
#define PBOUT_H_	0x0223
#define PBDIR_	0x0224
#define PBDIR_L_	0x0224
#define PBDIR_H_	0x0225
#define PBREN_	0x0226
#define PBREN_L_	0x0226
#define PBREN_H_	0x0227
#define PBDS_	0x0228
#define PBDS_L_	0x0228
#define PBDS_H_	0x0229
#define PBSEL_	0x022A
#define PBSEL_L_	0x022A
#define PBSEL_H_	0x022B
/************************************************************
* DIGITAL I/O Port5/6 Pull up / Pull down Resistors
************************************************************/
#define PCIN_	0x0240
#define PCIN_L_	0x0240
#define PCIN_H_	0x0241
#define PCOUT_	0x0242
#define PCOUT_L_	0x0242
#define PCOUT_H_	0x0243
#define PCDIR_	0x0244
#define PCDIR_L_	0x0244
#define PCDIR_H_	0x0245
#define PCREN_	0x0246
#define PCREN_L_	0x0246
#define PCREN_H_	0x0247
#define PCDS_	0x0248
#define PCDS_L_	0x0248
#define PCDS_H_	0x0249
#define PCSEL_	0x024A
#define PCSEL_L_	0x024A
#define PCSEL_H_	0x024B
/************************************************************
* DIGITAL I/O Port7/8 Pull up / Pull down Resistors
************************************************************/
#define PDIN_	0x0260
#define PDIN_L_	0x0260
#define PDIN_H_	0x0261
#define PDOUT_	0x0262
#define PDOUT_L_	0x0262
#define PDOUT_H_	0x0263
#define PDDIR_	0x0264
#define PDDIR_L_	0x0264
#define PDDIR_H_	0x0265
#define PDREN_	0x0266
#define PDREN_L_	0x0266
#define PDREN_H_	0x0267
#define PDDS_	0x0268
#define PDDS_L_	0x0268
#define PDDS_H_	0x0269
#define PDSEL_	0x026A
#define PDSEL_L_	0x026A
#define PDSEL_H_	0x026B
/************************************************************
* DIGITAL I/O Port9/10 Pull up / Pull down Resistors
************************************************************/
#define PEIN_	0x0280
#define PEIN_L_	0x0280
#define PEIN_H_	0x0281
#define PEOUT_	0x0282
#define PEOUT_L_	0x0282
#define PEOUT_H_	0x0283
#define PEDIR_	0x0284
#define PEDIR_L_	0x0284
#define PEDIR_H_	0x0285
#define PEREN_	0x0286
#define PEREN_L_	0x0286
#define PEREN_H_	0x0287
#define PEDS_	0x0288
#define PEDS_L_	0x0288
#define PEDS_H_	0x0289
#define PESEL_	0x028A
#define PESEL_L_	0x028A
#define PESEL_H_	0x028B
/************************************************************
* DIGITAL I/O Port11 Pull up / Pull down Resistors
************************************************************/
#define PFIN_	0x02A0
#define PFIN_L_	0x02A0
#define PFIN_H_	0x02A1
#define PFOUT_	0x02A2
#define PFOUT_L_	0x02A2
#define PFOUT_H_	0x02A3
#define PFDIR_	0x02A4
#define PFDIR_L_	0x02A4
#define PFDIR_H_	0x02A5
#define PFREN_	0x02A6
#define PFREN_L_	0x02A6
#define PFREN_H_	0x02A7
#define PFDS_	0x02A8
#define PFDS_L_	0x02A8
#define PFDS_H_	0x02A9
#define PFSEL_	0x02AA
#define PFSEL_L_	0x02AA
#define PFSEL_H_	0x02AB
/************************************************************
* DIGITAL I/O PortJ Pull up / Pull down Resistors
************************************************************/
#define PJIN_	0x0320
#define PJIN_L_	0x0320
#define PJIN_H_	0x0321
#define PJOUT_	0x0322
#define PJOUT_L_	0x0322
#define PJOUT_H_	0x0323
#define PJDIR_	0x0324
#define PJDIR_L_	0x0324
#define PJDIR_H_	0x0325
#define PJREN_	0x0326
#define PJREN_L_	0x0326
#define PJREN_H_	0x0327
#define PJDS_	0x0328
#define PJDS_L_	0x0328
#define PJDS_H_	0x0329
/************************************************************
* PMM - Power Management System
************************************************************/
#define PMMCTL0_	0x0120
#define PMMCTL0_L_	0x0120
#define PMMCTL0_H_	0x0121
#define PMMCTL1_	0x0122
#define PMMCTL1_L_	0x0122
#define PMMCTL1_H_	0x0123
#define SVSMHCTL_	0x0124
#define SVSMHCTL_L_	0x0124
#define SVSMHCTL_H_	0x0125
#define SVSMLCTL_	0x0126
#define SVSMLCTL_L_	0x0126
#define SVSMLCTL_H_	0x0127
#define SVSMIO_	0x0128
#define SVSMIO_L_	0x0128
#define SVSMIO_H_	0x0129
#define PMMIFG_	0x012C
#define PMMIFG_L_	0x012C
#define PMMIFG_H_	0x012D
#define PMMRIE_	0x012E
#define PMMRIE_L_	0x012E
#define PMMRIE_H_	0x012F
#define PM5CTL0_	0x0130
#define PM5CTL0_L_	0x0130
#define PM5CTL0_H_	0x0131
/*************************************************************
* RAM Control Module
*************************************************************/
#define RCCTL0_	0x0158
#define RCCTL0_L_	0x0158
#define RCCTL0_H_	0x0159
/************************************************************
* Shared Reference
************************************************************/
#define REFCTL0_	0x01B0
#define REFCTL0_L_	0x01B0
#define REFCTL0_H_	0x01B1
/************************************************************
* Real Time Clock
************************************************************/
#define RTCCTL01_	0x04A0
#define RTCCTL01_L_	0x04A0
#define RTCCTL01_H_	0x04A1
#define RTCCTL23_	0x04A2
#define RTCCTL23_L_	0x04A2
#define RTCCTL23_H_	0x04A3
#define RTCPS0CTL_	0x04A8
#define RTCPS0CTL_L_	0x04A8
#define RTCPS0CTL_H_	0x04A9
#define RTCPS1CTL_	0x04AA
#define RTCPS1CTL_L_	0x04AA
#define RTCPS1CTL_H_	0x04AB
#define RTCPS_	0x04AC
#define RTCPS_L_	0x04AC
#define RTCPS_H_	0x04AD
#define RTCIV_	0x04AE
#define RTCTIM0_	0x04B0
#define RTCTIM0_L_	0x04B0
#define RTCTIM0_H_	0x04B1
#define RTCTIM1_	0x04B2
#define RTCTIM1_L_	0x04B2
#define RTCTIM1_H_	0x04B3
#define RTCDATE_	0x04B4
#define RTCDATE_L_	0x04B4
#define RTCDATE_H_	0x04B5
#define RTCYEAR_	0x04B6
#define RTCYEAR_L_	0x04B6
#define RTCYEAR_H_	0x04B7
#define RTCAMINHR_	0x04B8
#define RTCAMINHR_L_	0x04B8
#define RTCAMINHR_H_	0x04B9
#define RTCADOWDAY_	0x04BA
#define RTCADOWDAY_L_	0x04BA
#define RTCADOWDAY_H_	0x04BB
/************************************************************
* SFR - Special Function Register Module
************************************************************/
#define SFRIE1_	0x0100
#define SFRIE1_L_	0x0100
#define SFRIE1_H_	0x0101
#define SFRIFG1_	0x0102
#define SFRIFG1_L_	0x0102
#define SFRIFG1_H_	0x0103
#define SFRRPCR_	0x0104
#define SFRRPCR_L_	0x0104
#define SFRRPCR_H_	0x0105
/************************************************************
* SYS - System Module
************************************************************/
#define SYSCTL_	0x0180
#define SYSCTL_L_	0x0180
#define SYSCTL_H_	0x0181
#define SYSBSLC_	0x0182
#define SYSBSLC_L_	0x0182
#define SYSBSLC_H_	0x0183
#define SYSJMBC_	0x0186
#define SYSJMBC_L_	0x0186
#define SYSJMBC_H_	0x0187
#define SYSJMBI0_	0x0188
#define SYSJMBI0_L_	0x0188
#define SYSJMBI0_H_	0x0189
#define SYSJMBI1_	0x018A
#define SYSJMBI1_L_	0x018A
#define SYSJMBI1_H_	0x018B
#define SYSJMBO0_	0x018C
#define SYSJMBO0_L_	0x018C
#define SYSJMBO0_H_	0x018D
#define SYSJMBO1_	0x018E
#define SYSJMBO1_L_	0x018E
#define SYSJMBO1_H_	0x018F
#define SYSBERRIV_	0x0198
#define SYSBERRIV_L_	0x0198
#define SYSBERRIV_H_	0x0199
#define SYSUNIV_	0x019A
#define SYSUNIV_L_	0x019A
#define SYSUNIV_H_	0x019B
#define SYSSNIV_	0x019C
#define SYSSNIV_L_	0x019C
#define SYSSNIV_H_	0x019D
#define SYSRSTIV_	0x019E
#define SYSRSTIV_L_	0x019E
#define SYSRSTIV_H_	0x019F
/************************************************************
* Timer0_A5
************************************************************/
#define TA0CTL_	0x0340
#define TA0CCTL0_	0x0342
#define TA0CCTL1_	0x0344
#define TA0CCTL2_	0x0346
#define TA0CCTL3_	0x0348
#define TA0CCTL4_	0x034A
#define TA0R_	0x0350
#define TA0CCR0_	0x0352
#define TA0CCR1_	0x0354
#define TA0CCR2_	0x0356
#define TA0CCR3_	0x0358
#define TA0CCR4_	0x035A
#define TA0IV_	0x036E
#define TA0EX0_	0x0360
/************************************************************
* Timer1_A3
************************************************************/
#define TA1CTL_	0x0380
#define TA1CCTL0_	0x0382
#define TA1CCTL1_	0x0384
#define TA1CCTL2_	0x0386
#define TA1R_	0x0390
#define TA1CCR0_	0x0392
#define TA1CCR1_	0x0394
#define TA1CCR2_	0x0396
#define TA1IV_	0x03AE
#define TA1EX0_	0x03A0
/************************************************************
* Timer0_B7
************************************************************/
#define TB0CTL_	0x03C0
#define TB0CCTL0_	0x03C2
#define TB0CCTL1_	0x03C4
#define TB0CCTL2_	0x03C6
#define TB0CCTL3_	0x03C8
#define TB0CCTL4_	0x03CA
#define TB0CCTL5_	0x03CC
#define TB0CCTL6_	0x03CE
#define TB0R_	0x03D0
#define TB0CCR0_	0x03D2
#define TB0CCR1_	0x03D4
#define TB0CCR2_	0x03D6
#define TB0CCR3_	0x03D8
#define TB0CCR4_	0x03DA
#define TB0CCR5_	0x03DC
#define TB0CCR6_	0x03DE
#define TB0EX0_	0x03E0
#define TB0IV_	0x03EE
/************************************************************
* UNIFIED CLOCK SYSTEM
************************************************************/
#define UCSCTL0_	0x0160
#define UCSCTL0_L_	0x0160
#define UCSCTL0_H_	0x0161
#define UCSCTL1_	0x0162
#define UCSCTL1_L_	0x0162
#define UCSCTL1_H_	0x0163
#define UCSCTL2_	0x0164
#define UCSCTL2_L_	0x0164
#define UCSCTL2_H_	0x0165
#define UCSCTL3_	0x0166
#define UCSCTL3_L_	0x0166
#define UCSCTL3_H_	0x0167
#define UCSCTL4_	0x0168
#define UCSCTL4_L_	0x0168
#define UCSCTL4_H_	0x0169
#define UCSCTL5_	0x016A
#define UCSCTL5_L_	0x016A
#define UCSCTL5_H_	0x016B
#define UCSCTL6_	0x016C
#define UCSCTL6_L_	0x016C
#define UCSCTL6_H_	0x016D
#define UCSCTL7_	0x016E
#define UCSCTL7_L_	0x016E
#define UCSCTL7_H_	0x016F
#define UCSCTL8_	0x0170
#define UCSCTL8_L_	0x0170
#define UCSCTL8_H_	0x0171
/************************************************************
* USCI A0
************************************************************/
#define UCA0CTLW0_	0x05C0
#define UCA0CTLW0_L_	0x05C0
#define UCA0CTLW0_H_	0x05C1
#define UCA0BRW_	0x05C6
#define UCA0BRW_L_	0x05C6
#define UCA0BRW_H_	0x05C7
#define UCA0MCTL_	0x05C8
#define UCA0STAT_	0x05CA
#define UCA0RXBUF_	0x05CC
#define UCA0TXBUF_	0x05CE
#define UCA0ABCTL_	0x05D0
#define UCA0IRCTL_	0x05D2
#define UCA0IRCTL_L_	0x05D2
#define UCA0IRCTL_H_	0x05D3
#define UCA0ICTL_	0x05DC
#define UCA0ICTL_L_	0x05DC
#define UCA0ICTL_H_	0x05DD
#define UCA0IV_	0x05DE
/************************************************************
* USCI B0
************************************************************/
#define UCB0CTLW0_	0x05E0
#define UCB0CTLW0_L_	0x05E0
#define UCB0CTLW0_H_	0x05E1
#define UCB0BRW_	0x05E6
#define UCB0BRW_L_	0x05E6
#define UCB0BRW_H_	0x05E7
#define UCB0STAT_	0x05EA
#define UCB0RXBUF_	0x05EC
#define UCB0TXBUF_	0x05EE
#define UCB0I2COA_	0x05F0
#define UCB0I2COA_L_	0x05F0
#define UCB0I2COA_H_	0x05F1
#define UCB0I2CSA_	0x05F2
#define UCB0I2CSA_L_	0x05F2
#define UCB0I2CSA_H_	0x05F3
#define UCB0ICTL_	0x05FC
#define UCB0ICTL_L_	0x05FC
#define UCB0ICTL_H_	0x05FD
#define UCB0IV_	0x05FE
/************************************************************
* USCI A1
************************************************************/
#define UCA1CTLW0_	0x0600
#define UCA1CTLW0_L_	0x0600
#define UCA1CTLW0_H_	0x0601
#define UCA1BRW_	0x0606
#define UCA1BRW_L_	0x0606
#define UCA1BRW_H_	0x0607
#define UCA1MCTL_	0x0608
#define UCA1STAT_	0x060A
#define UCA1RXBUF_	0x060C
#define UCA1TXBUF_	0x060E
#define UCA1ABCTL_	0x0610
#define UCA1IRCTL_	0x0612
#define UCA1IRCTL_L_	0x0612
#define UCA1IRCTL_H_	0x0613
#define UCA1ICTL_	0x061C
#define UCA1ICTL_L_	0x061C
#define UCA1ICTL_H_	0x061D
#define UCA1IV_	0x061E
/************************************************************
* USCI B1
************************************************************/
#define UCB1CTLW0_	0x0620
#define UCB1CTLW0_L_	0x0620
#define UCB1CTLW0_H_	0x0621
#define UCB1BRW_	0x0626
#define UCB1BRW_L_	0x0626
#define UCB1BRW_H_	0x0627
#define UCB1STAT_	0x062A
#define UCB1RXBUF_	0x062C
#define UCB1TXBUF_	0x062E
#define UCB1I2COA_	0x0630
#define UCB1I2COA_L_	0x0630
#define UCB1I2COA_H_	0x0631
#define UCB1I2CSA_	0x0632
#define UCB1I2CSA_L_	0x0632
#define UCB1I2CSA_H_	0x0633
#define UCB1ICTL_	0x063C
#define UCB1ICTL_L_	0x063C
#define UCB1ICTL_H_	0x063D
#define UCB1IV_	0x063E
/************************************************************
* USCI A2
************************************************************/
#define UCA2CTLW0_	0x0640
#define UCA2CTLW0_L_	0x0640
#define UCA2CTLW0_H_	0x0641
#define UCA2BRW_	0x0646
#define UCA2BRW_L_	0x0646
#define UCA2BRW_H_	0x0647
#define UCA2MCTL_	0x0648
#define UCA2STAT_	0x064A
#define UCA2RXBUF_	0x064C
#define UCA2TXBUF_	0x064E
#define UCA2ABCTL_	0x0650
#define UCA2IRCTL_	0x0652
#define UCA2IRCTL_L_	0x0652
#define UCA2IRCTL_H_	0x0653
#define UCA2ICTL_	0x065C
#define UCA2ICTL_L_	0x065C
#define UCA2ICTL_H_	0x065D
#define UCA2IV_	0x065E
/************************************************************
* USCI B2
************************************************************/
#define UCB2CTLW0_	0x0660
#define UCB2CTLW0_L_	0x0660
#define UCB2CTLW0_H_	0x0661
#define UCB2BRW_	0x0666
#define UCB2BRW_L_	0x0666
#define UCB2BRW_H_	0x0667
#define UCB2STAT_	0x066A
#define UCB2RXBUF_	0x066C
#define UCB2TXBUF_	0x066E
#define UCB2I2COA_	0x0670
#define UCB2I2COA_L_	0x0670
#define UCB2I2COA_H_	0x0671
#define UCB2I2CSA_	0x0672
#define UCB2I2CSA_L_	0x0672
#define UCB2I2CSA_H_	0x0673
#define UCB2ICTL_	0x067C
#define UCB2ICTL_L_	0x067C
#define UCB2ICTL_H_	0x067D
#define UCB2IV_	0x067E
/************************************************************
* USCI A3
************************************************************/
#define UCA3CTLW0_	0x0680
#define UCA3CTLW0_L_	0x0680
#define UCA3CTLW0_H_	0x0681
#define UCA3BRW_	0x0686
#define UCA3BRW_L_	0x0686
#define UCA3BRW_H_	0x0687
#define UCA3MCTL_	0x0688
#define UCA3STAT_	0x068A
#define UCA3RXBUF_	0x068C
#define UCA3TXBUF_	0x068E
#define UCA3ABCTL_	0x0690
#define UCA3IRCTL_	0x0692
#define UCA3IRCTL_L_	0x0692
#define UCA3IRCTL_H_	0x0693
#define UCA3ICTL_	0x069C
#define UCA3ICTL_L_	0x069C
#define UCA3ICTL_H_	0x069D
#define UCA3IV_	0x069E
/************************************************************
* USCI B3
************************************************************/
#define UCB3CTLW0_	0x06A0
#define UCB3CTLW0_L_	0x06A0
#define UCB3CTLW0_H_	0x06A1
#define UCB3BRW_	0x06A6
#define UCB3BRW_L_	0x06A6
#define UCB3BRW_H_	0x06A7
#define UCB3STAT_	0x06AA
#define UCB3RXBUF_	0x06AC
#define UCB3TXBUF_	0x06AE
#define UCB3I2COA_	0x06B0
#define UCB3I2COA_L_	0x06B0
#define UCB3I2COA_H_	0x06B1
#define UCB3I2CSA_	0x06B2
#define UCB3I2CSA_L_	0x06B2
#define UCB3I2CSA_H_	0x06B3
#define UCB3ICTL_	0x06BC
#define UCB3ICTL_L_	0x06BC
#define UCB3ICTL_H_	0x06BD
#define UCB3IV_	0x06BE
/************************************************************
* WATCHDOG TIMER A
************************************************************/
#define WDTCTL_	0x015C
#define WDTCTL_L_	0x015C
#define WDTCTL_H_	0x015D
/************************************************************
* TLV Descriptors
************************************************************/
/************************************************************
* Interrupt Vectors (offset from 0xFF80)
************************************************************/
/************************************************************
* End of Modules
************************************************************/
