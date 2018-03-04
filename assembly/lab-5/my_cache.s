; Author - Saadman Sakib
;
;
; my_cache.s - is an assembly program to decode a memory address for a computer architecture into its separate cache address components.
; A sub-routine (decode) is being used to find the Tag, Block and Word Offset bits for a 22-bit supplied memory address.
; A sub-routine (ledOFF) is being used to turn the LEDs off. Tag, followed by Block and Offset are being displayed via LEDs as bytes.
; A sub-routine (delay) is being used to create variable delays of 0.5 and 1 seconds.
;
; Computer Architecture: byte-addressable 22 bit-address, direct mapped cache of 64K bytes and each block is 8 bytes in size.
; Demonstration binary memory address: 01 1001 1010 0001 0001 1111 = 00011001 10100001 00011111 = r22,r21,r20 respectively
; Block bits: 2^16/2^3 = 2^13 = 13 block bits as 64K = 64x1024 = 2^16
; Offset bits: each block 8 bytes = 2^3 = 3 Offset bits
; Tag bits: 22-(3+13) = 6 Tag bits
; Therefore, if t=tag, b=block and o=offset, then tt tttt bbbb bbbb bbbb booo = 00tttttt bbbbbbbb bbbbboo = 22-bit address


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

mainloop:

          ldi r20,0x1F    ; Store lowest byte of the memory address in register r20
          ldi r21,0xA1    ; Store second lowest byte of the memory address in register r21
          ldi r22,0x19    ; Store upper byte of the memory address in register r22
                          ; Therefore, store entire 22-bit address (hexadecimal 0x19A11F) in r20, 21 and r22

          call decode     ; Program flow shift to sub-routine decode, execute decode then return (exit) from sub-routine

          rjmp mainloop   ; Jump back to mainloop address, therefore loop continuously


decode:

; Register r23 is being used for bit masking and is loaded with - 0x3F, 0xF8, 0x85 and 0x07 throughout decode sub-routine
;=====================================================================================================================================;
; For [Tag]

          ldi r23,0x3F    ; bitmask 0011 1111
          and r23,r22     ; AND     0001 1001
                          ; result  0001 1001
          out PORTB,r23   ; Display bits 0-3 of the byte, i.e. lower nybble
          out PORTD,r23   ; Display bits 4-7 of the byte, i.e. upper nybble
          call delay

          call ledOFF     ; Program flow shift to sub-routine (ledOFF), execute ledOFF then return from sub-routine, turn LEDs OFF
          call delay      ; Program flow shift to sub-routine (delay), execute delay then return from sub-routine, create 0.5s delay
          call delay      ; Create another 0.5s delay, i.e. create 1s delays between successive fields onwards when called twice

;=====================================================================================================================================;
; For [Block]

          mov r24,r20
          ldi r23,0xF8
          and r24,23
          out PORTB,r24   ; Little Endian Display via LEDs
          out PORTD,r24   ; Little Endian Display via LEDs - 0001 1000
          call delay

          lsr r21         ; 0101 0000
          lsr r21         ; 0010 1000
          lsr r21         ; 0001 0100
          lsr r21         ; 0000 1010
          lsr r21         ; 0000 0101
          ldi r23,0x85    ; bitmask 1000 0101
          or r21,23       ; OR      0000 0101
                          ; result  1000 0101

          out PORTB,r21   ; Little Endian Display via LEDs
          out PORTD,r21   ; Little Endian Display via LEDs - 1000 0101
          call delay

          call ledOFF
          call delay
          call delay

;=====================================================================================================================================;
; For [Offset]

          ldi r23,0x07
          and r23,r20
          out PORTB,r23
          out PORTD,r23
          call delay

          call ledOFF
          call delay
          call delay

          ret

;=====================================================================================================================================;



delay:    ldi r19,25     ; Set register r19 to 25
          ldi r18,255    ; Set register r18 to 255
          ldi r17,255    ; Set register r17 to 255
loop:     nop            ; Branch destination (do nothing)
          dec r17        ; Decrement register r17 (subtracts 1)
          cpi r17,0      ; Compare register r17 to 0
          brne loop      ; Branch if r17 not equal to 0, otherwise execute Line 123
          ldi r17,255    ; Set register r17 back to 255
          dec r18        ; Decrement register r18 (subtracts 1)
          cpi r18,0      ; Compare register r18 to 0
          brne loop      ; Branch if r18 not equal to 0, otherwise execute Line 127
          ldi r18,255    ; Set register r18 back to 255
          dec r19        ; Decrement register r19 (subtracts 1)
          cpi r19,0      ; Compare register r19 to 0
          brne loop      ; Branch if r19 not equal to 0, otherwise execute Line 131
          ret            ; Return from sub-routine


ledOFF:   ldi r25,0x00   ; Set register r25 to 0000 0000
          out PORTB,r25
          out PORTD,r25
          ret
