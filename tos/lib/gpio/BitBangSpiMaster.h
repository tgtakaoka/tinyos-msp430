/* -*- mode: nesc; mode: flyspell-prog; -*- */
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

#ifndef BIT_BANG_SPI_MASTER_H
#define BIT_BANG_SPI_MASTER_H

#include "hardware.h"

#define BIT_BANG_SPI_MASTER_RESOURCE "BitBangSpiMaster"

typedef uint8_t bit_bang_spi_master_config_t;
#define BIT_BANG_SPI_MASTER_CLK_POLALITY_POSITIVE  (1 << 0)
#define BIT_BANG_SPI_MASTER_CLK_PHASE_LEADING_EDGE (1 << 1)
#define BIT_BANG_SPI_MASTER_BIT_BIG_ENDIAN         (1 << 2)
#define BIT_BANG_SPI_MASTER_DEFAULT_CONFIG (\
        BIT_BANG_SPI_MASTER_CLK_POLALITY_POSITIVE |\
        BIT_BANG_SPI_MASTER_CLK_PHASE_LEADING_EDGE |\
        BIT_BANG_SPI_MASTER_BIT_BIG_ENDIAN )

/**
 * When BIT_BANG_SPI_MASTER_SINGLE_CONFIG is defined, the symbol value
 * is used as a single configuration of BitBangSpiMasterP and
 * implementation will be drastically optimized.
 *
 * #define BIT_BANG_SPI_MASTER_SINGLE_CONFIG     \
 *    BIT_BANG_SPI_MASTER_DEFAULT_CONFIG
 *
 */

#endif
