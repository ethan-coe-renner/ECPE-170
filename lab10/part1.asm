# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

	addi $s0, $zero, 15 # A = 15
	addi $s1, $zero, 10 # B = 10
	addi $s2, $zero, 7 # C = 7
	addi $s3, $zero, 2 # D = 2
	addi $s4, $zero, 18 # E = 18
	addi $s5, $zero, -3 # F = -3
	addi $s6, $zero, 0 # Z = 0

	add $t0, $s0, $s1 # A+B
	sub $t1, $s2, $s3 # C-D
	add $t2, $s4, $s5 # E+F
	sub $t3, $s0, $s2 # A-C

	add $s6, $t0, $t1 # (A+B) + (C-D)
	add $s6, $s6, $t2 # (A+B) + (C-D) + (E+F)
	sub $s6, $s6, $t3 # (A+B) + (C-D) + (E+F) - (A-C)

	sw $s6, value
	
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
	value:	.word 1
