# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

	addi $s0, $zero, 12 # C=12

	addi $t0, $zero, 0 # i=0
	la $s1, arraya # s1 = &A[5]
	la $s2, arrayb # s2 = &B[]

	for: bge $t0, 5, endfor
	     lw $t2, 0($s2) # t2 = arrayb[i]

	     add $t3, $t2, $s0 # A[i] = B[i] + C

	     sw $t1, 0($s1) # t1 = arraya[i]

	     add $s2, $s2, 4 # i++
	     add $s1, $s1, 4 # i++
	     j for

	endfor:

	addi $t0, $t0, -1 # i--

	while: blt $t0, 0, end  # while i>= 0
	       addi $s1, $s1, -1 
	       lw $t4, 0($s1) # A[i]
	       add $t4, $t4, $t4
	       sw $t4, 0($s1) # A[i] = A[i]*2
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
