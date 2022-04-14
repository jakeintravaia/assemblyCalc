@ The purpose of this file is to correctly identify the operation the user inputted and then perform the correct operation accordingly
@ R5 = Division counter
@ R6 = Operation
@ R7 = Operand 1 and final answer
@ R8 = Operand 2

.global getOp

getOp:
	MOV R1,#0 @ Clear R1
	MOV R2,#0 @ Clear R2
	MOV R3,#0 @ Clear R3
	MOV R4,#0 @ Clear R4
	MOV R5,#0 @ Clear R5
	@MOV R6,#0x2f @ Temporary operation to test functionality
	@MOV R7,#10 @ Temporary value to test functionality
	@MOV R8,#2 @ Temporary value to test functionality
findOp:
	CMP R6,#0x2b @ Check if our operation is addition
	BEQ add @ Perform addition on our numbers
	CMP R6,#0x2d @ Check if our operation is subtraction
	BEQ subtract @ Perform subtraction on our numbers
	CMP R6,#0x2a @ Check if our operation is multiplication
	BEQ multiply @ Perform multiplication on our numbers
	CMP R6,#0x2f @ Check if our operation is division
	BEQ divide @ Perform division on our numbers

add:
	ADD R7,R8 @ Add R7 + R8 and place in R7
	BX LR @ Branch back to our main program

subtract:
	SUB R7,R8 @ Subtract R7 - R8 and place in R7
	BX LR @ Branch back to our main program

multiply:
	MUL R7,R8 @ Multiply R7 and R8 and place in R7
	BX LR @ Branch back to our main program

divide:
	SUB R7,R8 @ Subtract R7 - R8 and place in R7
	ADD R5,#1 @ Add one to our resultant
	CMP R7,#0 @ Compare R7 to 0
	BGT divide @ Loop if R7 > 0
	MOV R7,R5 @ When finished, move the resultant into R7
	BX LR @ Branch back to main program
