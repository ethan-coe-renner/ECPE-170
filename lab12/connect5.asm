# registor map
# s0: m_w
# s1: m_z
# s2: rows
# s3: cols
# s4: first
# s5: lastrow
# s6: lastcol
# s7: turnCount


# A Stub to develop assembly code using QtSPIM

        # Declare main as a global function
        .globl      main

        # All program code is placed after the
        # .text assembler directive
        .text

# The label 'main' represents the starting point
main:
        jal introduction

	jal gameLoop


        # Exit the program by means of a syscall.
        # There are many syscalls - pick the desired one
        # by placing its code in $v0. The code for exit is "10"
        li          $v0, 10             # Sets $v0 to "10" to select exit syscall
        syscall                         # Exit


        # FUNCTIONS

        #FUNCTION introduction()
        # prints the introduction message and gets first player randomly

introduction:
	addi $s3, $zero, 7 # set cols
	addi $s2, $zero, 6 #set rows

        li          $v0, 4              # print string
        la          $a0, introMessage
        syscall                         # print introduction

        li          $v0, 4              # print string
        la          $a0, enterNumOne
        syscall                         # print message to enter first num

        li          $v0,5               # read_int syscall code = 5
        syscall
        move        $s0,$v0             # move result to m_w

        li          $v0, 4              # print string
        la          $a0, enterNumTwo
        syscall                         # print message to enter first num

        li          $v0,5               # read_int syscall code = 5
        syscall
        move        $s1,$v0             # move result to m_z

        li          $a0, 0
        li          $a1, 1

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         randrange
	lw $ra, 0($sp)
	addi $sp, $sp, 4

        move        $s4, $v0            # random num in range 0,1

        beq         $s4, 0, compFirst
        # human first
        li          $v0, 4              # print string
        la          $a0, humanFirstMessage
        syscall                         # print message that human is first
	jr $ra

compFirst:
        li          $v0, 4              # print string
        la          $a0, computerFirstMessage
        syscall                         # print message that human is first

	jr $ra
#### End introduction



# FUNCTION gameLoop() runs main loop for game
gameLoop:
	addi $s7, $zero, 0 # set turn to 0

	beq $s4, 0, compPlayFirst
	humanPlayFirst:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         humanTurn
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $s7, $s7, 1 # add one to turn

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         computerTurn
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $s7, $s7, 1 # add one to turn

	beq $s7, 42, endgameloop # exit game if board full

	j humanPlayFirst

	compPlayFirst:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         computerTurn
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $s7, $s7, 1 # add one to turn

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         humanTurn
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $s7, $s7, 1 # add one to turn

	beq $s7, 42, endgameloop # exit game if board full

	j compPlayFirst

	endgameloop:
	jr $ra


# FUNCTION printBoard()
# prints the board
printBoard:
        li          $v0, 4              # print string
        la          $a0, boardHeader
        syscall                         # print message to enter first num

	addi $t0, $zero, 0 # t0 is the current index in the board
	la $t1, board # t1 is the address in board

	loopprint: beq $t0, 42, exitprint # exit when index = 42 (rows * cols)

	lbu $a0, ($t1)
        li          $v0, 11              # print char
        syscall                         # print message to enter first num

        li          $v0, 4              # print string
        la          $a0, space
        syscall                         # print space between characters

	addu $t1, $t1, 1 # t0 = board[t1]
	addi $t0, $t0, 1 # t0++

	div $t0, $s3
	mfhi $t2 # t2 = t0 % cols

	bne $t2, 0, nonl # if modulus != 0, no newline is printed

        li          $v0, 4              # print string
        la          $a0, nl
        syscall                         # print newline

	nonl:
	j loopprint

	exitprint:
	jr $ra


# FUNCTION dropChar()
# drops a char at a0 in column $a1
dropChar:
	addi $t0, $s2, -1 # rows - 1: curcell
	mul $t0, $t0, $s3 # multiply by cols
	add $t0, $t0, $a1 # add col

	la $t1, board # t1 is the address in board

	addi $t2, $zero, 0 # current row = 1

	addi $t3, $zero, 46 # ascii code for '.'


	dropwhile:
	addu $t5, $t1, $t0 
	lbu $t4, ($t5) # set t4 to the index at board[t0]
	beq $t4, $t3, exitdropwhile # if board[curcell] == '.'
	blt $t0, 0, exitdropwhile # if curcell lt 0
	sub $t0, $t0, $s3 # curcell -= cols
	add $t2, $t2, 1 # row++

	j dropwhile

	exitdropwhile:

	bge $t0, 0, colnotfull

	addi $v0, $zero, 1 #return 1
	jr $ra

	colnotfull:
	addu $t1, $t1, $t0 # &board[curcell]
	sb $a0, 0($t1) # put char in board at curcell

	sub $s5, $s2, $t2 #rows-row
	addi $s5, $s5, 1 # set s5 to last played row

	addi $s6, $a1, 1 # set s6 to last played col

	addi $v0, $zero, 0 #return 0

	jr $ra

# FUNCTION humanTurn() no arguments, places a 'H' in a chosen column
humanTurn:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal printBoard
	lw $ra, 0($sp)
	addi $sp, $sp, 4

        li          $v0, 4              # print string
        la          $a0, enterCol 
        syscall                         # print to entercolumn

        li          $v0,5               # read_int syscall code = 5
        syscall
        move        $t0,$v0             # move result to t0

	li $a0, 72
	addi $a1, $t0, -1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal dropChar
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra


# FUNCTION computerTurn() no arguments, places a 'C' in a random column
computerTurn:
        li          $a0, 0 # lower limit 0
        move          $a1, $s3 # upper limit cols

	compWhile:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         randrange
	lw $ra, 0($sp)
	addi $sp, $sp, 4

        move        $t0, $v0            # random num in range 0, col

        li          $v0, 4              # print string
        la          $a0, computerPlaysMessage
        syscall                         # print string

	li $a0, 67 
	move $a1, $t0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal dropChar
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	beq $v0, 1, compWhile


        li          $v0, 4              # print string
        la          $a0, nl
        syscall                         # print newline
	
	jr $ra

	

getrand:
                                        # m_z
        and         $t0, $s1, 65535     # m_z & 65535
        srl         $t1, $s1, 16        # m_z >> 16

        addu        $t2, $zero, 36989
        mul         $t0, $t0, $t2       # 36989 * m_z & 65535

        addu        $s1, $t0, $t1       # m_z = 36969 * (m_z & 65535) + (m_z >> 16)

                    # m_w

        and         $t0, $s0, 65535     # m_w & 65535
        srl         $t1, $s0, 16        # m_w >> 16

        addu        $t2, $zero, 18000
        mul         $t0, $t0, $t2       # 18000 * m_w & 65535

        addu        $s0, $t0, $t1       # m_w = 18000 * (m_w & 65535) + (m_w >> 16)


        sll         $t0, $s1, 16        # m_z << 16

        addu        $v0, $t0, $s0       # return m_z << 16 + m_w

        jr          $ra                 # exit function

                    # FUNCTION: random_in_range(int low, int high)
        # a0 = low
        # a1 = high
        # returns random integer between a0 and a1 in v0

randrange:
        move        $t2, $ra            # save ra to t2
        sw          $ra, 32($sp)
        jal         getrand
        move        $t0, $v0            #t0 = random number

        subu        $t1, $a1, $a0
        addu        $t1, $t1, 1         # range = high -low + 1

        divu        $t0, $t1            # rand num % range
        mfhi        $t0

        addu        $v0, $t0, $a0       # randnum % range + low
        lw          $ra,32($sp)
        jr          $ra

#FUNCTION checkLine()
# checks in the direction (drow,dcol), where $a0: drow, $a1: dcol
checkLine:
	add $t0, $s5, $a0 # currow = row +drow
	add $t1, $s6, $a1 # curcol = col + dcol
	li $t2, 1 # length starts at 1
	move $t4, $a0
	move $t5, $a1

	la $t6, board # t6 is the address in board

	move $a0, $s5 #lastrow
	move $a1, $s6 #lastcol

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         getIndex
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	move $t3, $v0 #t3 is the index of last element played
	addu $t3, $t3, $t6 # t3 is the address of last element played
	lbu $t3, ($t3) # t3 is the last element played

	firstwhileloop:

	move $a0, $t0 # current cell to check col
	move $a1, $t1 # current cell to check col

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         getIndex
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	move $t7, $v0 #t7 is the index of current element to check
	addu $t7, $t7, $t6 # t7 is the address of current element to check
	lbu $t7, ($t7) # t7 is the current element to check

	bne $t7, $t3, invertdelta

	addi $t2,$t2,1 # length++
	add $t0, $t0, $t4 #currow += drow
	add $t1, $t1, $t5 #curcol += dcol

	j firstwhileloop


	invertdelta:
	mul $t4, $t4, -1 # drow *= -1
	mul $t5, $t5, -1 # dcol *= -1

	add $t0, $s5, $t4 # currow = row +drow
	add $t1, $s6, $t5 # curcol = col + dcol

	secondwhileloop:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
        jal         getIndex
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	move $t7, $v0 #t3 is the index of current element to check
	addu $t7, $t7, $t6 # t3 is the address of current element to check
	lbu $t7, ($t7) # t3 is the current element to check

	bne $t7, $t3, endcheckline

	addi $t2,$t2,1 # length++
	add $t0, $t0, $t4 #currow += drow
	add $t1, $t1, $t5 #curcol += dcol

	j secondwhileloop

	endcheckline:
	bge $t2, 5, wincond
	li $v0, 0
	jr $ra

	wincond:
	li $v0, 1
	jr $ra


# FUNCTION getIndex() takes $a0: row and $a1: col and calculates the index in the board associated with those parameters
getIndex:
        mul         $v0, $a0, $s3       # multiply row * cols

        add         $v0, $v0, $a1       # add row * cols + col

        addi $v0, $v0, -1 # subtract 1 from current

        jr $ra # return with $v0 as total

        # All memory structures are placed after the
        # .data assembler directive
        .data

        # The .word assembler directive reserves space
        # in memory for a single 4-byte word (or multiple 4-byte words)
        # and assigns that memory location an initial value
        # (or a comma separated list of initial values)
introMessage: .asciiz "Welcome to Connect Four, Five in a row variant!\nImplemented by Ethan Coe-Renner\nEnter two positive numbers to initialize the random number generator.\n"
enterNumOne: .asciiz"Number 1: "
enterNumTwo: .asciiz"Number 2: "
introMessage2: .asciiz "Human player (H)\nComputer Player (C)\nCoin toss...\n"
humanFirstMessage: .asciiz "HUMAN goes first\n"
computerFirstMessage: .asciiz "COMPUTER goes first\n"

computerPlaysMessage: .asciiz "Computer playing"

enterCol: .asciiz "Enter a column number: "

board: .asciiz ".........................................."
boardHeader: .asciiz "1 2 3 4 5 6 7\n--------------\n"

nl: .asciiz "\n"
space: .asciiz " "
debug: .asciiz "\ngot here\n"
