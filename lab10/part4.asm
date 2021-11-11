# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

	addi $s2, $zero, 12 # C=12

	la $s0, arraya # s0 = &A[5]
	la $s1, arrayb # s1 = &B[]

	addi $s3, $zero, 0 # i=0

	for: beq $s3, 5, endfor
	     add $t0, $s3, $s3 #2i
	     add $t0, $t0, $t0 # 4i

	     add $t1, $s1, $t0 # array B + i

	     lw $t2, 0($t1) #B[i]

	     add $t2, $t2, $s2 # B[i] + C

	     add $t3, $t0, $s0 # A + i

	     sw $t2, 0($t3) # A[i] = B[i] + C

	     addi $s3, $s3, 1 # i++

	     j for

	endfor:

	addi $s3, $s3, -1 # i--


	while: beq $s3, -1, end # i>=0
	       add $t0, $s3, $s3 #2i
	       add $t0, $t0, $t0 # 4i

	       add $t1, $t0, $s0 # arraya + i
	       lw $t2, 0($t1) # A[i]

	       add $t2, $t2, $t2 # 2A[i]

	       sw $t2, 0($t1) # A[i] = A[i] * 2
	       addi $s3, $s3, -1
	       j while

	end:

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
	arraya: .space 20
	arrayb: .word 1, 2, 3, 4, 5
