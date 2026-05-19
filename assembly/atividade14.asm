.nolist
.include "m328Pdef.inc"
.list

.equ LEDS = PORTD
.equ BTN = PB0

.def AUX = R16
.def N = R17

.ORG 0x0000
    RJMP Setup

Setup:
    LDI AUX, 0x00
    OUT DDRB, AUX

    LDI AUX, 0xFF
    OUT DDRD, AUX
    OUT PORTB, AUX

    LDI N, 0b00000001
    OUT LEDS, N

Check_Button:
    SBIC PINB, BTN
    RJMP Check_Button

Wait_Release:
    SBIS PINB, BTN
    RJMP Wait_Release

    RCALL Delay

    CPI N, 0b10000000
    BREQ Reset

    LSL N
    OUT LEDS, N

    RJMP Check_Button

Reset:
    LDI N, 0b00000001
    OUT LEDS, N

    RJMP Check_Button

Delay:
    LDI R21, 5
Delay_Loop:
    DEC R19
    BRNE Delay_Loop
    DEC R20
    BRNE Delay_Loop
    DEC R21
    BRNE Delay_Loop
    RET