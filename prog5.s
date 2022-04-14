.global main

main:
	LDR R0, =prompt @ Loads R0 with our input prompt
	BL puts @ Branches and links to the C library puts function to print out our prompt
	LDR R0, =buffer @ Loads R0 with our buffer
	BL gets @ Branches and links to the C library gets function to get our input
	BL parser @ Branches and links to our parser file
	BL getOp @ Branches and links to our getOp file
	MOV R0,R7 @ Move our final answer into R0
	BL getDecVal @ Print out our decimal value
	MOV R7, #1 @ Exit our program
	SVC 0 @ Calls service

.data
prompt: .ascii "Please enter an equation in x + y format: " @ This will be our prompt for the user
buffer: .space 100 @ This will be our buffer for input
