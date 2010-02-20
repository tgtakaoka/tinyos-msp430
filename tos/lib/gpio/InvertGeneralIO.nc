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
