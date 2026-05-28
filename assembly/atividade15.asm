Loop:
    LDI R19, 40
volta3:
    LDI R18, 255
volta2:
    LDI R17, 255
volta1:
    DEC R17
    BRNE volta1
    DEC R18
    BRNE volta2
    DEC R19
    BRNE volta3
    RET