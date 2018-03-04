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

      	  ldi r16,0x20    ; set register r16 to hexadecimal number 0x20. This hex represents 0010 0000 in binary, this structure of binary will be used to set only the 5th bit on DDRB to output mode (1)
	  out DDRB,r16    ; copy contents of r16 to DDRB, which writes a binary 1 to the 5th bit on DDRB and all other bits to a binary 0


          ldi r16,0x20    ; set register r16 to hexadecimal number 0x20
          out PORTB,r16   ; copy contents of r16 to PORTB, which sets bit 5 to a binary 1. Bit 5 of PORTB will be control the state of the LED, as it is set to a binary 1 (output mode), the LED will turn on


mainloop: rjmp mainloop   ; jump back to mainloop address this results in looping endlessly
