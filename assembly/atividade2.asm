.nolist
.include "m328Pdef.inc"
.list

.ORG 0x000
    LDI R16, 0xFF
    OUT DDRD, R16
    CLR R16

PRINCIPAL:
    OUT PORTD, R16
    RCALL ATRASO_AJUSTAVEL
    
    CPI R16, 15
    BREQ TRAVAR
    
    INC R16
    RJMP PRINCIPAL

TRAVAR:
    RJMP TRAVAR

ATRASO_AJUSTAVEL:
    LDI R19, 40
volta3:
    LDI R18, 255
volta2:
    LDI R17, 255
volta1:
    DEC R17
    BRNE volta1
    DEC R18
    BRNE volta2
    DEC R19
    BRNE volta3
    RET