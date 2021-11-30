# registor map
# s0: m_w
# s1: m_z
# s2: rows
# s3: cols

# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


	# FUNCTIONS

	#FUNCTION introduction()
	# prints the introduction message and gets first player randomly

	introduction:
		li $v0, 4 # print string
		la $a0, introMessage
		syscall # print introduction

		li $v0, 4 # print string
		la $a0, enterNumOne
		syscall # print message to enter first num

		li $v0,5		# read_int syscall code = 5
		syscall	
		move $s0,$v0		# move result to m_w
		
		li $v0, 4 # print string
		la $a0, enterNumTwo
		syscall # print message to enter first num

		li $v0,5		# read_int syscall code = 5
		syscall	
		move $s1,$v0		# move result to m_z



	# FUNCTION getUserInput() will get one integer value from the user
	getUserInput:
		



	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
	introMessage: .asciiz "Welcome to Connect Four, Five in a row variant!\nImplemented by Ethan Coe-Renner\nEnter two positive numbers to initialize the random number generator.\n"
	enterNumOne: .asciiz "Number 1: "
	enterNumTwo: .asciiz "Number 2: "
	introMessage2: .asciiz "Human player (H)\nComputer Player (C)\nCoin toss...\n"
	humanFirstMessage: .asciiz "HUMAN goes first"
	computerFirstMessage: .asciiz "COMPUTER goes first"
