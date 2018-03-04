; Author - Saadman Sakib
;
;
; I have learnt how to use documentation from manufacturers to undertstand the connections between the micro-processor and peripheral circuitry on which it is mounted.
; Also, how I/O is handled in the Atmel family of microprocessors, including specifying data flow direction.
; In addition to, how to write a simple assembly program to set and reset bits on a simple I/O interface.
; Moreover, how to connect external LEDS to the Arduino micro-controller and set up a simple Arduino circuit.
; Finally, how to write a number out to the LEDs connected to the Arduino micro-controller.


; my_k_num.s : switches on the arduino LEDs and writes the digits from my k-number out to the LEDs so fast that only the last digit of my k-number (4) is displayed on the LEDs.
; As the digits are being written out to the LEDs faster than the human eye can perceive it will only appear as if the LED connected to the D10 pin of PORTB is lit.
; This assembly program will output all of the numerical digits of my k-number in the correct sequence.
; This is a simple program to control the Arduino I/O interface.



.equ SREG, 0x3f	   ; define SREG label
.equ PORTB, 0x05   ; define PORTB label, the pins of PORTB can be used either to communicate incoming data (input mode) or outgoing data (output mode)
.equ DDRB, 0x04    ; define DDRB label, as PORTB can be used either in input or output mode, we need to specify the direction of data flow for our I/O on PORTB. PORTB's Data Direction Register is DDRB

.org 0                    ; specify the start address

main:     ldi r16,0       ; set register r16 to zero
	  out SREG,r16    ; copy contents of r16 to SREG, this clears SREG

          ldi r16,0x0F    ; set register r16 to hexadecimal number 0x0F. This hex represents 0000 1111 in binary, this binary representation is necessary because we connected LEDs to bits 0-3 on PORTB and we need to set these bits to be in output mode on the DDRB
	  out DDRB,r16    ; copy contents of r16 to DDRB, which writes a binary 1 to the bit positions 0,1,2,3 and all other bit positions to a binary 0 on DDRB
                          ; therefore, now the direction of data flow on PORTB bits 0-3 is in output mode (1) and bits 4-7 is in input mode (0)

          ldi r16,0x01    ; set register r16 to hexadecimal number 0x01 - 0000 0001
          out PORTB,r16   ; copy contents of r16 to PORTB, if this program was upto here only, then the LED connected to D8 pin of PORTB would stay lit

	  ldi r16,0x06    ; set register r16 to hexadecimal number 0x06 - 0000 0110
          out PORTB,r16   ; copy contents of r16 to PORTB

	  ldi r16,0x03    ; set register r16 to hexadecimal number 0x03 - 0000 0011
          out PORTB,r16   ; copy contents of r16 to PORTB, if this program was upto here only, then the LEDs connected to D8 and D9 pins would stay lit

          ldi r16,0x00    ; set register r16 to hexadecimal number 0x00 - 0000 0000
          out PORTB,r16   ; copy contents of r16 to PORTB, if this program was upto here only, then the LEDs would stay turned off entirely

	  ldi r16,0x06    ; set register r16 to hexadecimal number 0x06 - 0000 0110
          out PORTB,r16   ; copy contents of r16 to PORTB

          ldi r16,0x01    ; set register r16 to hexadecimal number 0x01 - 0000 0001
          out PORTB,r16   ; copy contents of r16 to PORTB

	  ldi r16,0x04    ; set register r16 to hexadecimal number 0x04 - 0000 0100
          out PORTB,r16   ; copy contents of r16 to PORTB, as this is the last digit being written from my student number, only one LED connected to the D10 pin of PORTB will stay lit after writing this program to the micro-processor with the Arduino circuit set up

mainloop: rjmp mainloop   ; jump back to mainloop address this results in looping endlessly
