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



enum SM_States {Init, Wait, Add, Minus, Reset} SM_State;

//global
unsigned char tmpC = 0x07;

void SM_func()
{
	switch(SM_State){
		case Init:
			SM_State = Init;
			break;
		case Add:
			
		case Minus:
			
		case Reset:
			
		case Wait:
			if(PINA == 0x01){
				SM_State = Add;
				break;
			}
			else if(PINA == 0x02){
				SM_State = Minus;
				break; 
			}
			else if(PINA == 0x03){
				SM_State = Reset; 
				break;
			}
			else {
				SM_State = Wait; 
				break;
			}
	}
	
	switch(SM_State){
		case Init:
			tmpC = 0x07;
			SM_State = Wait;
			break;
		case Wait:
			tmpC = tmpC;
			SM_State = Wait;
			break;
		case Add:
			if(tmpC >= 9){
				tmpC = 0x09;
				SM_State = Wait;
				break;

			} else {
				tmpC = tmpC + 0x01;
				SM_State = Wait;
				break;
			}
		case Minus:
			if(tmpC <= 0){
				tmpC = 0x00;
				SM_State = Wait;
				break;
			} else {
				tmpC = tmpC - 0x01;
				SM_State = Wait;
				break;
			}
		case Reset:
			tmpC = 0x00;
			SM_State = Wait;
	}
	PORTC = tmpC;
}
		

int main(void) {
    /* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF;
	DDRC = 0xFF; PORTC = 0x00;
	SM_State = Init;
    /* Insert your solution below */
    while (1) {
	SM_func();
    }
    return 1;
}
