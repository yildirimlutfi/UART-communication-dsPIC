
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#0

;main.c,7 :: 		void main()
;main.c,9 :: 		uartInitArduino();
	PUSH	W10
	PUSH	W11
	CALL	_uartInitArduino
;main.c,10 :: 		for(i=0;i<100;i++)
	CLR	W0
	MOV	W0, _i
L_main0:
	MOV	#100, W1
	MOV	#lo_addr(_i), W0
	CP	W1, [W0]
	BRA GTU	L__main8
	GOTO	L_main1
L__main8:
;main.c,11 :: 		uartTxBuffer[i]=i+70;
	MOV	#lo_addr(_uartTxBuffer), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W2
	MOV	#70, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	W0, [W2]
;main.c,10 :: 		for(i=0;i<100;i++)
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;main.c,11 :: 		uartTxBuffer[i]=i+70;
	GOTO	L_main0
L_main1:
;main.c,12 :: 		while(1)
L_main3:
;main.c,14 :: 		uartTxToArduino(5,uartTxBuffer);
	MOV	#lo_addr(_uartTxBuffer), W11
	MOV.B	#5, W10
	CALL	_uartTxToArduino
;main.c,15 :: 		Delay_ms(3000);
	MOV	#62, W8
	MOV	#2323, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	DEC	W8
	BRA NZ	L_main5
	NOP
;main.c,16 :: 		}
	GOTO	L_main3
;main.c,18 :: 		}
L_end_main:
	POP	W11
	POP	W10
	ULNK
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
