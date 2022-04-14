@ This program takes an ascii number and converts it to binary for us
@ R0 = Main input
@ R1 = Selected character
@ R2 = Multiplication factor
@ R3 = Copy of R0 for manipulation
@ R4 = Offset counter
@ R5 = Number length
@ R6 = Final number in binary

.global getFirstNum

getFirstNum:
	push {R0-R6} @ Push all our used registers to the stack
	MOV R4,#0 @ Reset our offset
	LDRB R1,[R3,R4] @ Select our first digit
	CMP R5,#3 @ Check if our number is 3 digits long
	BEQ threeDigits
	CMP R5,#2 @ Check if our number is 2 digits long
	BEQ twoDigits

oneDigit:
	SUB R1,#0x30 @ Convert to binary
	MOV R7,R1 @ Load final number into R7
	pop {R0-R6} @ Return previous contents of registers
	BX LR @ Branch back to main program

twoDigits:
	MOV R2,#10 @ Move our multiplication value to R2
	SUB R1,#0x30 @ Convert to binary
	MOV R7,R1 @ Load number into R7
	MUL R7,R2 @ Multiply it by 10
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	SUB R1,#0x30 @ Convert to binary
	ADD R7,R1 @ Add it to our final number
	pop {R0-R6} @ Return previous contents of registers
	BX LR @ Branch back to main program

threeDigits:
	MOV R2,#100 @ Move our multiplication value to R2
	SUB R1,#0x30 @ Convert to binary
	MUL R1,R2 @ Multiply our number by 100
	MOV R7,R1 @ Move our number into R7
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	MOV R2,#10 @ Change our multiplication factor to 10
	SUB R1,#0x30 @ Convert to binary
	MUL R1,R2 @ Multiply R1 by 10
	ADD R7,R1 @ Add number to R7
	ADD R4,#1 @ Add one to our offset
	LDRB R1,[R3,R4] @ Select next digit
	SUB R1,#0x30 @ Convert to binary
	ADD R7,R1 @ Add it to R7
	pop {R0-R6} @ Return previous contents of our registers
	BX LR @ Branch back to main program

.data
testBuff: .ascii "154"
