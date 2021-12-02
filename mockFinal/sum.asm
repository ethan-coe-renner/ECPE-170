# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

	li          $v0, 4              # print string
        la          $a0, enterint
        syscall   


 	li          $v0,5               # read_int syscall code = 5
        syscall
        move        $a0,$v0 # s0 = num
	
	jal sum

	move $s0, $v0

	li          $v0, 4              # print string
        la          $a0, sumprint
        syscall


	li $v0, 1
	move $a0, $s0
	syscall

	# Exit the program by means of a syscall.
	# There are many syscalls - pick the desired one
	# by placing its code in $v0. The code for exit is "10"

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit




	# FUNCTION sum(), $a0: n
	sum:
		move $t0, $a0

		loop:
		beq $a0, 0, exit
		addi $a0, $a0, -1 # n -1

		add $t0, $t0, $a0 # n + sum(n-1)

		j loop

		exit:
			move $v0, $t0
			jr $ra

	# All memory structures are placed after the
	# .data assembler directive
	.data

	# The .word assembler directive reserves space
	# in memory for a single 4-byte word (or multiple 4-byte words)
	# and assigns that memory location an initial value
	# (or a comma separated list of initial values)
	#For example:
	#value:	.word 12
	enterint: .asciiz "Enter a positive integer: "
	sumprint: .asciiz "\nSum = "
