;	Microcontrolador PIC16F887
;
;	Verifica se �VAR1� � igual a 5, se for, salte para o r�tulo com o nome �IGUAL�, caso contr�rio, continue a execu��o do programa.
;	
;	Criado por: Pedro Figueiredo.
;

		include <p16f887.inc>		;	cabe�alho
		__config	_CONFIG1,	0X2FF4	;Configuration ou fuse bits
		__config	_CONFIG2,	0x3FFF	;configuration bits ou fuse bits

		cblock 		0x20
					VAR1
		endc
		
		org			0x000				;VETOR DE RESETE
		GOTO		MAIN

		org			0x004				;VETOR DE INTERRUP��O
		RETFIE							;RETORNA DA INTERRUP��O

MAIN:
		CLRF		VAR1				;LIMPA VARI�VEL
		MOVLW		D'5'
		MOVWF		VAR1
		MOVLW		D'5'
		SUBWF		VAR1,F

		BTFSC		STATUS,Z			;SE F-W = 0 -> Z=1 -> Z != C
		GOTO		IGUAL				;ENT�O
					
		GOTO		MAIN				;SENAO

IGUAL:
		MOVLW		D'22'
		MOVWF		VAR1
		GOTO		MAIN
		
		END