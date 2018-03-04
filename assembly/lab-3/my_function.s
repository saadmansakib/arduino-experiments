; Author - Saadman Sakib
;
;
; my_function.s - reads external digital input on the Arduino, uses branching to decide which mathematical operations to apply and writes the results out to PORTB.
; This assembly program accepts input from PORTC with the lower 4 bits encoding a number from 0 to 15.
; Then writes the output of a piece-wise function to PORTB using the lower 4 bits encoding a number from 0 to 15.
; Finally, lights up LEDs connected externally to PORTB in the expected pattern for all 16 input values, resulting in successful implementation of a piece-wise function using assembly code.



; specify equivalent symbols
.equ SREG, 0x3f            ; Status register
.equ DDRB, 0x04            ; Data Direction Register for PORTB
.equ PORTB, 0x05           ; Address of PORTB
.equ PINC, 0x06            ; Data Direction Register for PORTC
.equ DDRC, 0x07            ; Address of input register for PORTC


; specify the start address
.org 0


; reset system status
main:      ldi r16,0       ; set register r16 to 0
           out SREG,r16    ; copy contents of r16 to SREG, which clears SREG
           ldi r17,10      ; set register r17 to 10

	   ; configure PORTB for output
           ldi r16,0x0F    ; copy hexadecimal 0x0F, binary representation 0000 1111 to r16
           out DDRB,r16    ; write r16 to DDRB, setting up bits 0 to 3 in output mode (1)

           ; configure PORTC for input
           ldi r16,0xF0    ; copy hexadecimal 0xF0, binary representation 1111 0000 to r16
           out DDRC,r16    ; write r16 to DDRC, setting up bits 0 to 3 in input mode (0)

           ; reads from external pins of PORTC to r16
           in r16,PINC     ; write contents (values) from the input register for PORTC (i.e. PINC) to register r16

           cpi r16,4       ; compare r16 with 4
           brlo lessthan   ; branch if r16 less than 4, the program execution branches to 'lessthan' memory address label
           ldi r16,0x0E    ; else, line 30 is executed which sets register r16 to (hexadecimal-0x0E, decimal-14)
           rjmp done       ; jump back to done address, affects the program flow by exiting loop
lessthan:  add r16,r17     ; if (r16 < 4), line 32 is executed which adds r17 to r16 (r16=r16+r17)
done:      nop             ; No Operation instruction, (does nothing)

           out PORTB,r16   ; copy contents of r16 to PORTB, thereby lighting up the LEDs
mainloop:  rjmp mainloop   ; jump back to mainloop address, loops endlessly
