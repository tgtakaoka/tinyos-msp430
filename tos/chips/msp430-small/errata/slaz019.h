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

#ifndef _H_slaz019_h
#define _H_slaz019_h

/* See SLAZ019A MSP430x11x1(A) Device Erratasheet, Revised September 2010 */

#if defined(__MSP430C1101__) || defined(__MSP430C1111__) || defined(__MSP430C1121__) || \
    defined(__MSP430F1101__) || defined(__MSP430F1111__) || defined(__MSP430F1121__)
#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'H'"
#define __MSP430_REV__ 'H'
#endif
#if __MSP430_REV__ == 'H' || __MSP430_REV__ == 'I' || __MSP430_REV__ == 'J'
#define ERRATA_BCL5
#define ERRATA_CPU4
#define ERRATA_PORT3
#define ERRATA_RES4
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TA22
#if defined(__MSP430F1101__) || defined(__MSP430F1111__) || defined(__MSP430F1121__)
#define ERRATA_BSL5
#define ERRATA_WDG2
#endif
#endif

#else
#error "This errata/slaz019.h is for MSP430x11x1(A)"
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
