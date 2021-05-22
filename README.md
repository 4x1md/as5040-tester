# AS5040 Magnetic Sensor Tester

## Overview

## Magnetic Sensor AS5040

## Hardware Changes

## New Software

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
