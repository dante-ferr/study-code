; Exercício 5.12 do livro

.nolist
.include "m328Pdef.inc"
.list

.equ ADJUST_SW = PB0
.equ SELECT_BTN = PB1
.equ DISP_PORT = PORTD

.def AUX = R16
.def BUX = R17
.def FUNCTION = R18
.def A_STATE = R22

.ORG 0x0000
    RJMP Setup

Setup:
    LDI AUX, 0xFF
    OUT DDRD, AUX
    OUT PORTB, AUX

    LDI AUX, 0x00
    OUT DDRB, AUX

    LDI A_STATE, 1

Check_Adjust_Button:
    RCALL Count

    CP A_STATE, 1
    RCALL Run_Anim

    SBIC PINB, ADJUST_SW
    RJMP Check_Adjust_Button

Wait_Adjust_Release:
    SBIS PINB, ADJUST_SW
    RJMP Wait_Adjust_Release

    RCALL Delay
    RCALL Check_Select_Button

    RJMP Check_Adjust_Button

Count:
    LDI R23, 16
Count_Loop:
    DEC R24
    BRNE Count_Loop
    DEC R25
    BRNE Count_Loop
    DEC R23
    BRNE Count_Loop

    COM A_STATE
    RET

Run_Anim:
    ; Apenas o número da função piscando
    MOV BUX, FUNCTION
    RCALL Update_Display
    RET

Check_Select_Button:
    SBIC PINB, SELECT_BTN
    RET

Wait_Select_Release:
    SBIS PINB, SELECT_BTN
    RJMP Wait_Select_Release

    RCALL Delay
    INC FUNCTION
    MOV BUX, FUNCTION
    RCALL Update_Display

    RET

Update_Display:
    LDI ZH, HIGH(Display_Table << 1)
    LDI ZL, LOW(Display_Table << 1)
    
    ADD ZL, BUX
    BRCC No_Carry
    INC ZH
No_Carry:
    LPM AUX, Z
    OUT DISP_PORT, AUX

    RET

Delay:
    LDI R21, 16
Delay_Loop:
    DEC R19
    BRNE Delay_Loop
    DEC R20
    BRNE Delay_Loop
    DEC R21
    BRNE Delay_Loop
    RET