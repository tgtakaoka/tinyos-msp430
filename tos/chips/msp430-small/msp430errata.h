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

#ifndef _H_msp430errata_h
#define _H_msp430errata_h

#if defined(__MSP430F1121__)
#include "errata/slaz019.h"

#elif defined(__MSP430F1132__)
#include "errata/slaz129.h"

#elif defined(__MSP430F1232__)
#include "errata/slaz133.h"

#elif defined(__MSP430F1611__)
#include "errata/slaz146.h"

#elif defined(__MSP430F2012__)
#include "errata/slaz155.h"

#elif defined(__MSP430F2013__)
#include "errata/slaz156.h"

#elif defined(__MSP430F2131__)
#include "errata/slaz162.h"

#elif defined(__MSP430F2132__)
#include "errata/slaz163.h"

#elif defined(__MSP430F2274__)
#include "errata/slaz169.h"

#elif defined(__MSP430F2418__)
#include "errata/slaz178.h"

#elif defined(__MSP430F2617__)
#include "errata/slaz187.h"

#elif defined(__MSP430F2618__)
#include "errata/slaz188.h"

#elif defined(__MSP430F4270__)
#include "errata/slaz202.h"

#elif defined(__MSP430F5172__)
#include "errata/slaz251.h"

#elif defined(__MSP430F5310__)
#include "errata/slaz267.h"

#elif defined(__MSP430F5510__)
#include "errata/slaz301.h"

#elif defined(__MSP430FR5739__)
#include "errata/slaz392.h"

#elif defined(__MSP430G2211__)
#include "errata/slaz413.h"

#elif defined(__MSP430G2231__)
#include "errata/slaz417.h"

#elif defined(__MSP430G2402__)
#include "errata/slaz430.h"

#elif defined(__MSP430G2452__)
#include "errata/slaz436.h"

#elif defined(__MSP430G2553__)
#include "errata/slaz440.h"

#else
#error "Couldn't find a errata for the specified device"

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
