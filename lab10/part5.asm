	# Start .text segment (program code)
	.text
	
	.globl	main
main:
	# Print string msg1
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	# load the address of msg
	syscall

	# Get input A from user and save
	la $s0, buffer # buffer base
	li $s1, 256 # buffer size
	li	$v0,8		# read_string syscall code = 8
	la $a0, buffer # argument 0 is buffer base
	li $a1, 256 # argument 1 is buffer size
	syscall	


	lb $t0, 0($s0) #first char
	while: beq $t0, 0, notfound #run until end
	       beq $t0, 101, found # found e
	       addi $s0, $s0, 1
	       lb $t0, 0($s0) #next char
	       j while


	# Print string msg3
	notfound:
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msgnotfound	# load the address of msg3
	syscall
	j end

	# Print string msg2
	found:
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msgfound	# load the address of msg2
	syscall

	li $v0,1 #print string
	add $a0, $zero, $s0 #memory address of match
	syscall

	li	$v0,4		# print_string syscall code = 4
	la	$a0, msgfound2	# load the address of msg2
	syscall

	li $v0,4 #print string
	add $a0, $zero, $s0 #memory address of match
	syscall

	j end

	end:
	li	$v0,10		# exit
	syscall

	# Start .data segment (data!)
	.data
msg1:	.asciiz	"Enter a string: "

msgfound:	.asciiz	"First match at address "
msgfound2: .asciiz "\nThe matching character is "

msgnotfound:	.asciiz "e not found"

buffer: .space 256

