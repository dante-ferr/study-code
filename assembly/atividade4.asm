.nolist
.include "m328Pdef.inc"
.list

.equ BOTAO_INC = PD4
.equ BOTAO_DEC = PD5

.equ LEDS_MASK = 0b00001111
.equ PULLUPS   = 0b11110000
.def CONTADOR  = R17
.def AUX       = R16

.ORG 0x000
    LDI AUX,0b00001111
    OUT DDRD,AUX

    LDI AUX,0b11111111
    OUT PORTD, AUX

    CLR CONTADOR
    NOP

Principal:
    SBIS PIND,BOTAO_INC
    RJMP Esp_Soltar_Inc

    SBIS PIND,BOTAO_DEC
    RJMP Esp_Soltar_Dec

    RJMP Principal

Esp_Soltar_Inc:
    SBIC PIND,BOTAO_INC
    RJMP Incr

    RCALL Atraso

    RJMP Esp_Soltar_inc

Incr:
    INC CONTADOR
    RJMP Atualizar_leds

Esp_Soltar_Dec:
    SBIC PIND,BOTAO_DEC
    RJMP Decr

    RCALL Atraso

    RJMP Esp_Soltar_Dec

Decr:
    DEC CONTADOR
    RJMP Atualizar_leds
    
Atualizar_leds:
    MOV AUX, CONTADOR
    ORI AUX, PULLUPS
    OUT PORTD, AUX
    
    RJMP Principal

Atraso:
    DEC R3
    BRNE Atraso
    DEC R2
    BRNE Atraso
    RET
