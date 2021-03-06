EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "AS5040 tester"
Date "2021-05-08"
Rev "1.0"
Comp ""
Comment1 "Final version after all the required modifications."
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_ATmega:ATmega8-16PU U2
U 1 1 60968B86
P 3200 2800
F 0 "U2" H 2350 2950 50  0000 C CNN
F 1 "ATmega8-16PU" H 2350 2800 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 3200 2800 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-2486-8-bit-avr-microcontroller-atmega8_l_datasheet.pdf" H 3200 2800 50  0001 C CNN
	1    3200 2800
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM7805_TO220 U3
U 1 1 6096CE6B
P 3800 5400
F 0 "U3" H 3800 5642 50  0000 C CNN
F 1 "LM7805_TO220" H 3800 5551 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 3800 5625 50  0001 C CIN
F 3 "https://www.onsemi.cn/PowerSolutions/document/MC7800-D.PDF" H 3800 5350 50  0001 C CNN
	1    3800 5400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 6096E4F9
P 3300 5750
F 0 "C11" H 3415 5796 50  0000 L CNN
F 1 "330n" H 3415 5705 50  0000 L CNN
F 2 "" H 3338 5600 50  0001 C CNN
F 3 "~" H 3300 5750 50  0001 C CNN
	1    3300 5750
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 60970264
P 10100 1700
F 0 "J1" H 10180 1692 50  0000 L CNN
F 1 "LCD Vcc" H 10180 1601 50  0000 L CNN
F 2 "" H 10100 1700 50  0001 C CNN
F 3 "~" H 10100 1700 50  0001 C CNN
	1    10100 1700
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 J4
U 1 1 60971293
P 9750 5250
F 0 "J4" H 9830 5242 50  0000 L CNN
F 1 "Conn_01x06" H 9830 5151 50  0000 L CNN
F 2 "" H 9750 5250 50  0001 C CNN
F 3 "~" H 9750 5250 50  0001 C CNN
	1    9750 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GNDREF #PWR09
U 1 1 609723F7
P 9800 1900
F 0 "#PWR09" H 9800 1650 50  0001 C CNN
F 1 "GNDREF" H 9805 1727 50  0000 C CNN
F 2 "" H 9800 1900 50  0001 C CNN
F 3 "" H 9800 1900 50  0001 C CNN
	1    9800 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR020
U 1 1 60972DBB
P 4700 5300
F 0 "#PWR020" H 4700 5150 50  0001 C CNN
F 1 "+5V" H 4715 5473 50  0000 C CNN
F 2 "" H 4700 5300 50  0001 C CNN
F 3 "" H 4700 5300 50  0001 C CNN
	1    4700 5300
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR019
U 1 1 60973DF6
P 2900 5300
F 0 "#PWR019" H 2900 5150 50  0001 C CNN
F 1 "+12V" H 2915 5473 50  0000 C CNN
F 2 "" H 2900 5300 50  0001 C CNN
F 3 "" H 2900 5300 50  0001 C CNN
	1    2900 5300
	1    0    0    -1  
$EndComp
NoConn ~ 9550 5050
Text Notes 7500 4450 0    100  ~ 20
AS5040 connector
Text Notes 1200 4950 0    100  ~ 20
PSU connector
Text Notes 2850 4950 0    100  ~ 20
12V to 5V power supply
$Comp
L power:GNDREF #PWR021
U 1 1 60978426
P 9450 5650
F 0 "#PWR021" H 9450 5400 50  0001 C CNN
F 1 "GNDREF" H 9455 5477 50  0000 C CNN
F 2 "" H 9450 5650 50  0001 C CNN
F 3 "" H 9450 5650 50  0001 C CNN
	1    9450 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 5150 9450 5150
Wire Wire Line
	9450 5150 9450 5650
Text Label 8900 5450 0    50   ~ 0
AS5040_DO
Text Label 8900 5350 0    50   ~ 0
AS5040_CLK
$Comp
L Device:R R7
U 1 1 609802CA
P 8100 5550
F 0 "R7" V 8050 5350 50  0000 C CNN
F 1 "100" V 8050 5750 50  0000 C CNN
F 2 "" V 8030 5550 50  0001 C CNN
F 3 "~" H 8100 5550 50  0001 C CNN
	1    8100 5550
	0    1    1    0   
$EndComp
$Comp
L Device:R R6
U 1 1 6097FF6C
P 8100 5450
F 0 "R6" V 8050 5250 50  0000 C CNN
F 1 "100" V 8050 5650 50  0000 C CNN
F 2 "" V 8030 5450 50  0001 C CNN
F 3 "~" H 8100 5450 50  0001 C CNN
	1    8100 5450
	0    1    1    0   
$EndComp
$Comp
L Device:R R5
U 1 1 6097F604
P 8100 5350
F 0 "R5" V 8050 5150 50  0000 C CNN
F 1 "100" V 8050 5550 50  0000 C CNN
F 2 "" V 8030 5350 50  0001 C CNN
F 3 "~" H 8100 5350 50  0001 C CNN
	1    8100 5350
	0    1    1    0   
$EndComp
Wire Wire Line
	9550 5450 8250 5450
Wire Wire Line
	8250 5550 8450 5550
Wire Wire Line
	9550 5350 8800 5350
Text Label 8900 5250 0    50   ~ 0
AS5040_VCC
$Comp
L Device:R R2
U 1 1 6097AB05
P 8700 5000
F 0 "R2" H 8630 4954 50  0000 R CNN
F 1 "100Ohm 2W" H 8630 5045 50  0000 R CNN
F 2 "" V 8630 5000 50  0001 C CNN
F 3 "~" H 8700 5000 50  0001 C CNN
	1    8700 5000
	-1   0    0    1   
$EndComp
$Comp
L Device:R R8
U 1 1 60992D19
P 7250 5850
F 0 "R8" H 7320 5896 50  0000 L CNN
F 1 "10K" H 7320 5805 50  0000 L CNN
F 2 "" V 7180 5850 50  0001 C CNN
F 3 "~" H 7250 5850 50  0001 C CNN
	1    7250 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C16
U 1 1 6099E0E7
P 8800 5850
F 0 "C16" H 8915 5896 50  0000 L CNN
F 1 "1n" H 8915 5805 50  0000 L CNN
F 2 "" H 8838 5700 50  0001 C CNN
F 3 "~" H 8800 5850 50  0001 C CNN
	1    8800 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 609936E6
P 8450 5850
F 0 "C15" H 8565 5896 50  0000 L CNN
F 1 "1n" H 8565 5805 50  0000 L CNN
F 2 "" H 8488 5700 50  0001 C CNN
F 3 "~" H 8450 5850 50  0001 C CNN
	1    8450 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C14
U 1 1 6099EAC9
P 6950 5850
F 0 "C14" H 7065 5896 50  0000 L CNN
F 1 "1n" H 7065 5805 50  0000 L CNN
F 2 "" H 6988 5700 50  0001 C CNN
F 3 "~" H 6950 5850 50  0001 C CNN
	1    6950 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 5700 8800 5350
Connection ~ 8800 5350
Wire Wire Line
	8250 5350 8800 5350
Wire Wire Line
	8450 5700 8450 5550
Connection ~ 8450 5550
Wire Wire Line
	8450 5550 9550 5550
$Comp
L power:GNDREF #PWR026
U 1 1 609A4D69
P 8800 6150
F 0 "#PWR026" H 8800 5900 50  0001 C CNN
F 1 "GNDREF" H 8805 5977 50  0000 C CNN
F 2 "" H 8800 6150 50  0001 C CNN
F 3 "" H 8800 6150 50  0001 C CNN
	1    8800 6150
	1    0    0    -1  
$EndComp
$Comp
L power:GNDREF #PWR025
U 1 1 609A5A86
P 8450 6150
F 0 "#PWR025" H 8450 5900 50  0001 C CNN
F 1 "GNDREF" H 8455 5977 50  0000 C CNN
F 2 "" H 8450 6150 50  0001 C CNN
F 3 "" H 8450 6150 50  0001 C CNN
	1    8450 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 6150 8450 6000
Wire Wire Line
	8800 6150 8800 6000
Wire Wire Line
	7250 5700 7250 5450
Wire Wire Line
	7250 5450 7950 5450
Wire Wire Line
	6950 5700 6950 5450
Wire Wire Line
	6950 5450 7250 5450
Connection ~ 7250 5450
Wire Wire Line
	6600 5550 7450 5550
Connection ~ 6950 5450
Wire Wire Line
	7950 5350 7750 5350
$Comp
L Device:R R4
U 1 1 609B4B7A
P 7750 5100
F 0 "R4" H 7820 5146 50  0000 L CNN
F 1 "10K" H 7820 5055 50  0000 L CNN
F 2 "" V 7680 5100 50  0001 C CNN
F 3 "~" H 7750 5100 50  0001 C CNN
	1    7750 5100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 609B553B
P 7450 5100
F 0 "R3" H 7520 5146 50  0000 L CNN
F 1 "10K" H 7520 5055 50  0000 L CNN
F 2 "" V 7380 5100 50  0001 C CNN
F 3 "~" H 7450 5100 50  0001 C CNN
	1    7450 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 5250 7750 5350
Connection ~ 7750 5350
$Comp
L power:+5V #PWR018
U 1 1 609BC9B3
P 7600 4800
F 0 "#PWR018" H 7600 4650 50  0001 C CNN
F 1 "+5V" H 7615 4973 50  0000 C CNN
F 2 "" H 7600 4800 50  0001 C CNN
F 3 "" H 7600 4800 50  0001 C CNN
	1    7600 4800
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR017
U 1 1 609BCC03
P 8700 4750
F 0 "#PWR017" H 8700 4600 50  0001 C CNN
F 1 "+12V" H 8715 4923 50  0000 C CNN
F 2 "" H 8700 4750 50  0001 C CNN
F 3 "" H 8700 4750 50  0001 C CNN
	1    8700 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 5250 9550 5250
Wire Wire Line
	7750 4850 7750 4950
Wire Wire Line
	7750 4850 7600 4850
Wire Wire Line
	7450 4850 7450 4950
Wire Wire Line
	8700 4750 8700 4850
Wire Wire Line
	8700 5150 8700 5250
Wire Wire Line
	7600 4800 7600 4850
Connection ~ 7600 4850
Wire Wire Line
	7600 4850 7450 4850
Wire Wire Line
	6600 5350 7750 5350
Wire Wire Line
	7450 5250 7450 5550
Connection ~ 7450 5550
Wire Wire Line
	7450 5550 7950 5550
$Comp
L power:GNDREF #PWR024
U 1 1 609F40CC
P 7250 6150
F 0 "#PWR024" H 7250 5900 50  0001 C CNN
F 1 "GNDREF" H 7255 5977 50  0000 C CNN
F 2 "" H 7250 6150 50  0001 C CNN
F 3 "" H 7250 6150 50  0001 C CNN
	1    7250 6150
	1    0    0    -1  
$EndComp
$Comp
L power:GNDREF #PWR023
U 1 1 609F4CBA
P 6950 6150
F 0 "#PWR023" H 6950 5900 50  0001 C CNN
F 1 "GNDREF" H 6955 5977 50  0000 C CNN
F 2 "" H 6950 6150 50  0001 C CNN
F 3 "" H 6950 6150 50  0001 C CNN
	1    6950 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 6000 6950 6150
Wire Wire Line
	7250 6000 7250 6150
Text Label 6600 5450 0    50   ~ 0
DO
Text Label 6600 5350 0    50   ~ 0
CLK
Text Label 6600 5550 0    50   ~ 0
~CS
Text Label 8900 5550 0    50   ~ 0
~AS5040_CS
Wire Wire Line
	4150 3500 3800 3500
Text Label 4150 3300 2    50   ~ 0
DO
Text Label 4150 3500 2    50   ~ 0
CLK
Text Label 4150 3400 2    50   ~ 0
~CS
Wire Wire Line
	3800 3300 4150 3300
Wire Wire Line
	4150 3400 3800 3400
Wire Wire Line
	4150 3200 3800 3200
Text Label 4150 3200 2    50   ~ 0
TX
Text Label 4150 3100 2    50   ~ 0
RX
Wire Wire Line
	4150 3100 3800 3100
$Comp
L Device:R R1
U 1 1 60A26947
P 2500 1350
F 0 "R1" H 2570 1396 50  0000 L CNN
F 1 "10K" H 2570 1305 50  0000 L CNN
F 2 "" V 2430 1350 50  0001 C CNN
F 3 "~" H 2500 1350 50  0001 C CNN
	1    2500 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GNDREF #PWR013
U 1 1 60A26971
P 1500 2650
F 0 "#PWR013" H 1500 2400 50  0001 C CNN
F 1 "GNDREF" H 1505 2477 50  0000 C CNN
F 2 "" H 1500 2650 50  0001 C CNN
F 3 "" H 1500 2650 50  0001 C CNN
	1    1500 2650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR02
U 1 1 60A309F9
P 3300 1100
F 0 "#PWR02" H 3300 950 50  0001 C CNN
F 1 "+5V" H 3315 1273 50  0000 C CNN
F 2 "" H 3300 1100 50  0001 C CNN
F 3 "" H 3300 1100 50  0001 C CNN
	1    3300 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR011
U 1 1 60A329AB
P 2350 2300
F 0 "#PWR011" H 2350 2150 50  0001 C CNN
F 1 "+5V" V 2365 2428 50  0000 L CNN
F 2 "" H 2350 2300 50  0001 C CNN
F 3 "" H 2350 2300 50  0001 C CNN
	1    2350 2300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2350 2300 2600 2300
$Comp
L Device:C C8
U 1 1 60A2692A
P 1250 2350
F 0 "C8" H 1365 2396 50  0000 L CNN
F 1 "22p" H 1365 2305 50  0000 L CNN
F 2 "" H 1288 2200 50  0001 C CNN
F 3 "~" H 1250 2350 50  0001 C CNN
	1    1250 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 1700 2500 1700
Wire Wire Line
	2500 1200 2500 1100
Wire Wire Line
	3300 1150 3300 1400
Wire Wire Line
	3200 1400 3200 1150
Wire Wire Line
	3200 1150 3300 1150
Wire Wire Line
	3300 1100 3300 1150
Connection ~ 3300 1150
$Comp
L Device:C C1
U 1 1 60A6086B
P 3650 1150
F 0 "C1" V 3600 1000 50  0000 C CNN
F 1 "100n" V 3600 1350 50  0000 C CNN
F 2 "" H 3688 1000 50  0001 C CNN
F 3 "~" H 3650 1150 50  0001 C CNN
	1    3650 1150
	0    1    1    0   
$EndComp
$Comp
L power:GNDREF #PWR04
U 1 1 60A62E3A
P 4000 1150
F 0 "#PWR04" H 4000 900 50  0001 C CNN
F 1 "GNDREF" V 4005 1022 50  0000 R CNN
F 2 "" H 4000 1150 50  0001 C CNN
F 3 "" H 4000 1150 50  0001 C CNN
	1    4000 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3300 1150 3500 1150
Wire Wire Line
	3800 1150 4000 1150
$Comp
L Device:C C5
U 1 1 60A66EE3
P 2250 1700
F 0 "C5" V 2500 1700 50  0000 C CNN
F 1 "100n" V 2400 1700 50  0000 C CNN
F 2 "" H 2288 1550 50  0001 C CNN
F 3 "~" H 2250 1700 50  0001 C CNN
	1    2250 1700
	0    -1   -1   0   
$EndComp
$Comp
L power:GNDREF #PWR08
U 1 1 60A67061
P 2000 1700
F 0 "#PWR08" H 2000 1450 50  0001 C CNN
F 1 "GNDREF" V 2005 1572 50  0000 R CNN
F 2 "" H 2000 1700 50  0001 C CNN
F 3 "" H 2000 1700 50  0001 C CNN
	1    2000 1700
	0    1    1    0   
$EndComp
Wire Wire Line
	2500 1700 2400 1700
Wire Wire Line
	2100 1700 2000 1700
Connection ~ 2500 1700
Wire Wire Line
	2500 1700 2500 1500
$Comp
L Device:Crystal Y1
U 1 1 60A8C655
P 1500 2100
F 0 "Y1" H 1500 2450 50  0000 C CNN
F 1 "11.0952MHz" H 1500 2350 50  0000 C CNN
F 2 "" H 1500 2100 50  0001 C CNN
F 3 "~" H 1500 2100 50  0001 C CNN
	1    1500 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 60A8D39A
P 1750 2350
F 0 "C9" H 1865 2396 50  0000 L CNN
F 1 "22p" H 1865 2305 50  0000 L CNN
F 2 "" H 1788 2200 50  0001 C CNN
F 3 "~" H 1750 2350 50  0001 C CNN
	1    1750 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 2500 1750 2600
Wire Wire Line
	1750 2600 1500 2600
Wire Wire Line
	1250 2600 1250 2500
Wire Wire Line
	1250 2200 1250 2100
Wire Wire Line
	1250 2100 1350 2100
Wire Wire Line
	1650 2100 1750 2100
Wire Wire Line
	1750 2100 1750 2200
Wire Wire Line
	2600 2100 1750 2100
Connection ~ 1750 2100
Wire Wire Line
	2600 1900 1250 1900
Wire Wire Line
	1250 1900 1250 2100
Connection ~ 1250 2100
Wire Wire Line
	1500 2650 1500 2600
Connection ~ 1500 2600
Wire Wire Line
	1500 2600 1250 2600
$Comp
L power:GNDREF #PWR016
U 1 1 60ACC6F3
P 3250 4350
F 0 "#PWR016" H 3250 4100 50  0001 C CNN
F 1 "GNDREF" H 3255 4177 50  0000 C CNN
F 2 "" H 3250 4350 50  0001 C CNN
F 3 "" H 3250 4350 50  0001 C CNN
	1    3250 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 4200 3200 4300
Wire Wire Line
	3200 4300 3250 4300
Wire Wire Line
	3300 4300 3300 4200
Wire Wire Line
	3250 4350 3250 4300
Connection ~ 3250 4300
Wire Wire Line
	3250 4300 3300 4300
$Comp
L Device:C C13
U 1 1 60AF1D32
P 4700 5750
F 0 "C13" H 4815 5796 50  0000 L CNN
F 1 "100n" H 4815 5705 50  0000 L CNN
F 2 "" H 4738 5600 50  0001 C CNN
F 3 "~" H 4700 5750 50  0001 C CNN
	1    4700 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C12
U 1 1 60AF25ED
P 4300 5750
F 0 "C12" H 4418 5796 50  0000 L CNN
F 1 "100u" H 4418 5705 50  0000 L CNN
F 2 "" H 4338 5600 50  0001 C CNN
F 3 "~" H 4300 5750 50  0001 C CNN
	1    4300 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C10
U 1 1 60AF32BA
P 2900 5750
F 0 "C10" H 3018 5796 50  0000 L CNN
F 1 "470u" H 3018 5705 50  0000 L CNN
F 2 "" H 2938 5600 50  0001 C CNN
F 3 "~" H 2900 5750 50  0001 C CNN
	1    2900 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 5400 3300 5400
Wire Wire Line
	2900 5400 2900 5600
Wire Wire Line
	3300 5600 3300 5400
Connection ~ 3300 5400
Wire Wire Line
	3300 5400 2900 5400
Wire Wire Line
	4100 5400 4300 5400
Wire Wire Line
	4700 5400 4700 5600
Wire Wire Line
	4700 5900 4700 6100
Wire Wire Line
	4700 6100 4300 6100
Wire Wire Line
	2900 6100 2900 5900
Wire Wire Line
	3300 5900 3300 6100
Connection ~ 3300 6100
Wire Wire Line
	3300 6100 2900 6100
Wire Wire Line
	3800 5700 3800 6100
Connection ~ 3800 6100
Wire Wire Line
	3800 6100 3300 6100
Wire Wire Line
	4300 5900 4300 6100
Connection ~ 4300 6100
Wire Wire Line
	4300 6100 3800 6100
Wire Wire Line
	4300 5600 4300 5400
Connection ~ 4300 5400
Wire Wire Line
	4300 5400 4700 5400
$Comp
L power:GNDREF #PWR022
U 1 1 60B4C68F
P 3800 6150
F 0 "#PWR022" H 3800 5900 50  0001 C CNN
F 1 "GNDREF" H 3805 5977 50  0000 C CNN
F 2 "" H 3800 6150 50  0001 C CNN
F 3 "" H 3800 6150 50  0001 C CNN
	1    3800 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 6150 3800 6100
Wire Wire Line
	4700 5300 4700 5400
Connection ~ 4700 5400
Wire Wire Line
	2900 5300 2900 5400
Connection ~ 2900 5400
$Comp
L Switch:SW_SPST SW1
U 1 1 60B6CFEE
P 2500 5400
F 0 "SW1" H 2500 5635 50  0000 C CNN
F 1 "SPST switch" H 2500 5544 50  0000 C CNN
F 2 "" H 2500 5400 50  0001 C CNN
F 3 "~" H 2500 5400 50  0001 C CNN
	1    2500 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 5400 2300 5400
Wire Wire Line
	2100 6100 2900 6100
Connection ~ 2900 6100
$Comp
L Connector:Barrel_Jack J5
U 1 1 60B806E7
P 1700 5750
F 0 "J5" H 1757 6075 50  0000 C CNN
F 1 "Barrel jack" H 1757 5984 50  0000 C CNN
F 2 "" H 1750 5710 50  0001 C CNN
F 3 "~" H 1750 5710 50  0001 C CNN
	1    1700 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 5650 2100 5650
Wire Wire Line
	2100 5650 2100 5400
Wire Wire Line
	2000 5850 2100 5850
Wire Wire Line
	2100 5850 2100 6100
Wire Wire Line
	2700 5400 2900 5400
Text Notes 2250 5650 0    50   ~ 0
On/off switch\nwith LED
Text Notes 1200 5050 0    50   ~ 0
12V power supply is required.
Text Notes 2000 800  0    100  ~ 20
ATmega8 microcontroller
$Comp
L Interface_UART:MAX232 U1
U 1 1 60BF50A9
P 7550 2450
F 0 "U1" H 7100 3650 50  0000 C CNN
F 1 "MAX232" H 7100 3550 50  0000 C CNN
F 2 "" H 7600 1400 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/max232.pdf" H 7550 2550 50  0001 C CNN
	1    7550 2450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 60C07EB2
P 2500 1100
F 0 "#PWR01" H 2500 950 50  0001 C CNN
F 1 "+5V" H 2515 1273 50  0000 C CNN
F 2 "" H 2500 1100 50  0001 C CNN
F 3 "" H 2500 1100 50  0001 C CNN
	1    2500 1100
	1    0    0    -1  
$EndComp
Text Notes 6700 800  0    100  ~ 20
RS-232 level converter & LCD connectors
$Comp
L power:+5V #PWR03
U 1 1 60C89B3A
P 7550 1100
F 0 "#PWR03" H 7550 950 50  0001 C CNN
F 1 "+5V" H 7565 1273 50  0000 C CNN
F 2 "" H 7550 1100 50  0001 C CNN
F 3 "" H 7550 1100 50  0001 C CNN
	1    7550 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 1100 7550 1150
$Comp
L Device:C C2
U 1 1 60C89D47
P 7900 1150
F 0 "C2" V 7850 1000 50  0000 C CNN
F 1 "1uF" V 7850 1350 50  0000 C CNN
F 2 "" H 7938 1000 50  0001 C CNN
F 3 "~" H 7900 1150 50  0001 C CNN
	1    7900 1150
	0    1    1    0   
$EndComp
$Comp
L power:GNDREF #PWR05
U 1 1 60C89D51
P 8250 1150
F 0 "#PWR05" H 8250 900 50  0001 C CNN
F 1 "GNDREF" V 8255 1022 50  0000 R CNN
F 2 "" H 8250 1150 50  0001 C CNN
F 3 "" H 8250 1150 50  0001 C CNN
	1    8250 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7550 1150 7750 1150
Wire Wire Line
	8050 1150 8250 1150
Wire Wire Line
	6600 5450 6950 5450
Wire Wire Line
	7550 1250 7550 1150
Connection ~ 7550 1150
$Comp
L Device:C C3
U 1 1 60CBC563
P 6450 1550
F 0 "C3" V 6400 1400 50  0000 C CNN
F 1 "1uF" V 6400 1750 50  0000 C CNN
F 2 "" H 6488 1400 50  0001 C CNN
F 3 "~" H 6450 1550 50  0001 C CNN
	1    6450 1550
	0    1    1    0   
$EndComp
$Comp
L Device:C C4
U 1 1 60CBCF12
P 8650 1550
F 0 "C4" V 8600 1400 50  0000 C CNN
F 1 "1uF" V 8600 1750 50  0000 C CNN
F 2 "" H 8688 1400 50  0001 C CNN
F 3 "~" H 8650 1550 50  0001 C CNN
	1    8650 1550
	0    1    1    0   
$EndComp
Wire Wire Line
	6600 1550 6750 1550
Wire Wire Line
	8950 1850 8350 1850
Wire Wire Line
	8950 1550 8950 1850
Wire Wire Line
	8800 1550 8950 1550
Wire Wire Line
	8350 1550 8500 1550
Wire Wire Line
	6750 1850 6150 1850
Wire Wire Line
	6150 1850 6150 1550
Wire Wire Line
	6150 1550 6300 1550
$Comp
L Device:C C6
U 1 1 60CE385D
P 8650 2050
F 0 "C6" V 8600 1900 50  0000 C CNN
F 1 "1uF" V 8600 2250 50  0000 C CNN
F 2 "" H 8688 1900 50  0001 C CNN
F 3 "~" H 8650 2050 50  0001 C CNN
	1    8650 2050
	0    1    1    0   
$EndComp
$Comp
L Device:C C7
U 1 1 60CE4238
P 8650 2350
F 0 "C7" V 8600 2200 50  0000 C CNN
F 1 "1uF" V 8600 2550 50  0000 C CNN
F 2 "" H 8688 2200 50  0001 C CNN
F 3 "~" H 8650 2350 50  0001 C CNN
	1    8650 2350
	0    1    1    0   
$EndComp
Wire Wire Line
	8350 2050 8500 2050
Wire Wire Line
	8950 2050 8950 2200
Wire Wire Line
	8950 2350 8800 2350
Wire Wire Line
	8800 2050 8950 2050
Wire Wire Line
	8500 2350 8350 2350
$Comp
L power:GNDREF #PWR010
U 1 1 60CEA368
P 9000 2200
F 0 "#PWR010" H 9000 1950 50  0001 C CNN
F 1 "GNDREF" V 9005 2072 50  0001 R CNN
F 2 "" H 9000 2200 50  0001 C CNN
F 3 "" H 9000 2200 50  0001 C CNN
	1    9000 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9000 2200 8950 2200
Connection ~ 8950 2200
Wire Wire Line
	8950 2200 8950 2350
Wire Wire Line
	4300 2100 3800 2100
Text Label 4100 2100 0    50   ~ 0
MISO
Wire Wire Line
	4300 2200 3800 2200
Text Label 4100 2200 0    50   ~ 0
SCK
Text Label 2500 1650 1    50   ~ 0
RST
Wire Wire Line
	4300 2300 4100 2300
Text Label 4100 2300 0    50   ~ 0
RST
Wire Wire Line
	4800 2200 5100 2200
Text Label 4850 2200 0    50   ~ 0
MOSI
$Comp
L power:GNDREF #PWR012
U 1 1 60D9E567
P 4900 2400
F 0 "#PWR012" H 4900 2150 50  0001 C CNN
F 1 "GNDREF" H 4905 2227 50  0000 C CNN
F 2 "" H 4900 2400 50  0001 C CNN
F 3 "" H 4900 2400 50  0001 C CNN
	1    4900 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 2300 4900 2300
Wire Wire Line
	4900 2300 4900 2400
Wire Wire Line
	4900 2100 4800 2100
Wire Wire Line
	5100 2200 5100 2000
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J3
U 1 1 60D0FA4A
P 4500 2200
F 0 "J3" H 4550 2600 50  0000 C CNN
F 1 "AVR ISP" H 4550 2500 50  0000 C CNN
F 2 "" H 4500 2200 50  0001 C CNN
F 3 "~" H 4500 2200 50  0001 C CNN
	1    4500 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1900 4900 2100
$Comp
L power:+5V #PWR07
U 1 1 60DA8ABD
P 4900 1600
F 0 "#PWR07" H 4900 1450 50  0001 C CNN
F 1 "+5V" H 4915 1773 50  0000 C CNN
F 2 "" H 4900 1600 50  0001 C CNN
F 3 "" H 4900 1600 50  0001 C CNN
	1    4900 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 2000 3800 2000
$Comp
L Device:Jumper_NC_Small JP1
U 1 1 60DCA1DF
P 4900 1800
F 0 "JP1" V 4854 1874 50  0000 L CNN
F 1 "ISP 5V" V 4945 1874 50  0000 L CNN
F 2 "" H 4900 1800 50  0001 C CNN
F 3 "~" H 4900 1800 50  0001 C CNN
	1    4900 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 1600 4900 1700
$Comp
L power:GNDREF #PWR015
U 1 1 60DD7265
P 7550 3700
F 0 "#PWR015" H 7550 3450 50  0001 C CNN
F 1 "GNDREF" H 7555 3527 50  0000 C CNN
F 2 "" H 7550 3700 50  0001 C CNN
F 3 "" H 7550 3700 50  0001 C CNN
	1    7550 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 3650 7550 3700
Wire Wire Line
	6750 3150 6000 3150
Text Label 6000 3150 0    50   ~ 0
RX
Wire Wire Line
	6750 2750 6000 2750
Text Label 6000 2750 0    50   ~ 0
TX
NoConn ~ 6750 2550
NoConn ~ 8350 2550
NoConn ~ 8350 2950
NoConn ~ 6750 2950
$Comp
L Connector:DB9_Female J2
U 1 1 60E1B230
P 10100 3150
F 0 "J2" H 10018 2458 50  0000 C CNN
F 1 "DB9 Female" H 10018 2549 50  0000 C CNN
F 2 "" H 10100 3150 50  0001 C CNN
F 3 " ~" H 10100 3150 50  0001 C CNN
	1    10100 3150
	1    0    0    1   
$EndComp
$Comp
L power:GNDREF #PWR014
U 1 1 60E23E25
P 9700 2750
F 0 "#PWR014" H 9700 2500 50  0001 C CNN
F 1 "GNDREF" V 9705 2622 50  0000 R CNN
F 2 "" H 9700 2750 50  0001 C CNN
F 3 "" H 9700 2750 50  0001 C CNN
	1    9700 2750
	0    1    1    0   
$EndComp
Wire Wire Line
	9700 2750 9800 2750
NoConn ~ 9800 3550
NoConn ~ 9800 3450
NoConn ~ 9800 3250
NoConn ~ 9800 3050
NoConn ~ 9800 2950
NoConn ~ 9800 2850
Text Label 9400 3150 0    50   ~ 0
LCD_TX
Text Label 9400 3350 0    50   ~ 0
LCD_RX
Wire Wire Line
	8350 3150 9800 3150
Wire Wire Line
	9800 3350 9200 3350
Wire Wire Line
	9200 3350 9200 2750
Wire Wire Line
	9200 2750 8350 2750
$Comp
L power:+5V #PWR06
U 1 1 60F2F772
P 9800 1600
F 0 "#PWR06" H 9800 1450 50  0001 C CNN
F 1 "+5V" H 9815 1773 50  0000 C CNN
F 2 "" H 9800 1600 50  0001 C CNN
F 3 "" H 9800 1600 50  0001 C CNN
	1    9800 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 1700 9800 1700
Wire Wire Line
	9800 1700 9800 1600
Wire Wire Line
	9900 1800 9800 1800
Wire Wire Line
	9800 1800 9800 1900
NoConn ~ 3800 1900
NoConn ~ 3800 1800
NoConn ~ 3800 1700
NoConn ~ 3800 2400
NoConn ~ 3800 2500
NoConn ~ 3800 2600
NoConn ~ 3800 2750
NoConn ~ 3800 2700
NoConn ~ 3800 2900
NoConn ~ 3800 3600
NoConn ~ 3800 3700
NoConn ~ 3800 3800
$EndSCHEMATC
