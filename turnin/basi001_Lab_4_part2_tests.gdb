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

# Add tests below
test "PINA 0x00 => PORTC: 0x07, SM_State: Wait"
set SM_State = Init
setPINA 0x00
continue 5
expectPORTC 0x07
expect SM_State Wait
checkResult

test "PINA 0x03 => PORTC: 0x00, SM_State: Reset"
set SM_State = Init
setPINA 0x03
continue 5
expectPORTC 0x00
expect SM_State Wait
checkResult

test "dec x 1 => PORTC: 0x06, SM_State: Wait"
set SM_State = Init
setPINA 0x02
continue 2
expectPORTC 0x06
expect SM_State Wait
checkResult

test "dec x 8 => PORTC: 0x00, SM_State: Wait"
set SM_State = Init
setPINA 0x02
continue 8
expectPORTC 0x00
expect SM_State Wait
checkResult

test "inc x 1 => PORTC: 0x08, SM_State: Wait"
set SM_State = Init
setPINA 0x01
continue 2
expectPORTC 0x08
expect SM_State Wait
checkResult

test "inc x 3 => PORTC: 0x09, SM_State: Wait"
set SM_State = Init
setPINA 0x01
continue 5
expectPORTC 0x09
expect SM_State Wait
checkResult

test "dec x 2 => PORTC: 0x05,  SM_State: Wait, inc x 3 => PORTC: 0x08 SM_State = Wait"
setPINA 0x02
continue 4
setPINA 0x00
continue 10
expectPORTC 0x05
expect SM_State Wait
setPINA 0x01
continue 3
setPINA 0x00
continue 10
expectPORTC 0x08
expect SM_State Wait
checkResult

set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
echo ======================================================\n
