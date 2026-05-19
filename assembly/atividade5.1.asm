.nolist
.include "m328Pdef.inc"
.list

.equ BTN_INC = PD4
.equ BTN_DEC = PD5
.equ DISP_PORT = PORTB

.def AUX = R16
.def COUNTER = R17
.def DIRECTION = R18

.ORG 0x000

; === [1] SETUP ===
Setup:
    LDI AUX, 0x00
    OUT DDRD, AUX
    OUT PORTB, AUX      ; 0x00 leaves display OFF initially

    LDI AUX, 0xFF
    OUT DDRB, AUX
    OUT PORTD, AUX

    CLR COUNTER

; === [2] STARTUP WAIT (Derived from Module 2) ===
Wait_Start:
    SBIS PIND, BTN_INC
    RJMP Set_Inc
    SBIS PIND, BTN_DEC
    RJMP Set_Dec
    RJMP Wait_Start

Set_Inc:
    LDI DIRECTION, 0
    RJMP Update_Display
Set_Dec:
    LDI DIRECTION, 1
    RJMP Update_Display

; === [3] DIRECTION CONTROL ===
Main:
    SBIS PIND, BTN_INC  ; Skip next line if unpressed (HIGH)
    LDI DIRECTION, 0    ; Execute if pressed (LOW)
    
    SBIS PIND, BTN_DEC  ; Skip next line if unpressed (HIGH)
    LDI DIRECTION, 1    ; Execute if pressed (LOW)

; === [4] DISPLAY OUTPUT (Module 4) ===
Update_Display:
    LDI ZH, HIGH(Display_Table << 1)
    LDI ZL, LOW(Display_Table << 1)
    
    ADD ZL, COUNTER
    BRCC No_Carry
    INC ZH

No_Carry:
    LPM AUX, Z
    OUT DISP_PORT, AUX
    RCALL Delay

; === [5] COUNTER LOGIC (Module 3) ===
    CPI DIRECTION, 0
    BREQ Count_Up

Count_Down:
    DEC COUNTER
    ANDI COUNTER, 0x0F
    RJMP Main

Count_Up:
    INC COUNTER
    ANDI COUNTER, 0x0F
    RJMP Main

; === [6] HELPERS (Module 5 and 8) ===
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