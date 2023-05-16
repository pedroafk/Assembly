;	Microcontrolador PIC16F887
;
;	Verifica se ‘VAR1’ é igual a 5, se for, salte para o rótulo com o nome ‘IGUAL’, caso contrário, continue a execução do programa.
;	
;	Criado por: Pedro Figueiredo.
;

		include <p16f887.inc>		;	cabeçalho
		__config	_CONFIG1,	0X2FF4	;Configuration ou fuse bits
		__config	_CONFIG2,	0x3FFF	;configuration bits ou fuse bits

		cblock 		0x20
					VAR1
		endc
		
		org			0x000				;VETOR DE RESETE
		GOTO		MAIN

		org			0x004				;VETOR DE INTERRUPÇÃO
		RETFIE							;RETORNA DA INTERRUPÇÃO

MAIN:
		CLRF		VAR1				;LIMPA VARIÁVEL
		MOVLW		D'5'
		MOVWF		VAR1
		MOVLW		D'5'
		SUBWF		VAR1,F

		BTFSC		STATUS,Z			;SE F-W = 0 -> Z=1 -> Z != C
		GOTO		IGUAL				;ENTÃO
					
		GOTO		MAIN				;SENAO

IGUAL:
		MOVLW		D'22'
		MOVWF		VAR1
		GOTO		MAIN
		
		END