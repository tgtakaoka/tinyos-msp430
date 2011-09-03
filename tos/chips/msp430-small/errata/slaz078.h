/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2011, Tadashi G. Takaoka
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

#ifndef _H_slaz078_h
#define _H_slaz078_h

/* See SLAZ078 MSP430FR573x, MSP430FR572x Device Erratasheet, Revised April 2011 */

#if defined(__MSP430FR5720__) || defined(__MSP430FR5721__) || defined(__MSP430FR5722__) || \
    defined(__MSP430FR5723__) || defined(__MSP430FR5724__) || defined(__MSP430FR5725__) || \
    defined(__MSP430FR5726__) || defined(__MSP430FR5727__) || defined(__MSP430FR5728__) || \
    defined(__MSP430FR5729__) || \
    defined(__MSP430FR5730__) || defined(__MSP430FR5731__) || defined(__MSP430FR5732__) || \
    defined(__MSP430FR5733__) || defined(__MSP430FR5734__) || defined(__MSP430FR5735__) || \
    defined(__MSP430FR5736__) || defined(__MSP430FR5737__) || defined(__MSP430FR5738__) || \
    defined(__MSP430FR5739__) || \

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'D'"
#define __MSP430_REV__ 'D'
#endif

#if __MSP430_REV__ == 'D'
#define ERRATA_CPU40
#define ERRATA_EEM8
#define ERRATA_MPY1
#define ERRATA_SYS17
#define ERRATA_USCI30
#endif

#else
#error "This errata/slaz078.h is for MSP430FR573x/572x"
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
