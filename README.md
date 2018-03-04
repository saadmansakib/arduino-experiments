## Arduino and Assembly encounters

Five practical assessments that I had to complete as part of 
<a href="https://www.kcl.ac.uk/nms/depts/informatics/study/current/handbook/progs/modules/4CCS1CS1.aspx">4CCS1CS1</a>
Computer Systems and Architecture module at King's College London. I got to do some cool stuff with LEDs, some of them were very challenging.

**Lab 1** - *I studied the syntax of assembly language for the Atmel microprocessors, how to assemble, and write machine code programs to memory.* 

**Lab 2** - *With the knowledege gained from the first lab, I learned how to write a simple program to control the Arduino I/O interfaces to write out a hexadecimal number to externally connected LEDs.*

**Lab 3** - *In this lab, I learned how to read external digital input on the Arduino and how to perform mathematical operations and do simple branching. Also, calculating a simple mathematical function.*

**Lab 4** - *This one was really interesting, I explored timing on the Arduino, and how to make the LEDs blink in specific patterns.*

**Lab 5** - *In the final lab, I explored different bit-wise operations on the Arduino. Moreover, wrote a small assembly program to calculate the various components of a memory address with regards to a specific cache memory architecture.* 

<br/>

### Instructions

<br/>

**Step 1** - Open up a terminal shell and enter the following commands to clone the repository and assumming `clr_sreg.hex` is to be flashed, navigates to that directory. 

```bash
$ git clone https://github.com/saadmansakib/arduino-experiments.git
$ cd arduino-experiments/assembly/lab-1
```

**Step 2** - Setup the hardware according to the lab briefs located in the resources folder inside the repository. Make sure the arduino is connected to the machine via USB.

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

**Step 4** - If all goes well, the LEDs on the arduino board will flash for a few moments, indicating that the program is being communicated to the chip through the serial USB connection.
The output will be similar to the screenshot below.

<img src="/resources/avrdude-MacOS.png?raw=true" width="85%">


