@ This file is designed to take a given string in R0 and parse it out into
@ number 1, a sign operation, and number 2
@ R1 = Our character register, we place individual characters into this register to perform operations
@ R3 = A copy of the R0 register for manipulation
@ R4 = Our character offset - tells us which character of our string we are on
@ R5 = Our number length
@ R6 = Our operation sign
@ R7 = Our first number
@ R8 = Our second number
@ R9 = Our number counter

.global parser

parser:
	@LDR R0, =testBuff @ Load R0 with a predetermined string
	MOV R3, R0 @ Load R0 into R3
	MOV R4, #0 @ Our offset counter
	MOV R5, #0 @ Our number length counter
	MOV R9, #0 @ Our number counter
	MOV R10,R14 @ Move our link register into R10 for future branching
	LDRB R1,[R3,R4] @ Load the first character into R1

checkChar:
	CMP R1,#0x00 @ Checking whether next character is null
	BEQ main @ End of string found, return to main program
	CMP R1,#0x20 @ Checking whether next character is a space
	BEQ isSpace @ Jumps to our space handler
	CMP R1,#0x30 @ Checking whether our ascii value is a digit
	BLT getSign @ If less than 0x30, it's not a digit
	CMP R1, #0x39 @ Checking whether our ascii value is a digit
	BGT getSign @ If greater than 0x39, it's not a digit
isNum:
	ADD R5,#1 @ Add one to our number length
	ADD R4,#1 @ Add one to our offset to get next character
	LDRB R1,[R3,R4] @ Load the next character into R3
	B checkChar @ Go back to checkChar to check again

isSpace:
	ADD R4,#1 @ Add one to our offset to get the next character
	LDRB R1,[R3,R4] @ Load the next character into R1
	BL getNums
	B checkChar @ Go back to checkChar to check again

getNums:
	CMP R9,#0 @ Check if we're still on our first number
	BEQ firstNum @ If less than, we will be storing our first number
	BGT secondNum @ If greater than zero, we will be storing our second number
	B isSpace

getSign:
	MOV R6,R1 @ Load our sign character into R6
	ADD R4, #1 @ Add one to our offset to get the next character
	LDRB R1,[R3,R4] @ Load the next character into R1 
	B checkChar @ Go back to checkChar to check again

firstNum:
	ADD R9,#1
	BL getFirstNum @ Gets our first number and places it into R7
	B checkChar @ Go back to checkChar to check again

secondNum:
	BL getSecondNum @ Gets our second number and places it into R8
	MOV R14,R10 @ Place our saved address into LR
	BX LR @ Branch back to main program

.data
testBuff: .ascii "15 + 15"


