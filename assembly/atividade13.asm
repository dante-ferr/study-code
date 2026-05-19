.nolist
.include "m328Pdef.inc"
.list

.equ DISP_PORT = PORTC

.def AUX = R16
.def COUNTER = R17

.ORG 0x0000
    RJMP Setup

Setup:
    STS UCSR0B, R1

    LDI AUX, 0xFF
    OUT DDRC, AUX

    LDI COUNTER, 0

    RJMP Update_Display

Main:
    RCALL Delay

    CPI COUNTER, 13
    BRNE Inc_Counter
    LDI COUNTER, 0
    RCALL Update_Display

Inc_Counter:
    INC COUNTER

Update_Display:
    LDI ZH, HIGH(Sequence << 1)
    LDI ZL, LOW(Sequence << 1)
    
    ADD ZL, COUNTER
    BRCC No_Carry
    INC ZH
No_Carry:
    LPM AUX, Z
    OUT DISP_PORT, AUX

    RJMP Main

Delay:
    LDI R21, 48
Delay_Loop:
    DEC R19
    BRNE Delay_Loop
    DEC R20
    BRNE Delay_Loop
    DEC R21
    BRNE Delay_Loop
    RET

Sequence:
    .db 0x12, 0x08, 0x23, 0x7F, 0x61, 0x23, 0x08, 0x23, 0x3F, 0x24, 0x40, 0x24, 0x12, 0x7F