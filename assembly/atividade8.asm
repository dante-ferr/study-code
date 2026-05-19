; Questão 3 da prova anterior

.nolist
.include "m328Pdef.inc"
.list

.def AUX = R16
.def CONTADOR = R17

.ORG 0x000
    STS UCSR0B, R1
    
    LDI AUX, 0xFF
    OUT DDRC, AUX

    LDI CONTADOR, 0

Principal:
    MOV AUX, CONTADOR 

check_0:
    CPI AUX, 0
    BRNE check_1
    LDI AUX, 0x12
    RJMP Exibir

check_1:
    CPI AUX, 1
    BRNE check_2
    LDI AUX, 0x08
    RJMP Exibir

check_2:
    CPI AUX, 2
    BRNE check_3
    LDI AUX, 0x23
    RJMP Exibir

check_3:
    CPI AUX, 3
    BRNE check_4
    LDI AUX, 0x61
    RJMP Exibir

check_4:
    CPI AUX, 4
    BRNE check_5
    LDI AUX, 0x3F
    RJMP Exibir

check_5:
    CPI AUX, 5
    BRNE check_6
    LDI AUX, 0x24
    RJMP Exibir

check_6:
    CPI AUX, 6
    BRNE check_7
    LDI AUX, 0x00
    RJMP Exibir

check_7:
    CPI AUX, 7
    BRNE default
    LDI AUX, 0x12
    RJMP Exibir

default:
    LDI AUX, 0xFF

Exibir:
    OUT PORTC, AUX
    RCALL Atraso

    INC CONTADOR
    CPI CONTADOR, 9
    BRNE Principal
    
    LDI CONTADOR, 0   
    RJMP Principal

Atraso:
    LDI R19, 48
volta:
    DEC R20
    BRNE volta
    DEC R21
    BRNE volta
    DEC R19
    BRNE volta
    RET