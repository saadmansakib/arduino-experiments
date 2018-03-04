#!/bin/sh

avr-as -g -mmcu=atmega328p -o blink.o blink.s 
avr-ld -o blink.elf blink.o
avr-objcopy -O ihex -R .eeprom blink.elf blink.hex

# Use avrdude to download to connected Arduino Nano
avrdude -C /usr/local/etc/avrdude.conf -p atmega328p -c arduino -P /dev/tty.usbserial-A104WP8V -b 57600 -D -U flash:w:blink.hex:i


