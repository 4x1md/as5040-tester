# AS5040 Magnetic Sensor Tester

## Overview

A friend asked me to repair a DIY magnetic sensors tester. It was designed to test AS5040 sensors assembled on a PCB. The tester used an ATmega168 microcontroller to control the sensor and a 20x2 symbols LCD display to display the sensor data. The device was powered from a 12V wall power supply. A 7805 linear regulator produced 5V for the uC and the display. The 7805 regulator had a 330nF capacitor on the input and 100nF on the output. The values were taken from the datasheet of the regulator.

A short fault analysis showed that the microcontroller didn't work. A long wire from the power supply together with very low input and output capacitances caused high voltage spikes when the device was turned on. The spikes on the input reached 20V and the spikes on the 5V output rail reached 8V and even more. I suppose that these spikes were the main reason for the failure of the microcontroller.

In order to repair the tester, I had to replace the microcontroller. I chose ATmega8 just because I had one. I also decided to improve the schematics for a better performance. As the device was very old and I didn't have the original firmware, I decided to write my own.

## Magnetic Sensor AS5040

AS5040 manufactured by [ams AG](https://ams.com/) is a 10-bit rotary position sensor with digital and analog angle output.

![AS5040 SSOP-16](https://raw.githubusercontent.com/4x1md/as5040-tester/main/images/as5040-ssop-16.png)

The main features of the sensor are:

* Contactless absolute angle position measurement and motion sensing
* User programmable resolution, pole pairs and zero position
* Multiple interfaces (SSI, ABI, UVW, PWM)
* Immune to external magnetic stray fields
* Max. Speed [rpm]	30000
* Supply Voltage [V]	3.3 or 5.0

The tester communicates with the sensor using the SSI interface. The interface is the same as SPI except the MOSI line which doesn't exist here.

## Schematics and Hardware Changes

![AS5040 tester schematics](https://raw.githubusercontent.com/4x1md/as5040-tester/main/images/as5040-tester-schematics.png)

The main blocks of the tester are:

* ATmega8 microcontroller,
* 7805 linear voltage regulator,
* UART to RS-232 level converter which converts logic levels for the LCD display.

The following changes were made to the original circuit:

1. Input and output capacitors in the power supply were increased to 470uF and 100uF respectively.

2. Pull resistors were added to the SPI lines in order to prevent undefined logic levels when the sensor is diconnected. Pull-ups were added to CS and CLK lines and a pull-down was added to the DO line. If all the bits, received from the sensor are 0's, the software supposes that the sensor is disconnected and displays the corresponding message.

3. RC-filters were added to the SPI lines in order to reduce noise and ringing caused by the long unshielded wires between the microcontroller and the sensor.

4. Series 100 Ohm resistor between power input and sensor power line. The resistor is used to limit the sensor current if its power input is short-circuited.

The microcontroller communicates with the sensor using SSI bus which is a unidirectional SPI without MOSI line. The SSI speed is approximately 88kHz which is much below the limits of the AS5040 sensor. There was no specific reason for choosing this specific speed. It just works fine and is enough for the purpose of this project. An SSI communication cycle is shown on the following screenshot.

![AS5040 SSI communication](https://raw.githubusercontent.com/4x1md/as5040-tester/main/images/as5040-ssi-communication.png)

Channel  | Signal
--- | ---
**CH1:** | CS
**CH2:** | AS5040 DO (SPI MISO)
**CH4:** | CLK

## New Software

The firmware reads sensor data approximately 10 times per second. The data is converted to a human-readable form and is displayed on the LCD screen.

The screen has two lines of 20 ASCII symbols. On the first line of the screen the software shows the angle as integer and the status bits. The second line shows a bar graph, length of which changes with the angle.

![LCD example](https://raw.githubusercontent.com/4x1md/as5040-tester/main/images/lcd-display-example.png)

In order to read the sensor data the software generates SSI clock and reads the received bit after each clock rise.

If all the received bits are zeros, the software supposes that the sensor is disconnected and displays ```Sensor disconnected!``` message on the second line. If the received parity bit doesn't match the calculatd parity, ```Parity  error!``` message will be displayed.

## ATmega8 Fuse Bits

The firmware was developed and tested with the following fuses: E=FF, H=C9, L=3F.

* LOW fuse: 0x3F

  * Brown-out detection enabled
  * External high frequency crystal/resonator; start-up time: 16K CK + 64 ms


* HIGH fuse: 0xC9

  * Boot Flash section size=1024 words Boot start address=$0C00; [BOOTSZ=00] (default value)
  * CKOPT fuse (operation dependent of CKSEL fuses)
  * Serial program downloading (SPI) enabled


* LOCKBIT fuse: 0xFF

  * No lock on SPM and LPM in Application Section (mode 1)
  * No lock on SPM and LPM in Boot Loader Section (mode 1)
  * Mode 1: No memory lock features enabled

Fuse values for ATmega8 were calculated using [AVR Fuse Calculator for ATmega8](http://eleccelerator.com/fusecalc/fusecalc.php?chip=atmega8&LOW=3F&HIGH=C9&LOCKBIT=FF).

## Uploading the Firmware

I used USBasp with AVRdude for uploading the firmware to the microcontroller. The source code is compiled to a hex file which is flashed to the ATmega8 with the following command:

```avrdude -c usbasp -p m8 -B32 -U flash:w:file-name.hex:i```

The fuses are written with the following commands:

```avrdude -c usbasp -p m8 -B32 -U lfuse:w:0x3F:m```

```avrdude -c usbasp -p m8 -B32 -U hfuse:w:0xC9:m```

## Photos

![Photo 1](https://raw.githubusercontent.com/4x1md/as5040-tester/main/images/tester-photo-1.jpg)

The tester had been assembled on a prototype board. I had relatively short time for repairing, so I didn't develop my own PCB.

![Photo 2](https://raw.githubusercontent.com/4x1md/as5040-tester/main/images/tester-photo-2.jpg)

## Links

### Technical Data

1. [AS5040 rotarty sensor](https://ams.com/as5040)
2. [AS5040 rotarty densor datasheet](https://ams.com/documents/20143/36005/AS5040_DS000374_4-00.pdf)
3. [Matrix Orbital LCD2021](https://www.matrixorbital.com/lcd2021-manual)
4. [ATmega8 on the Microchip site](https://www.microchip.com/wwwproducts/en/ATMEGA8)
5. [AVR fuse calculator for ATmega8](http://eleccelerator.com/fusecalc/fusecalc.php?chip=atmega8)
6. [QEEWiki AVR guide - USART](https://sites.google.com/site/qeewiki/books/avr-guide/usart)
7. [Working ATmega8 USART](https://likora.wordpress.com/2011/06/18/working-atmega8-usart)

### Free Tools Used in This Project

1. [Microchip MPLAB X IDE](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-x-ide)
2. [Draw.io](https://app.diagrams.net/)
3. [KiCAD](https://www.kicad.org/)
4. [Atom editor](https://atom.io/)
5. [LTspice simulation software](https://www.analog.com/en/design-center/design-tools-and-calculators/ltspice-simulator.html)
6. [Kubuntu](https://kubuntu.org/)
7. [QCAD](https://www.qcad.org)
