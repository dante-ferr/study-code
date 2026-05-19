.nolist
.include "m328Pdef.inc"
.list

; --- MACROS & REGISTERS ---
.equ BTN_INC = PD4
.equ BTN_DEC = PD5
.equ DISP_PORT = PORTB
.equ MUX_PORT = PORTC
.equ DISP1_EN = PC0
.equ DISP2_EN = PC1

.def AUX = R16
.def COUNTER = R17
.def ONES = R18
.def TENS = R19

; --- INTERRUPT VECTORS ---
.ORG 0x0000
    RJMP Setup

; ---------------------------------------------------------
; MODULE 1: BASIC I/O INITIALIZATION
; ---------------------------------------------------------
Setup:
    LDI AUX, 0xFF
    OUT DDRB, AUX
    
    LDI AUX, 0x00
    OUT DDRD, AUX
    
    LDI AUX, 0xFF
    OUT PORTD, AUX

; ---------------------------------------------------------
; MODULE 2: BUTTON POLLING & DEBOUNCE (BLOCKING)
; ---------------------------------------------------------
Check_Button:
    SBIS PIND, BTN_INC
    RJMP Wait_Release
    RJMP Check_Button

Wait_Release:
    SBIC PIND, BTN_INC
    RJMP Execute_Action
    RCALL Delay
    RJMP Wait_Release

Execute_Action:
    NOP

; ---------------------------------------------------------
; MODULE 3: COUNTER WRAP-AROUND LIMITS
; ---------------------------------------------------------
Inc_Mod16:
    INC COUNTER
    ANDI COUNTER, 0x0F
    
Inc_Mod10:
    INC COUNTER
    CPI COUNTER, 10
    BRNE Continue
    LDI COUNTER, 0
Continue:
    NOP

; ---------------------------------------------------------
; MODULE 4: LPM - 7-SEGMENT LOOKUP TABLE ACCESS
; ---------------------------------------------------------
Update_Display:
    LDI ZH, HIGH(Display_Table << 1)
    LDI ZL, LOW(Display_Table << 1)
    
    ADD ZL, COUNTER
    BRCC No_Carry
    INC ZH
No_Carry:
    LPM AUX, Z
    OUT DISP_PORT, AUX

; ---------------------------------------------------------
; MODULE 5: BLOCKING DELAY (NESTED LOOPS)
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; MODULE 6: EXTERNAL INTERRUPT SETUP (INT0)
; ---------------------------------------------------------
Setup_INT0:
    LDI AUX, (1 << ISC01) 
    STS EICRA, AUX
    LDI AUX, (1 << INT0)  
    OUT EIMSK, AUX
    SEI                   

; ---------------------------------------------------------
; MODULE 7: TIMER0 OVERFLOW SETUP (NON-BLOCKING DELAY)
; ---------------------------------------------------------
Setup_Timer0:
    LDI AUX, (1 << CS02) | (1 << CS00) 
    OUT TCCR0B, AUX
    LDI AUX, (1 << TOIE0)              
    STS TIMSK0, AUX
    SEI                                

; ---------------------------------------------------------
; MODULE 8: DATA TABLES (FLASH MEMORY)
; ---------------------------------------------------------
Display_Table:
    .db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07
    .db 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

; ---------------------------------------------------------
; MODULE 9: NIBBLE EXTRACTION (SWAP)
; ---------------------------------------------------------
Extract_Nibbles:
    MOV R17, R16
    ANDI R17, 0x0F
    
    MOV R18, R16
    SWAP R18
    ANDI R18, 0x0F
    RET

; ---------------------------------------------------------
; MODULE 10: BINARY TO BCD (0-99 DECIMAL / BASE 10)
; ---------------------------------------------------------
Bin_To_BCD:
    MOV R17, R16
    CLR R18
    
Div10_Loop:
    CPI R17, 10       
    BRLO Div10_Done
    SUBI R17, 10
    INC R18
    RJMP Div10_Loop
    
Div10_Done:
    RET

; ---------------------------------------------------------
; MODULE 11: MULTIPLEXING DISPLAYS
; ---------------------------------------------------------
Multiplex_Displays:
    LDI AUX, (1 << DISP1_EN)
    OUT MUX_PORT, AUX
    MOV COUNTER, TENS
    RCALL Update_Display
    RCALL Small_Delay
    
    LDI AUX, (1 << DISP2_EN)
    OUT MUX_PORT, AUX
    MOV COUNTER, ONES
    RCALL Update_Display
    RCALL Small_Delay
    RET

Small_Delay:
    LDI R20, 20
Small_Delay_Loop:
    DEC R20
    BRNE Small_Delay_Loop
    RET

; ---------------------------------------------------------
; MODULE 12: BINARY TO CUSTOM BASE (E.G., BASE 12)
; ---------------------------------------------------------
Bin_To_Custom_Base:
    MOV R17, R16
    CLR R18
    
DivBase_Loop:
    CPI R17, 12        
    BRLO DivBase_Done
    SUBI R17, 12       
    INC R18
    RJMP DivBase_Loop
    
DivBase_Done:
    RET