.nolist
.include "m328Pdef.inc"
.list

.equ DISP_PORT_1 = PORTD
.equ DISP_PORT_2 = PORTB

.def AUX = R16
.def RES = R20

.ORG 0x0000
    RJMP Setup

Setup:
    LDI AUX, 0xFF
    OUT DDRD, AUX
    OUT DDRB, AUX

    LDI R17, 6
    LDI R18, 8

Main:
    LDI AUX, 10
    MUL R17, AUX
    MOV AUX, R0
    ADD AUX, R18

    LDI ZH, HIGH(Matrix << 1)
    LDI ZL, LOW(Matrix << 1)
    
    ADD ZL, AUX
    BRCC No_Carry2
    INC ZH
No_Carry2:
    LPM AUX, Z

    MOV R19, AUX
    RCALL Search
    OUT DISP_PORT_1, RES

    MOV R19, AUX
    SWAP R19
    RCALL Search
    OUT DISP_PORT_2, RES

Search:
    ANDI R19, 0x0F

    LDI ZH, HIGH(Display_Table << 1)
    LDI ZL, LOW(Display_Table << 1)
    
    ADD ZL, R19
    BRCC No_Carry
    INC ZH
No_Carry:
    LPM RES, Z
    RET

Matrix:
    .db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    .db 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
    .db 20, 21, 22, 23, 24, 25, 26, 27, 28, 29
    .db 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
    .db 40, 41, 42, 43, 44, 45, 46, 47, 48, 49
    .db 50, 51, 52, 53, 54, 55, 56, 57, 58, 59
    .db 60, 61, 62, 63, 64, 65, 66, 67, 68, 69
    .db 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
    .db 80, 81, 82, 83, 84, 85, 86, 87, 88, 89
    .db 90, 91, 92, 93, 94, 95, 96, 97, 98, 99

Display_Table: .dw 0x7940, 0x3024, 0x1219, 0x7802, 0x1800, 0x0308, 0x2146, 0x0E06
