.nolist
.include "m328Pdef.inc"
.list

.equ BTN = PB0
.equ DISP_PORT = PORTD

.def AUX = R16
.def NUM = R17

.ORG 0x0000
    RJMP Setup

Setup:
    STS UCSR0B, R1
    LDI AUX, 0xFF
    OUT DDRD, AUX
    OUT PORTB, AUX

    LDI AUX, 0x00
    OUT DDRB, AUX

    LDI NUM, 1

Check_Button:
    SBIC PINB, BTN
    RJMP Check_Button

Wait_Release:
    RCALL Check_Count
    
    SBIS PINB, BTN
    RJMP Wait_Release

    RCALL Delay
    RCALL Update_Display
    RJMP Check_Button

Check_Count:
    CPI NUM, 6
    BRLO Count
    LDI NUM, 1
    RET

Count:
    INC NUM
    RET

Update_Display:
    LDI ZH, HIGH(Display_Table << 1)
    LDI ZL, LOW(Display_Table << 1)
    
    ADD ZL, NUM
    BRCC No_Carry
    INC ZH
No_Carry:
    LPM AUX, Z
    OUT DISP_PORT, AUX
    RET

Delay:
    LDI R21, 18 
Delay_Loop:
    DEC R19
    BRNE Delay_Loop
    DEC R20
    BRNE Delay_Loop
    DEC R21
    BRNE Delay_Loop
    RET

Display_Table: .dw 0x7940, 0x3024, 0x1219, 0x7802, 0x1800, 0x0308, 0x2146, 0x0E06