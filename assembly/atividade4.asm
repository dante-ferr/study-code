.nolist
.include "m328Pdef.inc"
.list

.equ LED = PD2
.equ BOTAO_INC = PD4
.equ BOTAO_DEC = PD5
.def AUX = R16

.ORG 0x000
    LDI AUX,0b00000100
    OUT DDRD,AUX
    LDI AUX,0b11111111
    OUT PORTD,AUX
    NOP

Principal:
    SBIC PIND,BOTAO
    RJMP Principal

Esp_Soltar:
    SBIS PIND,BOTAO
    RJMP Esp_Soltar
    ; RCALL Atraso

    SBIC PORTD,LED
    RJMP Inc

    SBI PORTD,LED
    RJMP Principal

Inc:
    OUT PORTD, R16
    RJMP Principal



Atraso:
    DEC R3
    BRNE Atraso
    DEC R2
    BRNE Atraso
    RET
