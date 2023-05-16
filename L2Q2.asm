;	Microcontrolador PIC16F887
;
;	Acesso ao Hardware stack e tratamento de interrupção com salvamento de contexto.
;	Inverte o nível lógico do pino RB1 após apertar o botão de interrupção RB0.
;	
;	Criado por: Pedro Figueiredo.
;

		include <p16f887.inc>		;	cabeçalho
		__config	_CONFIG1,	0X2FF4	;Configuration ou fuse bits
		__config	_CONFIG2,	0x3FFF	;configuration bits ou fuse bits

		cblock 		0x20
					_W
		endc
		
		org			0x000				;VETOR DE RESETE
		GOTO		SETUP

		org			0x004				;VETOR DE INTERRUPÇÃO
		MOVWF	_W						;SALVAMENTO DE CONTEXTO
		
		BCF			INTCON,INTF			;LIMPA A FLAG DE INTERRUPÇÃO
		BCF			PORTB,RB1

		MOVF	_W,W					;RESTAURAÇÃO DE CONTEXTO
		RETFIE							;RETORNA DA INTERRUPÇÃO

SETUP:
		BCF			STATUS,RP1
		BSF			STATUS,RP0			;SELEÇÃO DO BANCO 1
		
		BSF			TRISB,TRISB0		;TRISB0 COMO INPUT DIGITAL
		BCF			TRISB,TRISB1		;TRISB1 COMO OUTPUT DIGITAL

		BSF			OPTION_REG,INTEDG	;INT EXTERNA COM BORDA DE SUBIDA
		BCF			INTCON,INTF			;FLAG 0: INT NÃO OCORREU
		BSF			INTCON,INTE			;HABILITAÇÃO DA INT EXTERNA
		BSF			INTCON,GIE			;HABILITAÇÃO GLOBAL INT
		
		BSF			STATUS,RP1
		BSF			STATUS,RP0			;SELEÇÃO DO BANCO 3
		
		MOVLW		B'00000000'
		MOVWF		ANSELH				;TRISB COMO I/O DIGITAL

		BCF			STATUS,RP1
		BCF			STATUS,RP0			;SELEÇÃO DO BANCO 0
		BSF			PORTB,RB1

		GOTO		LOOP

LOOP:
		
		GOTO	LOOP


		END