## Arduino and Assembly encounters

Five practical assessments that I had to complete as part of 4CCS1CS1 Computer Systems and Architecture 
<a href="https://www.kcl.ac.uk/nms/depts/informatics/study/current/handbook/progs/modules/4CCS1CS1.aspx">module</a>
at King's College London. I got to do some really cool stuff with LEDs, some of them were very challenging.

**Lab 1** - *I studied the syntax of assembly language for the Atmel microprocessors, how to assemble, and write machine code programs to memory.* 

**Lab 2** - *With the knowledege gained from the first assessment, I learned how to write a simple program to control the Arduino I/O interfaces to write out a hexadecimal number to externally connected LEDs.*

**Lab 3** - *In this lab, I learned how to read external digital input on the Arduino and how to perform mathematical operations and do simple branching. Also, calculating a simple mathematical function.*

**Lab 4** - *This one was really interesting, I explored timing on the Arduino, and how to make the LEDs blink in specific patterns.*

**Lab 5** - *In the final lab, I explored different bit-wise operations on the Arduino. Moreover, wrote a small assembly program to calculate the various components of a memory address with regards to a specific cache memory architecture.* 

<br/>

### Instructions

<br/>

**Step 1** - Open up a terminal shell and enter the following command to clone the repository and assuming `clr_sreg.hex` is to be flashed, navigate to the lab-1 directory under assembly directory.

```bash
$ git clone https://github.com/saadmansakib/arduino-experiments.git
```

**Step 2** - Setup the hardware according to the assessment briefs located in the resources folder inside the repository. Make sure the arduino is connected to the machine via USB.

**Step 3** - Flash the machine code which is the file with `.hex` extension in Intel HEX format by entering one of the following commands in the terminal shell depending on OS.

Depending on how and where **avrdude** is installed on the target machine, modification to the command arguments might have to be performed. (i.e. what follows the -C and the -P settings)

The part following `/dev/........ \` will vary. To find out which USB port the arduino is connected to, enter on a terminal shell `ls /dev` on MacOS or `ls/dev/ttyUSB*` on Linux.

*Linux*

```bash
$ avrdude -C /etc/avrdude/avrdude.conf -p atmega328p -c arduino -P /dev/ttyUSB0 \ -b 57600 -D -U flash:w:clr_sreg.hex:i
```

*MacOS*

```bash
$ avrdude -C usr/local/avrdude/avrdude.conf -p atmega328p -c arduino -P /dev/tty.usbserial-A104WP8V \ -b 57600 -D -U flash:w:clr_sreg.hex:i
```

**Step 4** - If everything goes smoothly, the LEDs on the arduino board will flash for a few moments, indicating that the program is being communicated to the chip through the USB connection.
The output will be similar to the screenshot below.

<img src="/resources/avrdude-MacOS.png?raw=true" width="85%">

<br/>

### Instructions for writing and flashing own program

<br/>

**Step 1** - Write a program and save the file with `.s` extension which is the source code. Open up a terminal shell and navigate to the directory where the file is saved. 

**Step 2** - Enter the following commands one by one to call the assembler to generate `.hex` file which can be flashed. 

```bash
$ avr-as -g -mmcu=atmega328p -o file.o file.s 
$ avr-ld -o file.elf file.o
$ avr-objcopy -O ihex -R .eeprom file.elf file.hex
```

**Step 3** - Finally, to flash the newly written program, follow step 3 under *Instructions*.

<br/>

### Resources used

<br/>

* Arduino Nano
* Atmel ATmega328 Datasheet
* Atmel 8-bit AVR Instruction Set Manual
* Arduino Schematic Circuit Diagram
* Breadboard
* 8 LEDs
* 8 330Ω resistors (color coded: Orange-Orange-Black-Black-Brown).
* 9 jumper wires

