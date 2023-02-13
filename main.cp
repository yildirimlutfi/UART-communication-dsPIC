#line 1 "C:/Users/lutfi yildirim/Desktop/uart/main.c"
#line 1 "c:/users/lutfi yildirim/desktop/uart/timer.h"
void Timer1Interrupt(void);
void init_timer();
unsigned long millis(void);
#line 1 "c:/users/lutfi yildirim/desktop/uart/uart.h"
void void uartInitArduino();
void uartTxToArduino(char length ,char *uartData);
#line 4 "C:/Users/lutfi yildirim/Desktop/uart/main.c"
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
