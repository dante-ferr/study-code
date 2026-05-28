; Prática 4.1

.nolist
.include "m328Pdef.inc"
.list

.equ BOTAO = PB0
.equ DISPLAY2 = PORTD
.equ DISPLAY1 = PORTC
.def AUX = R16
.def BUX = R17

.ORG 0x000

Inicializacoes:
    LDI AUX, 0b11111110
    OUT DDRB, AUX

    LDI AUX, 0xFF
    OUT DDRD, AUX
    OUT DDRC, AUX

    OUT PORTB, AUX

    LDI AUX, 0x00
    RJMP Decod

Principal:
    SBIC PINB, BOTAO
    RJMP Principal

    CPI AUX, 0xFF
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
    MOV BUX, AUX
    RCALL Busca_Tabela
    OUT DISPLAY1, R0

    MOV BUX, AUX
    SWAP BUX
    RCALL Busca_Tabela
    OUT DISPLAY2, R0
    RET

Busca_Tabela:
    LDI ZH, HIGH(Tabela<<1)
    LDI ZL, LOW(Tabela<<1)
    
    ANDI BUX, 0x0F
    ADD ZL, BUX
    BRCC le_tab
    INC ZH

le_tab:
    LPM R0, Z
    COM R0
    RET

Tabela: .dw 0x7940, 0x3024, 0x1219, 0x7802, 0x1800, 0x0308, 0x2146, 0x0E06