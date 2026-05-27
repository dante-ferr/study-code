.nolist
.include "m328Pdef.inc"
.list

; --- CONSTANTES ---
.equ LCD_ADDR = 0x7C        ; Endereço I2C de escrita do LCD (0x3E << 1)
.equ SDA_PIN  = 4           ; Pino SDA (PC4)
.equ SCL_PIN  = 5           ; Pino SCL (PC5)

; --- SEGMENTOS DE MEMÓRIA SRAM ---
.dseg
.org SRAM_START
digit_tens:     .byte 1     ; Padrão de segmentos das Dezenas
digit_units:    .byte 1     ; Padrão de segmentos das Unidades
current_state:  .byte 1     ; Estado ativo: 0=Idle, 1=A, 2=B, 3=Select
count:          .byte 1     ; Contador de teste (00-99)
tick_counter:   .byte 1     ; Temporizador para tarefas em segundo plano
anim_frame:     .byte 1     ; Frame ativo da animação da matriz

; --- CÓDIGO FONTE (FLASH) ---
.cseg
.org 0x0000
    rjmp reset

reset:
    ; Inicializa o Ponteiro de Pilha (Stack)
    ldi r16, high(RAMEND)
    out SPH, r16
    ldi r16, low(RAMEND)
    out SPL, r16

    ; Configuração de Direção de Portas (DDR)
    ; PD0: Entrada, PD1-PD7: Saídas
    ldi r16, 0xFE
    out DDRD, r16
    
    ; PB0-PB5: Saídas (Segmentos e Controles de Dígitos)
    ldi r16, 0x3F
    out DDRB, r16
    
    ; PC0: Entrada (ADC), PC1-PC3: Saídas (MAX7219), PC4-PC5: Entrada (I2C)
    ldi r16, 0x0E           
    out DDRC, r16

    ; Inicialização de Variáveis na SRAM
    ldi r16, 0
    sts current_state, r16
    sts count, r16
    sts tick_counter, r16
    sts anim_frame, r16

    ; Desliga o buzzer e LEDs inicialmente
    in r16, PORTD
    andi r16, 0xE1
    out PORTD, r16

    ; Desativa displays de 7 segmentos (Catodo Comum desliga em HIGH)
    in r16, PORTB
    ori r16, 0x30
    out PORTB, r16

    ; Inicializa o ADC (Pino A0)
    ldi r16, (1<<REFS0) | (1<<ADLAR) ; Referência AVCC, ajuste à esquerda
    sts ADMUX, r16
    ldi r16, (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0) ; Prescaler 128
    sts ADCSRA, r16

    ; Atraso para estabilização das linhas de energia
    ldi r22, 100
    rcall delay_ms

    ; Inicialização de Periféricos
    rcall lcd_init
    rcall lcd_clear
    rcall max7219_init

    ; Força carregamento do estado inicial
    ldi r21, 0
    rcall trigger_state_action

; --- LOOP PRINCIPAL ---
main_loop:
    ; Executa conversão do ADC no canal A0
    lds r16, ADCSRA
    ori r16, (1<<ADSC)
    sts ADCSRA, r16

wait_adc:
    lds r16, ADCSRA
    sbrc r16, ADSC
    rjmp wait_adc

    lds r16, ADCH           ; Armazena leitura de 8 bits

    ; Classifica o botão com base no divisor de tensão
    ldi r21, 0              
    cpi r16, 40             ; Botão A (~0V)
    brlo is_button_a
    cpi r16, 155            ; Botão B (~2.5V)
    brlo is_button_b
    cpi r16, 215            ; Botão Select (~3.4V)
    brlo is_button_select
    rjmp eval_state

is_button_a:
    ldi r21, 1
    rjmp eval_state
is_button_b:
    ldi r21, 2
    rjmp eval_state
is_button_select:
    ldi r21, 3

eval_state:
    ; Atualiza hardware apenas em caso de mudança de estado
    lds r20, current_state
    cp r21, r20
    breq state_stable
    sts current_state, r21
    rcall trigger_state_action

state_stable:
    ; Executa varredura física do display de 7 segmentos
    rcall show_display

    ; Incrementa temporizador
    lds r16, tick_counter
    inc r16
    cpi r16, 60             ; ~240ms por incremento
    brne save_tick
    ldi r16, 0
    
    ; Processa tarefas de fundo apenas no modo ocioso (Idle)
    lds r17, current_state
    tst r17
    brne save_tick
    rcall idle_periodic_task

save_tick:
    sts tick_counter, r16
    rjmp main_loop

; --- MULTIPLEXAÇÃO DOS DISPLAYS DE 7 SEGMENTOS ---
show_display:
    ; Desliga ambos os dígitos para evitar efeito fantasma (HIGH em PB4/PB5)
    in r16, PORTB
    ori r16, 0x30
    out PORTB, r16

    ; --- Passo 1: Mostra Dezenas ---
    lds r16, digit_tens
    rcall set_segments
    in r17, PORTB
    andi r17, 0xEF          ; Liga Dezenas (PB4 = 0)
    ori r17, 0x20           ; Desliga Unidades (PB5 = 1)
    out PORTB, r17
    ldi r22, 2              ; Varre por 2ms
    rcall delay_ms

    ; Desliga ambos os dígitos
    in r16, PORTB
    ori r16, 0x30
    out PORTB, r16

    ; --- Passo 2: Mostra Unidades ---
    lds r16, digit_units
    rcall set_segments
    in r17, PORTB
    ori r17, 0x10           ; Desliga Dezenas (PB4 = 1)
    andi r17, 0xDF          ; Liga Unidades (PB5 = 0)
    out PORTB, r17
    ldi r22, 2              ; Varre por 2ms
    rcall delay_ms
    ret

; --- MAPEADOR FISICO DE SEGMENTOS (PORTD e PORTB) ---
set_segments:
    ; Segmentos gfedcba mapeados diretamente nos pinos:
    ; PD5, PD6, PD7 <- bits 0, 1, 2
    ; PB0, PB1, PB2, PB3 <- bits 3, 4, 5, 6
    in r17, PORTD
    andi r17, 0x1F          
    mov r18, r16
    andi r18, 0x07          
    swap r18                
    lsl r18                 
    or r17, r18
    out PORTD, r17

    in r17, PORTB
    andi r17, 0xF0          
    mov r18, r16
    lsr r18
    lsr r18
    lsr r18                 
    andi r18, 0x0F
    or r17, r18
    out PORTB, r17
    ret

; --- TAREFAS DE SEGUNDO PLANO (MODO IDLE) ---
idle_periodic_task:
    ; Incrementa contagem de teste
    lds r18, count
    inc r18
    cpi r18, 100
    brne save_count
    ldi r18, 0
save_count:
    sts count, r18
    rcall convert_digits

    ; Avança animação da matriz
    lds r18, anim_frame
    inc r18
    andi r18, 0x07          
    sts anim_frame, r18
    rcall update_matrix_idle
    ret

; --- CONVERSOR BINÁRIO PARA BCD (DEZENAS/UNIDADES) ---
convert_digits:
    lds r16, count
    ldi r17, 0              
div_loop:
    cpi r16, 10
    brlo div_done
    subi r16, 10
    inc r17
    rjmp div_loop
div_done:
    push r16                ; Salva unidades na pilha antes que r16 seja corrompido
    mov r22, r17
    rcall get_segment_pattern
    sts digit_tens, r16
    
    pop r22                 ; Recupera unidade preservada para decodificar
    rcall get_segment_pattern
    sts digit_units, r16
    ret

get_segment_pattern:
    ldi ZH, high(segment_table*2)
    ldi ZL, low(segment_table*2)
    add ZL, r22
    ldi r16, 0
    adc ZH, r16
    lpm r16, Z
    ret

; --- ATUALIZAÇÕES DOS ESTADOS FISICOS DO HARDWARE ---
trigger_state_action:
    cpi r21, 0
    breq action_idle
    cpi r21, 1
    breq action_a
    cpi r21, 2
    breq action_b
    cpi r21, 3
    breq action_select
    ret

action_idle:
    in r16, PORTD
    andi r16, 0xF1
    out PORTD, r16
    
    rcall lcd_clear
    ldi ZH, high(str_idle*2)
    ldi ZL, low(str_idle*2)
    rcall print_string
    
    rcall convert_digits
    ret

action_a:
    ; LED Vermelho (PD2 = HIGH)
    in r16, PORTD
    andi r16, 0xF1
    ori r16, 0x04
    out PORTD, r16
    
    rcall lcd_clear
    ldi ZH, high(str_btn_a*2)
    ldi ZL, low(str_btn_a*2)
    rcall print_string
    
    ; Mostra "AA" nos displays
    ldi r16, 0x77
    sts digit_tens, r16
    sts digit_units, r16
    
    rcall fill_matrix_left
    
    ; Beep agudo curto
    ldi r16, 40
    ldi r17, 90
    rcall play_tone
    ret

action_b:
    ; LED Azul (PD3 = HIGH)
    in r16, PORTD
    andi r16, 0xF1
    ori r16, 0x08
    out PORTD, r16
    
    rcall lcd_clear
    ldi ZH, high(str_btn_b*2)
    ldi ZL, low(str_btn_b*2)
    rcall print_string
    
    ; Mostra "bb" nos displays
    ldi r16, 0x7C
    sts digit_tens, r16
    sts digit_units, r16
    
    rcall fill_matrix_right
    
    ; Beep médio curto
    ldi r16, 80
    ldi r17, 60
    rcall play_tone
    ret

action_select:
    ; LED Verde (PD1 = HIGH)
    in r16, PORTD
    andi r16, 0xF1
    ori r16, 0x02
    out PORTD, r16
    
    rcall lcd_clear
    ldi ZH, high(str_select*2)
    ldi ZL, low(str_select*2)
    rcall print_string
    
    ; Mostra "SS" nos displays
    ldi r16, 0x6D
    sts digit_tens, r16
    sts digit_units, r16
    
    rcall fill_matrix_center
    
    ; Beep grave curto
    ldi r16, 140
    ldi r17, 40
    rcall play_tone
    ret

; --- CONTROLE FISICO DO BUZZER ---
play_tone:
    sbi PORTD, 4
    rcall tone_delay
    cbi PORTD, 4
    rcall tone_delay
    dec r17
    brne play_tone
    ret

tone_delay:
    mov r18, r16
td_loop:
    dec r18
    brne td_loop
    ret

; --- DRIVER I2C POR SOFTWARE (BIT-BANGING) ---
i2c_init:
    ; Garante nível baixo nos registradores PORTC4/PORTC5
    in r16, PORTC
    andi r16, ~((1<<SDA_PIN)|(1<<SCL_PIN))
    out PORTC, r16
    ; Define pinos inicialmente como entradas (linhas em alta impedância)
    in r16, DDRC
    andi r16, ~((1<<SDA_PIN)|(1<<SCL_PIN))
    out DDRC, r16
    ret

sda_high:
    in r16, DDRC
    andi r16, ~(1<<SDA_PIN) ; Configura pino como Entrada (puxado a 5V)
    out DDRC, r16
    ret

sda_low:
    in r16, DDRC
    ori r16, (1<<SDA_PIN)  ; Configura pino como Saída (drena para GND)
    out DDRC, r16
    ret

scl_high:
    in r16, DDRC
    andi r16, ~(1<<SCL_PIN) ; Configura pino como Entrada (puxado a 5V)
    out DDRC, r16
    ret

scl_low:
    in r16, DDRC
    ori r16, (1<<SCL_PIN)  ; Configura pino como Saída (drena para GND)
    out DDRC, r16
    ret

i2c_start:
    rcall sda_high
    rcall scl_high
    rcall i2c_delay
    rcall sda_low
    rcall i2c_delay
    rcall scl_low
    rcall i2c_delay
    ret

i2c_stop:
    rcall sda_low
    rcall i2c_delay
    rcall scl_high
    rcall i2c_delay
    rcall sda_high
    rcall i2c_delay
    ret

i2c_write:
    ldi r18, 8
i2c_write_loop:
    sbrs r17, 7
    rjmp i2c_bit_zero
    rcall sda_high
    rjmp i2c_bit_clk
i2c_bit_zero:
    rcall sda_low
i2c_bit_clk:
    rcall i2c_delay
    rcall scl_high
    rcall i2c_delay
    rcall scl_low
    lsl r17
    dec r18
    brne i2c_write_loop
    
    ; Emite pulso extra de SCL para ignorar resposta de ACK
    rcall sda_high
    rcall i2c_delay
    rcall scl_high
    rcall i2c_delay
    rcall scl_low
    rcall i2c_delay
    ret

i2c_delay:
    push r20
    ldi r20, 15
i2c_delay_loop:
    dec r20
    brne i2c_delay_loop
    pop r20
    ret

; --- CONTROLADOR DO LCD AIP31068 ---
lcd_init:
    rcall i2c_init
    ldi r22, 50             ; Tempo de estabilização do LCD após boot
    rcall delay_ms
    
    ldi r16, 0x38           ; Function Set (Modo 8 bits, 2 linhas, fonte 5x8)
    rcall lcd_cmd
    ldi r16, 0x0C           ; Liga display, oculta cursor
    rcall lcd_cmd
    ldi r16, 0x06           ; Cursor em modo incremental automático
    rcall lcd_cmd
    ret

lcd_cmd:
    push r16
    rcall i2c_start
    ldi r17, LCD_ADDR
    rcall i2c_write
    ldi r17, 0x80           ; Código de controle para comandos (Co=1, RS=0)
    rcall i2c_write
    pop r17
    rcall i2c_write
    rcall i2c_stop
    ret

lcd_data:
    push r16
    rcall i2c_start
    ldi r17, LCD_ADDR
    rcall i2c_write
    ldi r17, 0x40           ; Código de controle para dados (Co=0, RS=1)
    rcall i2c_write
    pop r17
    rcall i2c_write
    rcall i2c_stop
    ret

lcd_clear:
    ldi r16, 0x01
    rcall lcd_cmd
    ldi r22, 2
    rcall delay_ms
    ret

print_string:
    lpm r16, Z+
    tst r16
    breq print_done
    rcall lcd_data
    rjmp print_string
print_done:
    ret

; --- CONTROLADOR MAX7219 (SOFTWARE SPI) ---
max7219_init:
    ldi r17, 0x0C           ; Shutdown Register
    ldi r16, 0x01           ; Modo de operação normal
    rcall max7219_send

    ldi r17, 0x09           ; Decode Mode
    ldi r16, 0x00           ; Sem decodificação BCD (modo matriz bruta)
    rcall max7219_send

    ldi r17, 0x0A           ; Intensity
    ldi r16, 0x03           ; Ajuste de brilho
    rcall max7219_send

    ldi r17, 0x0B           ; Scan Limit
    ldi r16, 0x07           ; Varre todas as 8 linhas
    rcall max7219_send

    ; Limpa todas as colunas
    ldi r23, 1
clear_matrix_loop:
    mov r17, r23
    ldi r16, 0x00
    rcall max7219_send
    inc r23
    cpi r23, 9
    brne clear_matrix_loop
    ret

max7219_send:
    cbi PORTC, 3            ; CS = LOW
    mov r18, r17
    rcall spi_send_byte
    mov r18, r16
    rcall spi_send_byte
    sbi PORTC, 3            ; CS = HIGH
    ret

spi_send_byte:
    ldi r19, 8
spi_loop:
    cbi PORTC, 2            ; CLK = LOW
    sbrs r18, 7
    rjmp spi_send_zero
    sbi PORTC, 1            ; DIN = HIGH
    rjmp spi_clk_pulse
spi_send_zero:
    cbi PORTC, 1            ; DIN = LOW
spi_clk_pulse:
    lsl r18
    sbi PORTC, 2            ; CLK = HIGH
    dec r19
    brne spi_loop
    ret

; --- ANIMAÇÕES GEOMÉTRICAS DA MATRIZ ---
update_matrix_idle:
    lds r22, anim_frame
    inc r22                 
    ldi r23, 1
matrix_sweep:
    mov r17, r23
    cp r23, r22
    breq row_on
    ldi r16, 0x00
    rjmp send_row
row_on:
    ldi r16, 0xFF
send_row:
    rcall max7219_send
    inc r23
    cpi r23, 9
    brne matrix_sweep
    ret

fill_matrix_left:
    ldi r23, 1
fml_loop:
    mov r17, r23
    ldi r16, 0xF0           ; Metade esquerda acesa
    rcall max7219_send
    inc r23
    cpi r23, 9
    brne fml_loop
    ret

fill_matrix_right:
    ldi r23, 1
fmr_loop:
    mov r17, r23
    ldi r16, 0x0F           ; Metade direita acesa
    rcall max7219_send
    inc r23
    cpi r23, 9
    brne fmr_loop
    ret

fill_matrix_center:
    ldi r23, 1
fmc_loop:
    mov r17, r23
    ldi r16, 0x3C           ; Bloco central aceso
    rcall max7219_send
    inc r23
    cpi r23, 9
    brne fmc_loop
    ret

; --- ROTINAS DE ATRASO BASE DE TEMPO (16 MHz) ---
delay_1ms:
    ldi r24, low(4000)
    ldi r25, high(4000)
d1ms_loop:
    sbiw r24, 1
    brne d1ms_loop
    ret

delay_ms:
dms_loop:
    rcall delay_1ms
    dec r22
    brne dms_loop
    ret

; --- MAPA DE CARACTERES DOS SEGMENTOS ---
segment_table:
    .db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

; Alinhamento das strings com padding nulo para garantir tamanho de palavra par
str_idle:   .db "ROLETA FRANCESA ", 0, 0
str_btn_a:  .db "BOTAO A PRESS   ", 0, 0
str_btn_b:  .db "BOTAO B PRESS   ", 0, 0
str_select: .db "SELECT PRESS    ", 0, 0