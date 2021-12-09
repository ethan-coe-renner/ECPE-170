# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:
	la $s0, array # array pointer in array
	addi $s2, $zero, 4 # array size
	add $s0, $s0, $s2 # go to end of array

	addi $s1, $zero, 7

	jal arraySearch

	move $s4, $v0

	blt $s4, 0, notfound

	li          $v0, 4              # print string
        la          $a0, foundmessage1
        syscall
	
	li          $v0, 1              # print string
        move $a0, $s1
        syscall

	li          $v0, 4              # print string
        la          $a0, foundmessage2
        syscall

	li          $v0, 1              # print string
        move $a0, $s2
        syscall

	notfound:

	li          $v0, 4              # print string
        la          $a0, notfoundmessage
        syscall
	j exit

	exit:


	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


	# s0: array[arraySize]*, s1: search, 
	arraySearch:
		lw $t0, 0($s0) # load current value from array
		bne $t0, $s1, sizetest
		
		move $s2, $v0

		jr $ra

		sizetest:
		bne $s2, -1, recursion

		addi $v0, $zero, -1
		jr $ra
		
		recursion:
			addi $s2, $s2, -1 # decrease size by 1
			addi $s0, $s0, -4 #go back one in array

			addi $sp, $sp, -4
        		sw $ra, 0($sp)
        		jal         arraySearch
        		lw $ra, 0($sp)
        		addi $sp, $sp, 4

			jr $ra


	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
	#For example:
	array:	.word 2, 3, 5, 7, 11
	foundmessage1: .asciiz "Element "
	foundmessage2: .asciiz " found at array index "
	notfoundmessage: .asciiz "Search key not found"
