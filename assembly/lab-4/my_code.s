; Author - Saadman Sakib
;
;
; my_code.s - is an assembly program to transmit the Morse code sequence via a PB0 (D8) pin of PORTB LED for 3 letters [S,A,A].
; A 10ms delay parameterised sub-routine (delay) is being called in 'mainloop' to create variable delays (200,600)ms after each LED states (ON,OFF).
; Register r19 is being set with variable parameter values which enables us to delay various lengths at 10ms steps (i.e. 100,200,400,600,etc)ms.
; For perceiving the Morse code, a unit length of 200ms is being used, which means a dot and a same letter space is 200ms, a dash and an inter-letter space is 600ms.
; A certain continuous blinking pattern will be observed on the LED, this represents the Morse code sequence.
; The program will continuosly loop through the 3-letter sequence under the assumption that there is no word break after the 3 letters - [S] [A] [A] [S] [A] ...

.equ SREG, 0x3f	   ; Define SREG label
.equ PORTB, 0x05   ; Define PORTB label, the pins of PORTB can be used either to communicate incoming data (0:input mode) or outgoing data (1:output mode)
.equ DDRB, 0x04    ; Define DDRB label, as PORTB can be used either in 0 or 1, we need to specify the direction of data flow for the I/O on PORTB
                   ; PORTB's Data Direction Register is DDRB

.org 0                    ; Specify the start address

main:     ldi r16,0       ; Set register r16 to zero
          out SREG,r16    ; Copy contents of r16 to SREG, this clears SREG and resets system status

	  ldi r16,0x01    ; Set register r16 to hexadecimal number 0x01. This hex represents 0000 0001 in binary
                          ; This is necessary because we connected the LED to bit position 0 on PORTB and we need to set this bit to be in output mode

          out DDRB,r16    ; Copy contents of r16 to DDRB, which writes a binary '1' to the bit position 0 and all other bit positions to a binary '0' on DDRB
                          ; Therefore, now the direction of data flow on PORTB bit 0 is in output mode (1:HIGH) and bits 1-7 is in input mode (0:LOW)



mainloop:

; For letter [S]

          ldi r16,0x01    ; Set register r16 to hex 0x01, binary representation 0000 0001
          out PORTB,r16   ; Copy contents of r16 to PORTB, therefore this turns the LED ON                          - DOT
          ldi r19,20      ; Set register r19 to 20, 20 is a parameter value, necessary for (20x10)ms = 200ms delay
          call delay      ; Call sub-routine

          ldi r16,0x00    ; Set register r16 to hex 0x00, binary representation 0000 0000
          out PORTB,r16   ; Copy contents of r16 to PORTB, therefore this turns the LED OFF                         - SAMELETTERSPACE
          ldi r19,20
          call delay

          ldi r16,0x01
          out PORTB,r16   ;                                                                                         - DOT
          ldi r19,20
          call delay

          ldi r16,0x00
          out PORTB,r16   ;                                                                                         - SAMELETTERSPACE
          ldi r19,20
          call delay

          ldi r16,0x01
          out PORTB,r16   ;                                                                                         - DOT
          ldi r19,20
          call delay


;=====================================================================================================================================;

; For inter-letter space between the letters [S] and [A]

          ldi r16,0x00    ; Set register r16 to hex 0x00, binary representation 0000 0000
          out PORTB,r16   ; Copy contents of r16 to PORTB, therefore this turns the LED OFF                         - INTER-LETTERSPACE
          ldi r19,60      ; Set register r19 to 60, 60 is a parameter value, necessary for (60x10)ms = 600ms delay
          call delay


;=====================================================================================================================================;

; For letter [A]

          ldi r16,0x01
          out PORTB,r16   ;                                                                                         - DOT
          ldi r19,20
          call delay

          ldi r16,0x00
          out PORTB,r16   ;                                                                                         - SAMELETTERSPACE
          ldi r19,20
          call delay

          ldi r16,0x01
          out PORTB,r16   ;                                                                                         - DASH
          ldi r19,60
          call delay


;=====================================================================================================================================;

; For inter-letter space between the letters [A] and [A]

          ldi r16,0x00
          out PORTB,r16   ;                                                                                         - INTER-LETTERSPACE
          ldi r19,60
          call delay


;=====================================================================================================================================;

; For letter [A]

          ldi r16,0x01
          out PORTB,r16   ;                                                                                         - DOT
          ldi r19,20
          call delay

          ldi r16,0x00
          out PORTB,r16   ;                                                                                         - SAMELETTERSPACE
          ldi r19,20
          call delay

          ldi r16,0x01
          out PORTB,r16   ;                                                                                         - DASH
          ldi r19,60
          call delay


;=====================================================================================================================================;

; For inter-letter space between the letters [A] and [S]

          ldi r16,0x00
          out PORTB,r16   ;                                                                                         - INTER-LETTERSPACE
          ldi r19,60
          call delay


;=====================================================================================================================================;


          rjmp mainloop   ; Jump back to mainloop address (i.e. to letter [S]), therefore loop continuously




; Parameterised ten millisecond (delay) sub-routine is used to create variable delays

delay:    ldi r17,255     ; Set register r17 to 255
          ldi r18,126     ; Set register r18 to 126

loop:     nop             ; Branch destination (do nothing)
          dec r17         ; Decrement register r17 (subtracts 1)
          cpi r17,0       ; Compare register r17 to 0
          brne loop       ; Branch if r17 not equal to 0, otherwise execute Line 146
          ldi r17,255     ; Set register r17 back to 255
          dec r18         ; Decrement register r18 (subtracts 1)
          cpi r18,0       ; Compare register r18 to 0
          brne loop       ; Branch if r18 not equal to 0, otherwise execute Line 150
          ldi r18,126     ; Set register r18 back to 126
          dec r19         ; Decrement register r19 (subtracts 1)
          cpi r19,0       ; Compare register r19 to 0
          brne loop       ; Branch if r19 not equal to 0, otherwise execute Line 154
          ret             ; Return from sub-routine
