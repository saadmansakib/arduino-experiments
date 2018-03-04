; Author - Saadman Sakib
;
;
;portc_compare.s - does comparing and branching.

; specify equivalent symbols
.equ SREG, 0x3f            ; Status register
.equ DDRB, 0x04            ; Data Direction Register for PORTB
.equ PORTB, 0x05           ; Address of PORTB
.equ PINC, 0x06            ; Data Direction Register for PORTC
.equ DDRC, 0x07            ; Address of input register for PORTC


; specify the start address
.org 0
; reset system status
main:      ldi r16,0       ; set register r16 to zero
           out SREG,r16    ; copy contents of r16 to SREG, which clears SREG
           ldi r17,2
           ldi r18,1
		   ; configure PORTB for output
           ldi r16,0x0F    ; copy hexadecimal 0x0F, binary representation 0000 1111 to r16
           out DDRB,r16    ; write r16 to DDRB, setting up bits 0 to 3 in output mode (1)

           ; configure PORTC for input
           ldi r16,0xF0    ; copy hexadecimal 0xF0, binary representation 1111 0000 to r16
           out DDRC,r16    ; write r16 to DDRC, setting up bits 0 to 3 in input mode (0)

           ; reads from external pins of PORTC to r16
           in r16,PINC     ; write contents (values) from the input register for PORTC (i.e. PINC) to register r16
           cpi r16,8
           brlo lessthan
           sub r16,r18
           rjmp done
lessthan:  add r16,r17
done:      nop

           out PORTB,r16

mainloop:  rjmp mainloop   ; jump back to mainloop address, loops endlessly