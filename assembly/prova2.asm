.nolist
.include "m328Pdef.inc"
.list

; =======================================================================
; DEFINIÇÕES DE PINOS E REGISTRADORES
; =======================================================================
.equ BOTAO_INC = PC0  ; Botão de incremento no pino PC0
.equ BOTAO_DEC = PC1  ; Botão de decremento no pino PC1
.equ BOTAO_RST = PC2  ; Botão de reset no pino PC2
.equ DISPLAY1 = PORTB
.equ DISPLAY2 = PORTD

.def AUX      = R16   ; Registrador de uso geral
.def CONTADOR = R17   ; Guarda DEZENA (High Nibble) e UNIDADE (Low Nibble)
.def DADO     = R19   ; Registrador temporário para a leitura da Tabela

.ORG 0x000
    RJMP Setup

; =======================================================================
; CONFIGURAÇÕES INICIAIS
; =======================================================================
Setup:
    ; Libera os pinos PD0 e PD1 (Desliga a Serial)
    LDI AUX, 0x00
    STS UCSR0B, AUX

    ; Configura as Portas dos Displays como Saídas
    LDI AUX, 0xFF
    OUT DDRB, AUX     ; PORTB (Dezenas)
    OUT DDRD, AUX     ; PORTD (Unidades)

    ; Configura as Portas dos Botões como Entradas com Pull-up
    LDI AUX, 0x00
    OUT DDRC, AUX     
    LDI AUX, 0xFF
    OUT PORTC, AUX    

    ; Inicializa o contador em "00" (Packed BCD)
    LDI CONTADOR, 0x00
    RCALL Atualiza_Displays

; =======================================================================
; LAÇO PRINCIPAL (Varredura de Botões)
; =======================================================================
Principal:
    SBIS PINC, BOTAO_INC
    RJMP Trata_Inc

    SBIS PINC, BOTAO_DEC
    RJMP Trata_Dec

    SBIS PINC, BOTAO_RST
    RJMP Trata_Rst

    RJMP Principal


; =======================================================================
; TRATAMENTO DOS BOTÕES (Matemática BCD Empacotada)
; =======================================================================

; ------------------ LÓGICA DE INCREMENTO ------------------
Trata_Inc:
Espera_Soltar_Inc:
    SBIS PINC, BOTAO_INC      
    RJMP Espera_Soltar_Inc
    RCALL Atraso              

    INC CONTADOR              ; Incrementa o valor (Ex: 0x09 vira 0x0A)
    
    ; Verifica se a unidade estourou (passou de 9)
    MOV AUX, CONTADOR
    ANDI AUX, 0x0F            ; Isola só a unidade
    CPI AUX, 0x0A             ; A unidade chegou a 10 (0x0A)?
    BRNE Verifica_Limite_Inc
    
    ; O "Pulo do Gato" do incremento BCD: Soma 6
    LDI AUX, 0x06
    ADD CONTADOR, AUX         ; 0x0A + 0x06 = 0x10 (Zera unidade, sobe 1 na dezena!)

Verifica_Limite_Inc:
    CPI CONTADOR, 0x60        ; Chegou no 60 (0x60)?
    BRNE Fim_Acao
    LDI CONTADOR, 0x00        ; Se sim, volta pro 00
    RJMP Fim_Acao

; ------------------ LÓGICA DE DECREMENTO ------------------
Trata_Dec:
Espera_Soltar_Dec:
    SBIS PINC, BOTAO_DEC
    RJMP Espera_Soltar_Dec
    RCALL Atraso

    CPI CONTADOR, 0x00        ; Já é zero absoluto?
    BRNE Verifica_Unidade_Zero
    LDI CONTADOR, 0x59        ; Rola de 00 para 59 direto
    RJMP Fim_Acao

Verifica_Unidade_Zero:
    MOV AUX, CONTADOR
    ANDI AUX, 0x0F            ; Isola só a unidade
    CPI AUX, 0x00             ; A unidade é zero? (ex: 0x20)
    BRNE Dec_Normal
    
    ; O "Pulo do Gato" do decremento BCD: Subtrai 7
    LDI AUX, 0x07
    SUB CONTADOR, AUX         ; Ex: 0x20 - 0x07 = 0x19 (Desce a dezena, unidade vai pra 9!)
    RJMP Fim_Acao

Dec_Normal:
    DEC CONTADOR              ; Decremento comum (Ex: 0x59 vira 0x58)
    RJMP Fim_Acao

; ------------------ LÓGICA DE RESET ------------------
Trata_Rst:
Espera_Soltar_Rst:
    SBIS PINC, BOTAO_RST
    RJMP Espera_Soltar_Rst
    RCALL Atraso

    LDI CONTADOR, 0x00        ; Zera tudo

Fim_Acao:
    RCALL Atualiza_Displays   
    RJMP Principal


; =======================================================================
; ATUALIZAÇÃO DOS DISPLAYS (A "MANHA" DO SWAP)
; =======================================================================
Atualiza_Displays:
    ; 1. ISOLA E MANDA A UNIDADE PARA O DISPLAY1
    MOV AUX, CONTADOR
    ANDI AUX, 0x0F            ; Isola o Low Nibble (A Unidade)
    
    LDI ZH, HIGH(Tabela_7Seg << 1)
    LDI ZL, LOW(Tabela_7Seg << 1)
    ADD ZL, AUX
    BRCC Sem_Carry_Uni
    INC ZH                    
Sem_Carry_Uni:
    LPM DADO, Z               
    OUT DISPLAY1, DADO

    ; 2. USA SWAP, ISOLA E MANDA A DEZENA PARA O DISPLAY2
    MOV AUX, CONTADOR
    SWAP AUX                  ; INVERTE OS NIBBLES (A mágica acontece aqui! 0x59 vira 0x95)
    ANDI AUX, 0x0F            ; Isola o Low Nibble (Que agora contém o 5 da Dezena)
    
    LDI ZH, HIGH(Tabela_7Seg << 1)
    LDI ZL, LOW(Tabela_7Seg << 1)
    ADD ZL, AUX
    BRCC Sem_Carry_Dez
    INC ZH
Sem_Carry_Dez:
    LPM DADO, Z               
    OUT DISPLAY2, DADO

    RET


; =======================================================================
; ROTINA DE ATRASO PARA DEBOUNCE
; =======================================================================
Atraso:
    LDI R21, 20
Loop3:
    LDI R22, 255
Loop2:
    LDI R23, 255
Loop1:
    DEC R23
    BRNE Loop1
    DEC R22
    BRNE Loop2
    DEC R21
    BRNE Loop3
    RET

; =======================================================================
; TABELA DE 7 SEGMENTOS (CATODO COMUM)
; =======================================================================
Tabela_7Seg:
    .db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67