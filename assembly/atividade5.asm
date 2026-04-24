.nolist
.include "m328Pdef.inc"
.list

.equ BOTAO_INC = PD4
.equ BOTAO_DEC = PD5

.def CONTADOR  = R17
.def AUX       = R16

.ORG 0x000
    LDI AUX,0b00000000
    OUT DDRD,AUX

    LDI AUX,0b11111111
    OUT PORTD, AUX

    LDI AUX,0b11111111
    OUT DDRB,AUX

    LDI AUX,0b00000000
    OUT PORTB, AUX

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
    
    RJMP check_0

Esp_Soltar_Dec:
    SBIC PIND,BOTAO_DEC
    RJMP Decr

    RCALL Atraso

    RJMP Esp_Soltar_Dec

Decr:
    DEC CONTADOR
    RJMP check_0
    
Atualizar_leds:
    OUT PORTB, AUX    
    RJMP Principal

Atraso:
    DEC R3
    BRNE Atraso
    DEC R2
    BRNE Atraso
    RET


check_0:
    MOV AUX, CONTADOR
    ANDI AUX, 0b00001111

    CPI AUX, 0x00
    BRNE check_1
    LDI AUX, 0b00111111
    RJMP Atualizar_leds

check_1:
    CPI AUX, 0x01
    BRNE check_2
    LDI AUX, 0b00000110
    RJMP Atualizar_leds

check_2:
    CPI AUX, 0x02
    BRNE check_3
    LDI AUX, 0b01011011
    RJMP Atualizar_leds

check_3:
    CPI AUX, 0x03
    BRNE check_4
    LDI AUX, 0b01001111
    RJMP Atualizar_leds

check_4:
    CPI AUX, 0x04
    BRNE check_5
    LDI AUX, 0b01100110
    RJMP Atualizar_leds

check_5:
    CPI AUX, 0x05
    BRNE check_6
    LDI AUX, 0b01101101
    RJMP Atualizar_leds

check_6:
    CPI AUX, 0x06
    BRNE check_7
    LDI AUX, 0b01111101
    RJMP Atualizar_leds

check_7:
    CPI AUX, 0x07
    BRNE check_8
    LDI AUX, 0b00000111
    RJMP Atualizar_leds

check_8:
    CPI AUX, 0x08
    BRNE check_9
    LDI AUX, 0b01111111
    RJMP Atualizar_leds

check_9:
    CPI AUX, 0x09
    BRNE check_A
    LDI AUX, 0b01101111
    RJMP Atualizar_leds

check_A:
    CPI AUX, 0x0A
    BRNE check_B
    LDI AUX, 0b01110111
    RJMP Atualizar_leds

check_B:
    CPI AUX, 0x0B
    BRNE check_C
    LDI AUX, 0b01111100
    RJMP Atualizar_leds

check_C:
    CPI AUX, 0x0C
    BRNE check_D
    LDI AUX, 0b00111001
    RJMP Atualizar_leds

check_D:
    CPI AUX, 0x0D
    BRNE check_E
    LDI AUX, 0b01011110
    RJMP Atualizar_leds

check_E:
    CPI AUX, 0x0E
    BRNE check_F
    LDI AUX, 0b01111001
    RJMP Atualizar_leds

check_F:
    CPI AUX, 0x0F
    BRNE unknown
    LDI AUX, 0b01110001
    RJMP Atualizar_leds

unknown:
    ldi AUX, 0x00