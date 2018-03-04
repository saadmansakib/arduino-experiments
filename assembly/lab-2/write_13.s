; Author - Saadman Sakib
; 
;
; led_on.s : switches on the arduino LED.


; specify equivalent symbols
.equ SREG, 0x3f	   ; define SREG label
.equ PORTB, 0x05   ; define PORTB label, the pins of PORTB can be used either to communicate incoming data (input mode) or outgoing data (output mode)
.equ DDRB, 0x04    ; define DDRB label, as PORTB can be used in input or output modes, we need to specify the direction of data flow for our I/O on PORTB. PORTB's Data Direction Register is DDRB

; specify the start address
.org 0
; reset system status
main:     ldi r16,0       ; set register r16 to zero
		  out SREG,r16    ; copy contents of r16 to SREG, which clears SREG

		  ldi r16,0x0F    ; set register r16 to hexadecimal number 0x0F. This hex represents 0000 1111 in binary, this structure of binary will be used to set bits 0-3 on DDRB to output mode (1)
		  out DDRB,r16    ; copy contents of r16 to DDRB


          ldi r16,0x0D    ; set register r16 to hexadecimal number 0x0D, decimal 13, binary 0000 1101
		  out PORTB,r16   ; copy contents of r16 to PORTB, which writes bits 4-7 to a binary 0, bits 3,2,0 to a binary 1 and bit 1 to a binary 0. Bits 0-3 of PORTB will control the state of the 4 external LEDs as they are connected to these bits only. as it is set to a binary 1 (output mode), the LEDs on bits 3,2,0 will turn on.


mainloop: rjmp mainloop   ; jump back to mainloop address this results in looping endlessly
