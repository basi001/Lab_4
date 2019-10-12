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

enum Key_States {Init, Wait, PoundPress, PoundRelease, Y_Key_Press, Y_Key_Release, Lock_Key_Press, Lock_Key_Release} next_key_state;

void Door_Lock() { 
	switch (next_key_state) { //Transitions
		case Init:
			next_key_state = Init;
			break;
		case Wait:
			if (PINA == 0x04) {
				next_key_state = PoundPress;
				break;
			}
			else if (PINA == 0x80) {
				next_key_state = Lock_Key_Press;
				break;
			}
			else {
				next_key_state = Wait;
				break;
			}
		case PoundPress:
			if (PINA == 0x04) {
				next_key_state = PoundPress;
				break;
			}
			else if (PINA == 0x00) {
				next_key_state = PoundRelease;
				break;
			}
			else {
				next_key_state = Wait;
				break;
			}
		case PoundRelease:
			if (PINA == 0x02) {
				next_key_state = Y_Key_Press;
				break;
			}
			else if (PINA == 0x00) {
				next_key_state = PoundRelease;
				break;
			}
			else {
				next_key_state = Wait;
				break;
			}
		case Y_Key_Press:
			if (PINA == 0x02) {
				next_key_state = Y_Key_Press;
				break;
			}
			else if (PINA == 0x00) {
				next_key_state = Y_Key_Release;
				break;
			}
			else {
				next_key_state = Wait;
				break;
			}
		case Y_Key_Release:
			next_key_state = Y_Key_Release;
			break;
		case Lock_Key_Press:
			if (PINA == 0x80) {
				next_key_state = Lock_Key_Press;
				break;
			}
			else {
				next_key_state = Lock_Key_Release;
				break;
			}
		case Lock_Key_Release:
			next_key_state = Wait;
			break;			
	}
	switch (next_key_state) { //Actions
		case Init:
			PORTB = 0x01;
			next_key_state = Wait;
			break;
		case Wait:
			next_key_state = Wait;
			break;
		case PoundPress:
			next_key_state = PoundPress;
			break;
		case PoundRelease:
			next_key_state = PoundRelease;
			break;
		case Y_Key_Press:
			next_key_state = Y_Key_Press;
			break;
		case Y_Key_Release:
			PORTB = 0x01;
			next_key_state = Wait;
			break;
		case Lock_Key_Press:
			PORTB = 0x00;
			next_key_state = Lock_Key_Press;
			break;
		case Lock_Key_Release:
			PORTB = 0x00;
			next_key_state = Lock_Key_Release;
			break;

	}
}

int main(void) {
    /* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF;
	DDRB = 0xFF; PORTB = 0x00;
	DDRC = 0xFF; PORTC = 0x00;
	next_key_state = Init;

    /* Insert your solution below */
    while (1) {
	Door_Lock();
	PORTC = next_key_state;
    }
    return 1;
}
