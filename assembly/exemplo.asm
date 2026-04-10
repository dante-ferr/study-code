.nolist
.include "m328Pdef.inc"
.list

.equ LED = PB5

.ORG 0x000
INICIO:
    LDI R16,0xFF
    OUT DDRB,R16
PRINCIPAL:
    SBI PORTB, LED
    RCALL ATRASO
    CBI PORTB, LED
    RCALL ATRASO
    RJMP PRINCIPAL
ATRASO:

volta:
    DEC R17
    BRNE volta
    DEC R18
    BRNE volta
    DEC R19
    BRNE volta
    RET