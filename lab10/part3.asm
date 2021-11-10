# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

	addi $s0, $zero, 2 # Z = 2
	addi $s1, $zero, 0 # i = 0

	loopone: bgt $s1, 20, looptwo # i>20
		 addi $s0, $s0, 1 # Z++
		 addi $s1, $s1, 2 # i+=2
		 j loopone

	looptwo: bge $s0, 100, loopthree # Z<100
		 addi $s0, $s0, 1 # Z++
		 j looptwo

	loopthree: ble $s1, 0, end # i>0
		   addi $s0, $s0, -1 # Z--
		   addi $s1, $s1, -1 # i--
		   j loopthree
	
	end: sw $s0, zvalue
	     sw $s1, ivalue

	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
	#For example:
	ivalue:	.word 1
	zvalue:	.word 1
