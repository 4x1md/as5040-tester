/* 
 * File:   main.c
 * Author: 4x1md
 *
 * Created on April 17, 2021, 13:28
 * 
 * The program implements a tester of AS5040 magnetic sensor. It reads the data
 * from the sensor through SSI interface and displays the received data on the
 * screen in user-readable form.
 * 
 * The LCD is Matrix Orbital LCD2021. It has two lines, 20 symbols in each line.
 * The displayed data has the following format:
 * 
 * a=XXXo status 11111*
 * GGG.................
 * 
 * where
 *   XXX   - angle as integer,
 *   11111 - status bits from AS5040: OCF, COF, LIN, Mag INCc, Mag DECn,
 *   *     - activity indicator which indicates that the software isn't stuck,
 *   GGG   - bar graph. Its length corresponds to the angle. Each square is
 *             equal to 18 degrees.
 * 
 * The peripherals are connected to Port D of the MCU. The pins are connected
 * to the following lines:
 * PD0 (UART RX) - LCD TX
 * PD1 (UART TX) - LCD RX
 * PD2 (GPIO)    - AS5040 DO
 * PD3 (GPIO)    - AS5040 CS
 * PD4 (GPIO)    - AS5040 CLK
 * 
 * The program was written for ATmega8-16PU (8-bit MCU 8kB Flash 0.5kB EEPROM,
 * PDIP-28) and was tested with this chip only.
 * 
 * The program was tested with the following fuses: E=FF, H=C9, L=3F.
 * http://eleccelerator.com/fusecalc/fusecalc.php?chip=atmega8&LOW=3F&HIGH=C9&LOCKBIT=FF
 * 
 * You may not use this code or parts of it for commercial purposes without
 * my written permission. For any questions please write to
 * iosaaris AT gmail.com.
 * 
 * Dmitry M.
 * 4X1MD
 * https://github.com/4x1md
 *  
 */

/* CPU speed */
#define F_CPU 11059200UL

#include <stdio.h>
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/power.h>

/* UART speed */
#define BAUDRATE 9600
#define UBRR_VALUE (uint16_t)((F_CPU / (BAUDRATE * 16UL)) - 1)

/* NOP assember command */
#define _NOP() asm("nop")

/* Port D pin configuration */
/* Pin assignment:
 * PD0 - UART RX
 * PD1 - UART TX
 * PD2 - AS5040 DO
 * PD3 - AS5040 CS
 * PD4 - AS5040 CLK
 */
#define UART_TX PORTD1
#define AS5040_DO PORTD2
#define AS5040_CS PORTD3
#define AS5040_CLK PORTD4
#define ALL_OFF 0b00000000

/* Sensor definitions */
/* Sensor's CS is connected to PD3 */
#define CS_HIGH (1 << AS5040_CS)
#define CS_LOW ~(1 << AS5040_CS)
/* Sensor's clock is connected to PD4 */
#define CLK_HIGH (1 << AS5040_CLK)
#define CLK_LOW ~(1 << AS5040_CLK)
/* Delay between CS and CLK pin changes */
#define SSI_DELAY 10
/* Number of bits to read for each field */
#define ANGLE_BITS 10
#define STATUS_BITS 5

/* Screen definitions */
/* A delay is required after power-on before communicating with the screen.
 * It is not documented in the datasheet. Experimentally it was found that
 * a 100ms delay works well. 64ms delay after reset and additional 40ms startup
 * delay in software give the required 100ms.
 */
#define DISPLAY_STARTUP_DELAY 40
#define GREETING_MESSAGE_TIME 3000 /* Time to show the greeting message */
/* Special symbols shown on the screen */
#define ANGLE_SYMBOL 0xE0
#define DEGREE_SYMBOL 0xDF
/* Activity symbols which show that the device is active and didn't stuck. */
#define ACTIVITY_SYMBOL_1 0xA1
#define ACTIVITY_SYMBOL_2 0xDB
//#define DEGREE_SYMBOL 0xDF
/* Angle location on the screen and number of characters */
#define ANGLE_LOC_X 3
#define ANGLE_LOC_Y 1
/* Status bits location on the screen and number of characters */
#define BITS_LOC_X 15
#define BITS_LOC_Y 1
/* Bar graph bits location on the screen and maximum length */
#define GRAPH_BAR_X 1
#define GRAPH_BAR_Y 2
#define GRAPH_BAR_LEN 20
/* Received data validity */
#define PARITY_ERROR 0x01
#define SENSOR_DISCONNECTED 0x02
/* Delay between iterations */
#define DELAY_MS 60

/* Functions */
void lcd_send_byte(char);
void lcd_send_string(const char[]);
void init_display();
void clear_display();
void show_startup_message();
void init_screen();
uint16_t bits2angle();
void angle2str(char[], uint16_t);
void refresh_screen();
void draw_bar_graph(uint8_t);
void display_error_message(uint8_t);
void display_activity_indicator();
void goto_screen_pos(uint8_t, uint8_t);
void ssi_delay();

/* Constants */
/* Startup message which is shown during the first 3-5 sec after power-on */
const char startup_line1[21] = "Dima M.  050-0000000\0";
const char startup_line2[21] = "www.github.com/4x1md\0";
/* First line of the screen */
const char screen_line1[21] = "\xE0=---\xDF status -----*\0";
/* Error strings */
const char error_sensor_disconnected[21] =   "Sensor disconnected!\0";
const char error_data_invalid[21] = "   Parity  error!   \0";
const char error_angle[4] = "---\0";
char error_bits[6] = "-----\0";

/* Global variables */
char angle_str[4] = "---\0"; /* Angle string */
char status_bits_str[6] = "-----\0"; /* Status bits string */
uint8_t graph_bar_len = 0; /* Length of the displayed graph bar */
char activity_indicator = '*';  /* Symbol which shows that the device isn't stuck */

/*
 * Function: main()
 * 
 *   Main function which contains startup routines and the main loop.
 *
 *   returns:	none
 */
int main() {
    /* Port D initialization */
    DDRD |= ((1 << UART_TX) | (1 << AS5040_CS) | (1 << AS5040_CLK));
	PORTD &= ALL_OFF;
    PORTD |= CS_HIGH;
    PORTD |= CLK_HIGH;
  
    /* UART initialization */
    /* Source: https://likora.wordpress.com/2011/06/18/working-atmega8-usart */
	/* Set baud rate */
	UBRRH = (uint8_t) (UBRR_VALUE >> 8);
	UBRRL = (uint8_t) UBRR_VALUE;

	/* Set USART to async and frame format to 8 data bits, no parity, 1 stop bit */
	UCSRC |= (1<<URSEL) | (1 << UCSZ1) | (1 << UCSZ0);
	/* Enable transmission */
    UCSRB |= (1 << TXEN);
    
    /* Clear USART status register */
    UCSRA = 0x00;
    
    /* Screen initialization and greeting message */
    _delay_ms(DISPLAY_STARTUP_DELAY);
    init_display();
    show_startup_message();
    init_screen();
    
    /* Variables */
    uint8_t n = 0; /* Counter */
    uint8_t as5040_do_bit = 0; /* Bit from the DO pin of the sensor. */
    uint16_t angle_bits = 0; /* Raw angle data from the sensor */
    uint16_t angle = 0; /* Angle as integer */
    uint8_t bits_sum = 0; /* Sum of the received bits for error detection. */
    uint8_t act_count = 0x00; /* Activity symbol counter. */
    
    /* Main loop */
    while (1)
    {
        /* Set variables before data reading cycle */
        bits_sum = 0;
        angle_bits = 0;
        
        /* Read data from the sensor */
        /* Change CS to low and after tCLKFE change CLK to low. */
        PORTD &= CS_LOW;
        ssi_delay();
        PORTD &= CLK_LOW;
        ssi_delay();

        /* Read angle data bits */
        for (n = 0; n < ANGLE_BITS; n++)
        {
            /* Toggle clock and read the next bit. */
            PORTD |= CLK_HIGH;
            ssi_delay();
            as5040_do_bit = (PIND >> AS5040_DO) & 0x01;

            /* Add the new bit to the angle value. */
            angle_bits = angle_bits << 1;
            angle_bits |= as5040_do_bit;
            
            /* Add the received bit to bits sum. */
            bits_sum += as5040_do_bit;
            
            /* Return CLK to LOW */
            PORTD &= CLK_LOW;
            ssi_delay();
        }

        /* Read status bits */
        for (n = 0; n < STATUS_BITS; n++)
        {
            /* Toggle clock and read the next bit. */
            PORTD |= CLK_HIGH;
            ssi_delay();
            as5040_do_bit = (PIND >> AS5040_DO) & 0x01;

            /* Add the received bit to the bits string. */
            status_bits_str[n] = 0x30 + as5040_do_bit;
            
            /* Add the received bit to bits sum. */
            bits_sum += as5040_do_bit;
            
            /* Return CLK to LOW */
            PORTD &= CLK_LOW;
            ssi_delay();
        }

        /* Read parity bit */
        PORTD |= CLK_HIGH;
        ssi_delay();

        as5040_do_bit = (PIND >> AS5040_DO) & 0x01;
        bits_sum += as5040_do_bit;
        
        /* Set CS to HIGH to end the current transmission. */
        PORTD |= CS_HIGH;
        
        /* Generate the next activity indicator */
        act_count++;
        if ((act_count & 0b00000100) == 0)
        {
            activity_indicator = ACTIVITY_SYMBOL_1;
        }
        else
        {
            activity_indicator = ACTIVITY_SYMBOL_2;
        }
        
        /* Sum of all the received bits is used for error detection:
         * 1. Sensor connection detection. If the sum is 0, nothing was received,
         * therefore we suppose that the sensor is disconnected. There is a
         * probability that the sensor sent all zeros, but it is negligible.
         * 2. Parity error. The parity is even. If there were no data errors,
         * we'll receive an even number of bits (including parity bit). In this
         * case the last bit of the sum will be 0.
         */
        if (bits_sum == 0)
        {
            display_error_message(SENSOR_DISCONNECTED);
            _delay_ms(DELAY_MS);
            continue;
        }
        
        if ((bits_sum & 0x01) != 0)
        {
            display_error_message(PARITY_ERROR);
            _delay_ms(DELAY_MS);
            continue;
        }
        
        /* Process the received angle data */
        /* Convert raw angle bits to angle as integer, then convert the angle
         * to string and then calculate bar graph length.
         */
        angle = bits2angle(angle_bits);
        angle2str(angle_str, angle);
        
        /* Calculate graph bar length */
        /* Each 18 degrees correspond to one square on the graph bar.
         * 360 degrees value (all 10 bits are 1) is difficult to get in
         * practice. In order to improve UX, the full graph bar (20 squares) is
         * displayed when the angle reaches 358 degrees. */
        if (angle > 357)
        {
            graph_bar_len = 20;
        }
        else
        {
            graph_bar_len = (uint8_t)(angle / 18);
        }
        
        /* Display all the relevant data on the screen */
        refresh_screen();
        _delay_ms(DELAY_MS);

    }
    /* End of the main loop */
    
    return (EXIT_SUCCESS);
}

/*
 * Function: lcd_send_byte(char c)
 * 
 * Waits until sending of the previous byte is completed.
 * Then sends a byte through UART.
 * 
 * returns:	none
 */
void lcd_send_byte(char c)
{
    while(!(UCSRA & (1<<UDRE))){};
    UDR = c;
}

/*
 * Function: lcd_send_string(char string[])
 *
 * Sends a null-terminated string without the termination character to the LCD.
 * 
 * returns:	none
 */
void lcd_send_string(const char string[])
{
    uint8_t n = 0; /* Counter */
    
    while(string[n] != 0)
    {
        lcd_send_byte(string[n]);
        n++;
    }
}

/*
 * Function: init_display()
 * 
 * Initializes the display for the first time after power-on.
 * 
 * returns: none
 */
void init_display()
{
    clear_display();
    
    /* Backlight on */
    /* 0xFE 0x42 0x00 */
    lcd_send_byte(0xFE);
    lcd_send_byte(0x42);
    lcd_send_byte(0x00);
    
    /* Auto Line Wrap Off */
    /* Syntax 0xFE 0x44 */
    lcd_send_byte(0xFE);
    lcd_send_byte(0x44);
    
    /* Auto Scroll Off */
    /* Syntax 0xFE 0x82 */
    lcd_send_byte(0xFE);
    lcd_send_byte(0x82);
    
    /* Go To Top Left */
    /*Syntax 0xFE 0x48 */
    lcd_send_byte(0xFE);
    lcd_send_byte(0x48);
}

/*
 * Function: clear_display()
 * 
 * Clears the display.
 * 
 * returns: none
 */
void clear_display()
{
    /* Clear Display */
    /* Syntax 0xFE 0x58 */
    lcd_send_byte(0xFE);
    lcd_send_byte(0x58);
}

/*
 * Function: show_startup_message()
 * 
 * Shows the startup message with developer information.
 * 
 * returns: none
 */
void show_startup_message()
{
    goto_screen_pos(1, 1);
    lcd_send_string(startup_line1);
    
    goto_screen_pos(1, 2);
    lcd_send_string(startup_line2);
    
    _delay_ms(GREETING_MESSAGE_TIME);
}

/*
 * Function: init_screen()
 * 
 * Clears the screen and writes the template for the main screen.
 * 
 * returns: none
 */
void init_screen()
{
    clear_display();
    
    goto_screen_pos(1, 1);
    lcd_send_string(screen_line1);
}

/*
 * Function: bits2angle(uint16_t angle_bits)
 * 
 * Converts raw angle data to angle in degrees.
 * 
 * Parameters:
 *   angle_bits - bits from the sensor representing the angle.
 * 
 * returns:	angle in degrees as integer.
 */
uint16_t bits2angle(uint16_t angle_bits)
{
    uint32_t raw_angle = angle_bits;
    return (uint16_t)(raw_angle * 360 / 1024);
}

/*
 * Function: angle2str(char angle_str[], uint16_t angle)
 * 
 * Converts angle data as integer to string.
 * 
 * Parameters:
 *   angle_str - pointer to the output string,
 *   angle - angle value as integer.
 * 
 * returns:	angle as string.
 */
void angle2str(char angle_str[], uint16_t angle)
{
    uint8_t digit = 0;
    
    /* Hundreds digit */
    digit = (uint8_t)(angle % 10);
    angle_str[2] = digit + 0x30;
    
    /* Tens digit */
    angle = angle / 10;
    digit = (uint8_t)(angle % 10);
    angle_str[1] = digit + 0x30;
    
    /* Ones digit */
    angle = angle / 10;
    digit = (uint8_t)(angle);
    angle_str[0] = digit + 0x30;
}

/*
 * Function: refresh_screen()
 * 
 * Writes current values of angle, status bits and updates activity symbol
 * and bar graph.
 * 
 * returns: none
 */
void refresh_screen()
{
    /* Write angle */
    goto_screen_pos(ANGLE_LOC_X, ANGLE_LOC_Y);
    lcd_send_string(angle_str);
    
    /* Write bits */
    goto_screen_pos(BITS_LOC_X, BITS_LOC_Y);
    lcd_send_string(status_bits_str);
    
    /* Display activity indicator */
    display_activity_indicator();
    
    /* Update graph bar */
    draw_bar_graph(graph_bar_len);
}

/*
 * Function: draw_bar_graph(uint8_t len)
 * 
 * Clears the display.
 * 
 * Parameters:
 *   len - desired length of the bar graph.
 * 
 * returns: none
 */
void draw_bar_graph(uint8_t len)
{
    goto_screen_pos(GRAPH_BAR_X, GRAPH_BAR_Y);
    
    uint8_t n = 0;
    /* Fill black squares */
    for (n = 0; n < len; n++)
    {
        lcd_send_byte(0xFF);
    }
    
    /* Write white squares */
    uint8_t white_cells = GRAPH_BAR_LEN - len;
    for (n = 0; n < white_cells; n++)
    {
        lcd_send_byte(0x20);
    }    
}

/*
 * Function: display_error_message(uint8_t error_code)
 * 
 * Displays error message according to the received error code.
 * 
 * Parameters:
 *   error_code - id of the error to display.
 * 
 * returns: none
 */
void display_error_message(uint8_t error_code)
{
    /* Display error message */
    goto_screen_pos(GRAPH_BAR_X, GRAPH_BAR_Y);
    
    switch(error_code)
    {
        case SENSOR_DISCONNECTED:
            lcd_send_string(error_sensor_disconnected);
            break;
        case PARITY_ERROR:
        default:
            lcd_send_string(error_data_invalid);
            break;
    }
    
    /* Display dashes in place of the angle digits */
    goto_screen_pos(ANGLE_LOC_X, ANGLE_LOC_Y);
    lcd_send_string(error_angle);
    
    /* Display dashes in place of the bit digits */
    goto_screen_pos(BITS_LOC_X, BITS_LOC_Y);
    lcd_send_string(error_bits);
    
    /* Display activity indicator */
    display_activity_indicator();
}

/*
 * Function: display_activity_indicator()
 * 
 * Displays the activity indication symbol.
 * and bar graph.
 * 
 * returns: none
 */
void display_activity_indicator()
{
    lcd_send_byte(activity_indicator);
}

/*
 * Function: goto_screen_pos(uint8_t x, uint8_t y)
 * 
 * Moves the cursor to the specified location on the screen.
 * 
 * Parameters:
 *   x - column number,
 *   y - row number.
 * 
 * returns: none
 */
void goto_screen_pos(uint8_t x, uint8_t y)
{
    /* Go To Position */
    /* Syntax 0xFE 0x47 <column number> <row number> */
    lcd_send_byte(0xFE);
    lcd_send_byte(0x47);
    lcd_send_byte(x);
    lcd_send_byte(y);
}

/*
 * Function: ssi_delay()
 * 
 * Creates delay between CS and CLK level changes on the SSI bus.
 * 
 * returns:	none
 */
void ssi_delay()
{
    for (int n = 0; n < SSI_DELAY; n++)
    {
        _NOP();
    }
}
