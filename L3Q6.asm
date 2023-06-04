;	Microcontrolador PIC16F887
;
;	Verifica se VAR1 == 0, se sim
;	salte para ZERO, se não
;	continue o programa
;
;	Criado por: Pedro Figueiredo
;

	include <p16f887.inc>
	__CONFIG	_CONFIG1,	0x2FF4
	__CONFIG	_CONFIG2,	0x3FFF
	
	;Decl var
	CBLOCK		0x20
		VAR1
	ENDC

	;Vet Reset
	ORG			0x000
	GOTO		MAIN

	;Vet Int
	ORG			0x004
	RETFIE

MAIN:
	MOVLW		d'10'
	MOVWF		VAR1
	MOVLW		d'10'
	SUBWF		VAR1,W
	BTFSC		STATUS,Z	;não pula se são iguais
	GOTO		ZERO
	MOVLW		d'1'
	GOTO		FIM

ZERO:
	MOVLW		d'0'
	GOTO		FIM

FIM:

	END