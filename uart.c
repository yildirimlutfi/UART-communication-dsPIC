#include "uart.h"

//MCU_RX-gray
//MCU_TX-yellow

char uartReadTemp;
unsigned char uartTxBuffer[100];
unsigned char uartRxBuffer[100];
unsigned uartCount=0;

void uartInitArduino()
{
     oscconbits.IOLOCK=0;   //unlock
     RPINR18bits.U1RXR=27;  //uart1 I RP2
     RPOR13bits.RP26R=3;     //uart1 O RP3
     UART1_Init(19200);      //uart baud rate ayarlandy
     U1BRG=28;//28
     UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle);
     IFS0bits.U1RXIF = 0;
     IEC0bits.U1RXIE=1;// UART1 Receiver Interrupt Enable bit
     oscconbits.IOLOCK=1;
}

void uartTxToArduino(char length ,char *uartData)
{
  unsigned i;

  for(i=0;i<length;i++)
  {
     UART1_Write(uartData[i]);
  }
}

void UART1RXInterrupt() iv IVT_ADDR_U1RXINTERRUPT
{
  if(UART1_Data_Ready())
  {
    uartRxBuffer[uartCount]=UART1_Read();
    
    uartCount++;
    if(uartCount>99)
    uartCount=0;
  }
  IFS0bits.U1RXIF = 0;
}