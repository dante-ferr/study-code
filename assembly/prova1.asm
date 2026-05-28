.nolist
.include "m328Pdef.inc"
.list

; =======================================================================
; DEFINIÇÕES DE REGISTRADORES
; =======================================================================
.def AUX      = R16    ; Registrador auxiliar
.def CONTADOR = R17    ; Mantém o índice atual da letra (0 a 13)
.def OFFSET   = R18    ; Deslocamento gerado pelo Switch para ler a Tabela
.def DADO     = R19    ; Dado lido da memória Flash

.ORG 0x000
    RJMP Setup

; =======================================================================
; CONFIGURAÇÕES INICIAIS
; =======================================================================
Setup:
    ; Configura todos os pinos do PORTD como saída (Display 7 Seg)
    LDI AUX, 0xFF
    OUT DDRD, AUX

    ; Inicia o contador de caracteres em 0
    LDI CONTADOR, 0

; =======================================================================
; LAÇO PRINCIPAL (Letreiro Gradual)
; =======================================================================
Principal:
    MOV AUX, CONTADOR   ; Copia o contador atual para ser testado no Switch

; =======================================================================
; ESTRUTURA "SWITCH" (Avalia o índice de 0 a 13)
; =======================================================================
Switch_Mensagem:
Case_0:
    CPI AUX, 0          ; É o índice 0?
    BRNE Case_1
    LDI OFFSET, 0       ; Se sim, carrega deslocamento 0 (Letra 'C')
    RJMP Ler_Tabela
Case_1:
    CPI AUX, 1
    BRNE Case_2
    LDI OFFSET, 1       ; Letra 'o'
    RJMP Ler_Tabela
Case_2:
    CPI AUX, 2
    BRNE Case_3
    LDI OFFSET, 2       ; Letra 'P'
    RJMP Ler_Tabela
Case_3:
    CPI AUX, 3
    BRNE Case_4
    LDI OFFSET, 3       ; Letra 'A'
    RJMP Ler_Tabela
Case_4:
    CPI AUX, 4
    BRNE Case_5
    LDI OFFSET, 4       ; Letra 'd'
    RJMP Ler_Tabela
Case_5:
    CPI AUX, 5
    BRNE Case_6
    LDI OFFSET, 5       ; Letra 'b'
    RJMP Ler_Tabela
Case_6:
    CPI AUX, 6
    BRNE Case_7
    LDI OFFSET, 6       ; Letra 'r'
    RJMP Ler_Tabela
Case_7:
    CPI AUX, 7
    BRNE Case_8
    LDI OFFSET, 7       ; Letra 'S' (parecido com 5)
    RJMP Ler_Tabela
Case_8:
    CPI AUX, 8
    BRNE Case_9
    LDI OFFSET, 8       ; Letra 'I' (parecido com 1)
    RJMP Ler_Tabela
Case_9:
    CPI AUX, 9
    BRNE Case_10
    LDI OFFSET, 9       ; Letra 'L'
    RJMP Ler_Tabela
Case_10:
    CPI AUX, 10
    BRNE Case_11
    LDI OFFSET, 10      ; Caractere '-'
    RJMP Ler_Tabela
Case_11:
    CPI AUX, 11
    BRNE Case_12
    LDI OFFSET, 11      ; Número '2'
    RJMP Ler_Tabela
Case_12:
    CPI AUX, 12
    BRNE Case_13
    LDI OFFSET, 12      ; Número '0'
    RJMP Ler_Tabela
Case_13:
    CPI AUX, 13
    BRNE Default_Case
    LDI OFFSET, 13      ; Número '6'
    RJMP Ler_Tabela

Default_Case:
    ; Se o contador por acaso passar de 13, força o reset
    LDI CONTADOR, 0     
    RJMP Principal

; =======================================================================
; ACESSO À TABELA, EXIBIÇÃO E INCREMENTO
; =======================================================================
Ler_Tabela:
    ; Inicializa o Ponteiro Z com o endereço base da Tabela (deslocado << 1)
    LDI ZH, HIGH(Tabela_Display << 1)
    LDI ZL, LOW(Tabela_Display << 1)

    ; Soma o OFFSET ao ponteiro ZL
    ADD ZL, OFFSET
    BRCC Sem_Carry      ; Trata o Carry se estourar
    INC ZH
Sem_Carry:
    
    ; Lê o código hexadecimal da Flash e joga no Display
    LPM DADO, Z
    OUT PORTD, DADO

    ; Chama o atraso para a letra ficar visível e passar gradualmente
    RCALL Atraso        

    ; Prepara para a próxima letra
    INC CONTADOR        
    CPI CONTADOR, 14    ; Já exibiu todas as 14 letras únicas?
    BRNE Pula_Reset
    LDI CONTADOR, 0     ; Se sim, RESETA a animação para o início
Pula_Reset:
    RJMP Principal      ; Roda o laço novamente

; =======================================================================
; ROTINA DE ATRASO (Aprox. 0.5s para 16 MHz)
; =======================================================================
Atraso:
    LDI R21, 40
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
; TABELA NA MEMÓRIA FLASH (CÁTODO COMUM)
; Sequência: C, o, P, A, d, b, r, S, I, L, -, 2, 0, 6
; =======================================================================
Tabela_Display:
    .db 0x39, 0x5C, 0x73, 0x77, 0x5E, 0x7C, 0x50, 0x6D, 0x06, 0x38, 0x40, 0x5B, 0x3F, 0x7D