; Author - Saadman Sakib


.equ SREG, 0x3f	   ; Define SREG label

.equ PORTB, 0x05   ; Define PORTB label, the pins of PORTB can be used either to communicate incoming data (0:input mode) or outgoing data (1:output mode)
.equ DDRB, 0x04    ; Define DDRB label, as PORTB can be used either in 0 or 1, we need to specify the direction of data flow for the I/O on PORTB
                   ; PORTB's Data Direction Register is DDRB

.equ PORTD, 0x0B   ; Define PORTD label, the pins of PORTB can be used either to communicate incoming data (0:input mode) or outgoing data (1:output mode)
.equ DDRD, 0x0A    ; Define DDRD label, as PORTD can be used either in 0 or 1, we need to specify the direction of data flow for the I/O on PORTB
                   ; PORTD's Data Direction Register is DDRD

.org 0                    ; specify the start address

main:     ldi r16,0       ; Set register r16 to zero
	  out SREG,r16    ; Copy contents of r16 to SREG, this clears SREG and resets system status

	  ldi r16,0x0F    ; Set register r16 to hexadecimal number 0x0F. This hex represents 0000 1111 in binary
                          ; This is necessary because we connected LEDs to bits 0-3 on PORTB and we need to set these bits to be in output mode
	  out DDRB,r16    ; Copy contents of r16 to DDRB, which writes a binary '1' to the bit positions 0-3 and all other bit positions to a binary '0' on DDRB
                          ; Therefore, now the direction of data flow on PORTB bits 0-3 is in output mode (1:HIGH) and bits 4-7 is in input mode (0:LOW)

          ldi r16,0xF0    ; Set register r16 to hexadecimal number 0xF0. This hex represents 1111 0000 in binary
                          ; This is necessary because we connected LEDs to bits 4-7 on PORTD and we need to set these bits to be in output mode
          out DDRD,r16    ; Copy contents of r16 to DDRB, which writes a binary '1' to the bit positions 0-3 and all other bit positions to a binary '0' on DDRD
                          ; Therefore, now the direction of data flow on PORTD bits 0-3 is in input mode (0:LOW) and bits 4-7 is in output mode (1:HIGH)

          ldi r16,0xDB    ; Set register r16 to hexadecimal number 0xDB
	  out PORTB,r16   ; Copy contents of r16 to PORTB
          out PORTD,r16   ; Copy contents of r16 to PORTB


mainloop: rjmp mainloop   ; Jump back to mainloop address, therefore loop continuously
