; Author - Saadman Sakib
;
;
; Line 3 sets register 16 to a value of zero.
; Line 4 copies the whole contents of register 16 to status register
; Line 5 the program looks for the word mainloop and loops continuously
; Therefore, this program resets the SREG


.equ SREG, 0x3f           ; define SREG label
.org 0
main:     ldi r16,0       ; set register r16 to zero
          out SREG,r16    ; copy contents of r16 to SREG
mainloop: rjmp mainloop   ; jump to mainloop address
