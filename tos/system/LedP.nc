/* -*- mode: nesc; mode: flyspell-prog; -*- */
/*
 * Copyright (C) 2010 Tadashi G. Takaoka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module LedP @safe() {
    provides interface Init;
    provides interface Led;
    uses interface GeneralIO as Out;
}
implementation {
    command error_t Init.init() {
        atomic {
            call Out.clr();
            call Out.makeOutput();
        }
        return SUCCESS;
    }

    async command void Led.on() {
        call Out.set();
    }

    async command void Led.off() {
        call Out.clr();
    }

    async command void Led.toggle() {
        call Out.toggle();
    }

    async command bool Led.get() {
        return call Out.get();
    }

    async command void Led.set(bool val) {
        if (val) {
            call Led.on();
        } else {
            call Led.off();
        }
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
