
configuration HplMsp430I2C0C {
  
  provides interface HplMsp430I2C;
  
}

implementation {
  
  components HplMsp430I2C0P as HplI2CP;
  HplMsp430I2C = HplI2CP;
  
  components HplMsp430Usart0P as HplUsartP;
  HplUsartP.HplI2C -> HplI2CP;
  HplI2CP.HplUsart -> HplUsartP;
  
  components Msp430UsartConf;
  HplI2CP.SIMO -> Msp430UsartConf.SDA;
  HplI2CP.UCLK -> Msp430UsartConf.SCL;
  
}
