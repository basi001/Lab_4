# Test file for Lab4_statemachines


# commands.gdb provides the following functions for ease:
#   test "<message>"
#       Where <message> is the message to print. Must call this at the beginning of every test
#       Example: test "PINA: 0x00 => expect PORTC: 0x01"
#   checkResult
#       Verify if the test passed or failed. Prints "passed." or "failed." accordingly, 
#       Must call this at the end of every test.
#   expectPORTx <val>
#       With x as the port (A,B,C,D)
#       The value the port is epected to have. If not it will print the erroneous actual value
#   setPINx <val>
#       With x as the port or pin (A,B,C,D)
#       The value to set the pin to (can be decimal or hexidecimal
#       Example: setPINA 0x01
#   printPORTx f OR printPINx f 
#       With x as the port or pin (A,B,C,D)
#       With f as a format option which can be: [d] decimal, [x] hexadecmial (default), [t] binary 
#       Example: printPORTC d
#   printDDRx
#       With x as the DDR (A,B,C,D)
#       Example: printDDRB

echo ======================================================\n
echo Running all tests..."\n\n

test "no input => PORTB: 0x01 Unlocked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x00
continue 10
expectPORTB 0x01
expectPORTC 0x01
expect next_key_state Wait
checkResult

test "test when A7 => PORTB: 0x00 Locked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x80
continue 2
setPINA 0x00
continue 2
expectPORTB 0x00
expectPORTC 0x01
checkResult

test " test when A7, A2, A1 => PORTB: 0x01 Unlocked , PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x80
continue 2
setPINA 0x00
continue 2
#locked
setPINA 0x04
continue 2
setPINA 0x00
continue 2
#pound
setPINA 0x02
continue 2
setPINA 0x00
continue 2
#y
#unlocked
expectPORTB 0x01
expectPORTC 0x01
expect next_key_state Wait
checkResult

test "test when A7, A2,A0 => PORTB: 0x00 Locked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x80
continue 2
setPINA 0x00
continue 2
#locked
setPINA 0x04
continue 2
setPINA 0x00
continue 2
#pound
setPINA 0x01
continue 2
#x
expectPORTB 0x00
expectPORTC 0x01
expect next_key_state Wait
checkResult

test "test when A2, A2, A7  => PORTB: 0x00 Locked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x80
continue 2
setPINA 0x00
continue 2
#locked
setPINA 0x04
continue 2
setPINA 0x00
continue 2
#pound
setPINA 0x04
continue 1
#pound
expectPORTB 0x00
expectPORTC 0x01
expect next_key_state Wait
checkResult

test "test when A7, A1 => PORTB: 0x00 Locked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x80
continue 2
setPINA 0x00
continue 2
#locked
setPINA 0x20
continue 2
#y
expectPORTB 0x00
expectPORTC 0x01
expect next_key_state Wait
checkResult

test "test when A7, A0 => PORTB: 0x00 Locked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x80
continue 2
setPINA 0x00
continue 2
#locked
setPINA 0x01
continue 2
#x
expectPORTB 0x00
expectPORTC 0x01
expect next_key_state Wait
checkResult

#this just tests to see if it locks the door after y like it should
test "test when A2, A1, A0 => PORTB: 0x01 Unlocked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x07
continue 2
expectPORTB 0x01
expectPORTC 0X01
expect next_key_state Wait
checkResult

test "test when A2, A1 => PORTB: 0x01 Unlocked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x06
continue 2
expectPORTB 0x01
expectPORTC 0X01
expect next_key_state Wait
checkResult

test "test when A2, A0 => PORTB: 0x01 Unlocked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x05
continue 2
expectPORTB 0x01
expectPORTC 0X01
expect next_key_state Wait
checkResult

test "test when A1, A0 => PORTB: 0x00 Locked, PORTC: 1. Wait"
set next_key_state = Init
setPINA 0x03
continue 2
expectPORTB 0x01
expectPORTC 0X01
expect next_key_state Wait
checkResult

set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
echo ======================================================\n
