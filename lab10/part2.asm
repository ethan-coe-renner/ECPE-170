# A Stub to develop assembly code using QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point
main:

	addi $s0, $zero, 10 # A=10
	addi $s1, $zero, 15 # B=15
	addi $s2, $zero, 6 # C=6
	addi $s3, $zero, 0 # Z=0

	bgt $s0, $s1, zone # if A > B
	addi $t0, $zero, 5 # temp variable 5
	blt $s2, $t0, zone # if C<5


	ble $s0, $s1, zthree # if A <= B
	addi $t1, $s2, 1 # temp variable C+1
	addi $t0, $zero, 7 # temp variable 7
	beq $t0, $t1, ztwo


	zone: addi $s3, $zero, 1 # Z=1
	      j endif

	ztwo: addi $s3, $zero, 2 # Z=2
	      j endif

	zthree: addi $s3, $zero, 3 # Z=3



	beq $s3, -1, znone
	beq $s3, -2, zntwo
	j zzero


	znone:
		addi $s3, $zero, -1
		j end

	zntwo:
		addi $s3, $zero, -2
		j end

	zzero:
		addi $s3, $zero, 0


	end: sw $s3, value

	
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
