; Author - Saadman Sakib


.equ SREG, 0x3f	   ; define SREG label
.equ PORTB, 0x05   ; define PORTB label, the pins of PORTB can be used either to communicate incoming data (input mode) or outgoing data (output mode)
.equ DDRB, 0x04    ; define DDRB label, as PORTB can be used either in input or output mode, we need to specify the direction of data flow for our I/O on PORTB. PORTB's Data Direction Register is DDRB

.org 0                    ; specify the start address

main:     ldi r16,0       ; set register r16 to zero
	  out SREG,r16    ; copy contents of r16 to SREG, this clears SREG

	  ldi r16,0x01    ; set register r16 to hexadecimal number 0x01. This hex represents 0000 0001 in binary, this binary representation is necessary because we connected a LED via PB0 (D8) pin to bit position 0 on PORTB and we need to set this bit to be in output mode on the DDRB
	  out DDRB,r16    ; copy contents of r16 to DDRB, which writes a binary '1' to the bit position 0 and all other bit positions to a binary '0' on DDRB
                          ; therefore, now the direction of data flow on PORTB bits 0-3 is in output mode (1) and bits 4-7 is in input mode (0)



mainloop: ldi r16,0x01    ; set register r16 to hexadecimal number 0x01 - 0000 0001
          out PORTB,r16   ; copy contents of r16 to PORTB

          ldi r19,40
          call delay

          ldi r16,0x00    ; set register r16 to hexadecimal number 0x00 - 0000 0000
          out PORTB,r16   ; copy contents of r16 to PORTB

          ldi r19,20
          call delay

          rjmp mainloop



delay:            ldi r17,255
                  ldi r18,126
loop:             nop
                  dec r17
                  cpi r17,0
                  brne loop
                  ldi r17,255
                  dec r18
                  cpi r18,0
                  brne loop
                  ldi r18,126
                  dec r19
                  cpi r19,0
                  brne loop
                  ret
