/* -*- mode: c; mode: flyspell-prog; -*- */
/* Copyright (c) 2013, Tadashi G. Takaoka
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

#ifndef _H_slaz251_h
#define _H_slaz251_h

/* See SLAZ251G MSP430F5172 Device Erratasheet, Revised July 2013 */

#if defined(__MSP430F5172__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'C'"
#define __MSP430_REV__ 'C'
#endif

#if __MSP430_REV__ == 'C'
#define ERRATA_BSL7
#define ERRATA_CPU40
#define ERRATA_CPU43
#define ERRATA_DMA4
#define ERRATA_DMA10
#define ERRATA_EEM11
#define ERRATA_EEM17
#define ERRATA_EEM19
#define ERRATA_EEM21
#define ERRATA_EEM23
#define ERRATA_PMM14
#define ERRATA_PMM15
#define ERRATA_PMM18
#define ERRATA_PMM20
#define ERRATA_PORT15
#define ERRATA_PORT19
#define ERRATA_PORT21
#define ERRATA_SYS12
#define ERRATA_SYS16
#define ERRATA_TD1
#define ERRATA_UCS9
#define ERRATA_UCS11
#define ERRATA_USCI26
#define ERRATA_USCI31
#define ERRATA_USCI35
#endif

#else
#error "This errata/slaz251.h is for MSP430F5172"
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
