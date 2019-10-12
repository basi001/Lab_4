/*	Author: basi001
 *  Partner(s) Name: chris hyunh
 *	Lab Section:
 *	Assignment: Lab #  Exercise #
 *	Exercise Description: [optional - include for your own benefit]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif
#define A0 PINA&0x01

enum LED_States {LED_On, LED_Off} LED_State;

//global
unsigned char tmpB0 = 0x00;
unsigned char tmpB1 = 0x00;

void LED_func()
{
	switch(LED_State){
		case LED_Off:
			if(!A0){LED_State = LED_Off;}
			else{LED_State = LED_On;}
			break;
		case LED_On:
			if(A0){LED_State = LED_On;}
			else{LED_State = LED_Off;}
			break;
		default:
			LED_State = LED_Off;
			break;
	}

	switch(LED_State){
		case LED_Off:
			tmpB0 = 0x01;
			tmpB1 = 0x00;
			break;
		case LED_On:
			tmpB0 = 0x00;
			tmpB1 = 0x02;
			break;
	}
		PORTB = (tmpB0 + tmpB1);
}
		

int main(void) {
    /* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF;
	DDRB = 0xFF; PORTB = 0x00;
    /* Insert your solution below */
    while (1) {
	LED_State = LED_Off;
	LED_func();
    }
    return 1;
}
