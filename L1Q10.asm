;	Microcontrolador PIC16F887
;
;	Loop infinito, piscando um LED conectado ao pino RA0 a cada 1 segundo.
;	
;	Criado por: Pedro Figueiredo.
;

		include <p16f887.inc>		;cabeçalho
		__config	_CONFIG1,	0X2FF4	;Configuration ou fuse bits
		__config	_CONFIG2,	0x3FFF	;configuration bits ou fuse bits

		cblock 		0x20
					L0
					L1
					L2
		endc
		
		org			0x000				;vetor de resete
		GOTO		SETUP
		org			0x004				;vetor de interrupção
		NOP								;não faz nada
		RETFIE

SETUP:
		BCF			STATUS, RP1			;SELECIONA BANK 01
		BSF			STATUS,	RP0
		BCF			TRISA, TRISA0		;CONFIGURA PORTA COMO SAÍDA DIGITAL
		BSF			STATUS, RP0
		BSF			STATUS, RP1
		BCF			ANSEL,	ANS0
		BCF			STATUS,	RP1			;SELECIONA BANK 00
		BCF			STATUS,	RP0
		GOTO		LOOP



LOOP:
		BSF			PORTA, RA0			;seta RD0
		CALL		FDELAY1S
		BCF			PORTA, RA0			;reseta RD0
		CALL		FDELAY1S
		GOTO 		LOOP				;pula para linha LOOP


FDELAY1S:
		MOVLW		.75
		MOVWF		L0
		MOVLW		.22
		MOVWF		L1
		MOVLW		.7
		MOVWF		L2

EXTERNO:
		DECFSZ		L2,F
		GOTO		INTERNO2
		GOTO		EXITDELAY

INTERNO2:
		DECFSZ		L1,F
		GOTO 		INTERNO1
		GOTO		EXTERNO

INTERNO1:
		DECFSZ		L0,F
		GOTO		$-1
		GOTO		INTERNO2

EXITDELAY:
		RETURN

		END