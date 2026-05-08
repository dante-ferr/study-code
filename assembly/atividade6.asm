.nolist
.include "m328Pdef.inc"
.list

.equ BOTAO = PB0
.equ DISPLAY = PORTD
.def AUX = R16

.ORG 0x000

Inicializacoes:
    LDI AUX, 0b11111110
    OUT DDRB, AUX
    LDI AUX, 0xFF
    OUT PORTB, AUX
    OUT DDRD, AUX
    OUT PORTD, AUX

    STS UCSR0B, R1

Principal:
    SBIC PINB, BOTAO
    RJMP Principal

    CPI AUX, 0x0F
    BRNE Incr
    LDI AUX, 0x00
    RJMP Decod

Incr:
    INC AUX

Decod:
    RCALL Decodifica
    RCALL Atraso

    RJMP Principal

Atraso:
    LDI R19, 16
volta:
    DEC R17
    BRNE volta
    DEC R18
    BRNE volta
    DEC R19
    BRNE volta
    RET

Decodifica:
    LDI ZH, HIGH(Tabela<<1)
    LDI ZL, LOW(Tabela<<1)

    ADD ZL, AUX

    BRCC le_tab

    INC ZH

le_tab:
    LPM R0, Z
    COM R0
    OUT DISPLAY, R0
    RET

Tabela: .dw 0x7940, 0x3024, 0x1219, 0x7802, 0x1800, 0x0308, 0x2146, 0x0E06