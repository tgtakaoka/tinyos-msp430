/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2010, Tadashi G. Takaoka
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of Tadashi G. Takaoka nor the names of its
 *   contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef _H_slaz061_h
#define _H_slaz061_h

/* See SLAZ061B MSP430G2x01, G2x11, G2x21, G2x31 Device Erratasheet, Revised December 2010 */

#if defined(__MSP430G2001__) || defined(__MSP430G2101__) || defined(__MSP430G2201__) || \
    defined(__MSP430G2111__) || defined(__MSP430G2211__) || \
    defined(__MSP430G2121__) || defined(__MSP430G2221__) || \
    defined(__MSP430G2131__) || defined(__MSP430G2231__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'D'"
#define __MSP430_REV__ 'D'
#endif
#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E'
#define ERRATA_BCL12
#define ERRATA_CPU4
#define ERRATA_FLASH16
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#if defined(__MSP430G2121__) || defined(__MSP430G2221__) || \
    defined(__MSP430G2131__) || defined(__MSP430G2231__)
#define ERRATA_USI4
#define ERRATA_USI5
#endif
#define ERRATA_XOSC5
#define ERRATA_XOSC8
#endif

#else
#error "This errata/slaz061.h is for MSP430G2x01/G2x11/G2x21/G2x31"
#endif

#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
