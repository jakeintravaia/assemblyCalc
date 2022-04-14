@ This program takes an ascii number and converts it to binary for us
@ R0 = Main input
@ R1 = Selected character
@ R2 = Multiplication factor
@ R3 = Copy of R0 for manipulation
@ R4 = Offset counter
@ R5 = Number length
@ R8 = Final number in binary

.global getSecondNum

getSecondNum:
	push {R0-R6} @ Push all our used registers to the stack
	LDRB R1,[R3,R4] @ Select our first digit
	MOV R9,R4 @ Copy our initial position for later
	MOV R5,#0 @ Reset our number length
	MOV R8,#0 @ Clear our final number register

getLen:
	CMP R1,#0x00 @ Check if next character is null
	BEQ checkLen @ If so, we've found our length
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	ADD R5,#1 @ Add one to R5 if we haven't found our length yet
	B getLen @ Loop if we haven't found our null character

checkLen:
	MOV R4,R9 @ Move our initial position back into R4
	LDRB R1,[R3,R4] @ Select our initial digit
	CMP R5,#3 @ Check if our number is 3 digits long
	BEQ threeDigits @ If so, jump to threeDigits subroutine
	CMP R5,#2 @ Check if our number is 2 digits long
	BEQ twoDigits @ If so, jump to twoDigits subroutine

oneDigit:
	SUB R1,#0x30 @ Convert to binary
	MOV R8,R1 @ Load final number into R8
	pop {R0-R6}
	BX LR @ Branch back to main program

twoDigits:
	MOV R2,#10 @ Move our multiplication value to R2
	SUB R1,#0x30 @ Convert to binary
	MOV R8,R1 @ Load number into R7
	MUL R8,R2 @ Multiply it by 10
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	SUB R1,#0x30 @ Convert to binary
	ADD R8,R1 @ Add it to our final number
	pop {R0-R6}
	BX LR @ Branch back to main program

threeDigits:
	MOV R2,#100 @ Move our multiplication value to R2
	SUB R1,#0x30 @ Convert to binary
	MUL R1,R2 @ Multiply our number by 100
	MOV R8,R1 @ Move our number into R8
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	MOV R2,#10 @ Change our multiplication factor to 10
	SUB R1,#0x30 @ Convert to binary
	MUL R1,R2 @ Multiply R1 by 10
	ADD R8,R1 @ Add number to R8
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	SUB R1,#0x30 @ Convert to binary
	ADD R8,R1 @ Add it to R8
	pop {R0-R6}
	BX LR @ Branch back to main program

.data
testBuff: .ascii "154"
