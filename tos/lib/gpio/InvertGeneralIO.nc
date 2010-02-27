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

generic module InvertGeneralIO()
{
    provides interface GeneralIO;
    uses interface GeneralIO as Impl;
}
implementation
{
    async command void GeneralIO.set() {
        call Impl.clr();
    }
    async command void GeneralIO.clr() {
        call Impl.set();
    }
    async command void GeneralIO.toggle() {
        call Impl.toggle();
    }
    async command bool GeneralIO.get() {
        return !(call Impl.get());
    }
    async command void GeneralIO.makeInput() {
        call Impl.makeInput();
    }
    async command bool GeneralIO.isInput() {
        return call Impl.isInput();
    }
    async command void GeneralIO.makeOutput() {
        call Impl.makeOutput();
    }
    async command bool GeneralIO.isOutput() {
        return call Impl.isOutput();
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
