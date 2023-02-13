
_uartInitArduino:
	LNK	#0

;uart.c,11 :: 		void uartInitArduino()
;uart.c,13 :: 		oscconbits.IOLOCK=0;   //unlock
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	BCLR.B	OSCCONbits, #6
;uart.c,14 :: 		RPINR18bits.U1RXR=27;  //uart1 I RP2
	MOV.B	#27, W0
	MOV.B	W0, W1
	MOV	#lo_addr(RPINR18bits), W0
	XOR.B	W1, [W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(RPINR18bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(RPINR18bits), W0
	MOV.B	W1, [W0]
;uart.c,15 :: 		RPOR13bits.RP26R=3;     //uart1 O RP3
	MOV.B	#3, W0
	MOV.B	W0, W1
	MOV	#lo_addr(RPOR13bits), W0
	XOR.B	W1, [W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(RPOR13bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(RPOR13bits), W0
	MOV.B	W1, [W0]
;uart.c,16 :: 		UART1_Init(19200);      //uart baud rate ayarlandy
	MOV	#19200, W10
	MOV	#0, W11
	CALL	_UART1_Init
;uart.c,17 :: 		U1BRG=28;//28
	MOV	#28, W0
	MOV	WREG, U1BRG
;uart.c,18 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle);
	MOV	#lo_addr(_UART1_Tx_Idle), W13
	MOV	#lo_addr(_UART1_Data_Ready), W12
	MOV	#lo_addr(_UART1_Write), W11
	MOV	#lo_addr(_UART1_Read), W10
	CALL	_UART_Set_Active
;uart.c,19 :: 		IFS0bits.U1RXIF = 0;
	BCLR	IFS0bits, #11
;uart.c,20 :: 		IEC0bits.U1RXIE=1;// UART1 Receiver Interrupt Enable bit
	BSET	IEC0bits, #11
;uart.c,21 :: 		oscconbits.IOLOCK=1;
	BSET.B	OSCCONbits, #6
;uart.c,22 :: 		}
L_end_uartInitArduino:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _uartInitArduino

_uartTxToArduino:
	LNK	#0

;uart.c,24 :: 		void uartTxToArduino(char length ,char *uartData)
;uart.c,28 :: 		for(i=0;i<length;i++)
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
L_uartTxToArduino0:
; i start address is: 2 (W1)
	ZE	W10, W0
	CP	W1, W0
	BRA LTU	L__uartTxToArduino7
	GOTO	L_uartTxToArduino1
L__uartTxToArduino7:
;uart.c,30 :: 		UART1_Write(uartData[i]);
	ADD	W11, W1, W0
	PUSH	W10
	ZE	[W0], W10
	CALL	_UART1_Write
	POP	W10
;uart.c,28 :: 		for(i=0;i<length;i++)
	INC	W1
;uart.c,31 :: 		}
; i end address is: 2 (W1)
	GOTO	L_uartTxToArduino0
L_uartTxToArduino1:
;uart.c,32 :: 		}
L_end_uartTxToArduino:
	ULNK
	RETURN
; end of _uartTxToArduino

_UART1RXInterrupt:
	LNK	#2
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;uart.c,34 :: 		void UART1RXInterrupt() iv IVT_ADDR_U1RXINTERRUPT
;uart.c,36 :: 		if(UART1_Data_Ready())
	CALL	_UART1_Data_Ready
	CP0	W0
	BRA NZ	L__UART1RXInterrupt9
	GOTO	L_UART1RXInterrupt3
L__UART1RXInterrupt9:
;uart.c,38 :: 		uartRxBuffer[uartCount]=UART1_Read();
	MOV	#lo_addr(_uartRxBuffer), W1
	MOV	#lo_addr(_uartCount), W0
	ADD	W1, [W0], W0
	MOV	W0, [W14+0]
	CALL	_UART1_Read
	MOV	[W14+0], W1
	MOV.B	W0, [W1]
;uart.c,40 :: 		uartCount++;
	MOV	#1, W1
	MOV	#lo_addr(_uartCount), W0
	ADD	W1, [W0], [W0]
;uart.c,41 :: 		if(uartCount>99)
	MOV	#99, W1
	MOV	#lo_addr(_uartCount), W0
	CP	W1, [W0]
	BRA LTU	L__UART1RXInterrupt10
	GOTO	L_UART1RXInterrupt4
L__UART1RXInterrupt10:
;uart.c,42 :: 		uartCount=0;
	CLR	W0
	MOV	W0, _uartCount
L_UART1RXInterrupt4:
;uart.c,43 :: 		}
L_UART1RXInterrupt3:
;uart.c,44 :: 		IFS0bits.U1RXIF = 0;
	BCLR	IFS0bits, #11
;uart.c,45 :: 		}
L_end_UART1RXInterrupt:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _UART1RXInterrupt
