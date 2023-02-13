#include "timer.h"
#include "uart.h"

unsigned i;
extern unsigned char uartTxBuffer[100];

void main() 
{    
     uartInitArduino();
     for(i=0;i<100;i++)
     uartTxBuffer[i]=i+70;
  while(1)
  {
      uartTxToArduino(5,uartTxBuffer);
      Delay_ms(3000);
  }

}