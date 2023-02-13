#line 1 "C:/Users/lutfi yildirim/Desktop/uart/uart.c"
#line 1 "c:/users/lutfi yildirim/desktop/uart/uart.h"
void void uartInitArduino();
void uartTxToArduino(char length ,char *uartData);
#line 6 "C:/Users/lutfi yildirim/Desktop/uart/uart.c"
char uartReadTemp;
unsigned char uartTxBuffer[100];
unsigned char uartRxBuffer[100];
unsigned uartCount=0;

void uartInitArduino()
{
 oscconbits.IOLOCK=0;
 RPINR18bits.U1RXR=27;
 RPOR13bits.RP26R=3;
 UART1_Init(19200);
 U1BRG=28;
 UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle);
 IFS0bits.U1RXIF = 0;
 IEC0bits.U1RXIE=1;
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
