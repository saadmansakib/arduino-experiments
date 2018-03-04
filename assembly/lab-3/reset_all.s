; Author - Saadman Sakib


.equ SREG, 0x3f            ; Status register
.equ DDRB, 0x04            ; Data Direction Register for PORTB
.equ PORTB, 0x05           ; Address of PORTB
.equ PINC, 0x06            ; Data Direction Register for PORTC
.equ DDRC, 0x07            ; Address of input register for PORTC
.equ PORTC, 0x08           ; Address of PORTC

.org 0

main:        ldi r16,0
             ldi r17,0
             ldi r18,0
             ldi r19,0
             ldi r20,0
             ldi r21,0
             ldi r22,0
             ldi r23,0
             ldi r24,0
             ldi r25,0
             ldi r26,0
             ldi r27,0
             ldi r28,0
             ldi r29,0
             ldi r30,0
             ldi r31,0

             out SREG,r16
             out DDRB,r17
             out PORTB,r18
             out DDRC,r19
             out PINC,r20
             out PORTC,r21

mainloop:    rjmp mainloop
