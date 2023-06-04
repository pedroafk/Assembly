;	Microcontrolador PIC16F887
;
;	Checar se VAR1 >= 10, se sim,
;	VARC = 1, caso contrário VARC = 0
;
;	Criado por: Pedro Figueiredo.
;

	include <p16f887.inc>
	__config	_CONFIG1,	0x2FF4
	__config	_CONFIG2,	0x3FFF
	
	;Dec var
	cblock		0x20
				VAR1
				VARC
	endc
	
	;Vetor reset
	org			0x000
	GOTO		MAIN

	;Vetor int
	org			0x004
	RETFIE

MAIN:
	movlw		d'8'
	movwf		VAR1
	movlw		d'10'
	subwf		VAR1,W
	btfsc		STATUS,C	;15 >= 10
	goto		RECEBEUM	;Sim
	movlw		d'0'		;Não
	movwf		VARC
	goto 		FINAL

RECEBEUM:
	movlw		d'1'
	movwf		VARC
	goto		FINAL

FINAL:
	END	