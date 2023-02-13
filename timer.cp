#line 1 "C:/Users/lutfi yildirim/Desktop/uart/timer.c"

unsigned long millis_count=0;
bit has_updated;

void Timer1Interrupt() iv IVT_ADDR_T1INTERRUPT{
 if(IFS0bits.T1IF==1)
 {
 millis_count++;
 has_updated = 1;
 T1IF_bit=0;
 }
}

void init_timer()
{

 T1CON = 0x8020;
 T1IE_bit = 1;
 T1IF_bit = 0;
 IPC0 = IPC0 | 0x1000;
 PR1 = 25000;
}

unsigned long millis(void)
{
 unsigned long temp;
 do {
 has_updated = 0;
 temp = millis_count;
 } while (has_updated);
 return temp;
}
