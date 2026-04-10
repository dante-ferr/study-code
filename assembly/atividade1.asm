.nolist
.include "m328Pdef.inc"
.list

.ORG 0x000
INICIO:
    LDI R16, 0xFF
    OUT DDRD, R16
    LDI R16, 0x01

PRINCIPAL:
    OUT PORTD, R16
    RCALL ATRASO
    
    LSL R16
    SBRC R16, 4
    LDI R16, 0x01
    
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
