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
    SBIS PIND,BOTAO_INC
    RJMP Esp_Soltar_Inc

    SBIS PIND,BOTAO_DEC
    RJMP Esp_Soltar_Dec

    RJMP Principal

Esp_Soltar_Inc:
    SBIS PIND,BOTAO_INC
    RJMP Esp_Soltar

    SBIC PORTD,LED
    RJMP Inc

    SBI PORTD,LED
    RJMP Principal

    ; RCALL Atraso
    RJMP Esp_Soltar_Inc

Inc:
    OUT PORTD, R16
    RJMP Principal



Atraso:
    DEC R3
    BRNE Atraso
    DEC R2
    BRNE Atraso
    RET
