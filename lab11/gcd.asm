# A Stub to develop assembly code using QtSPIM

        # Declare main as a global function
        .globl      main

        # All program code is placed after the
        # .text assembler directive
        .text

# The label 'main' represents the starting point
main:

        li          $s1, 3              # m_w initialized
        li          $s2, 5              # m_z initialized

        li          $s3, 0              # i = 0


loop:
        bge         $s3, 10, exit

        li          $a0 0
        li          $a1 10000
        jal         randrange           # generate first random number
        move        $s4, $v0

        jal         randrange           # generate second random number
        move        $s5, $v0

        move        $a0, $s4
        move        $a1, $s5

        jal         gcd                 # calculate gcd
        move        $s6, $v0

        addi        $s3, $s3, 1         # i++

        li          $v0, 4              #print string
        la          $a0, gcdmessage1
        syscall

        li          $v0, 1              #print decimal
        move        $a0, $s4            #print first random number
        syscall

        li          $v0, 4              #print string
        la          $a0, gcdmessage2
        syscall

        li          $v0, 1              #print decimal
        move        $a0, $s5            #print second random number
        syscall

        li          $v0, 4              #print string
        la          $a0, gcdmessage3
        syscall

        li          $v0, 1              #print decimal
        move        $a0, $s6            #print gcd
        syscall


        li          $v0, 4              #print string
        la          $a0, gcdmessage4
        syscall

        j           loop


        # Exit the program by means of a syscall.
        # There are many syscalls - pick the desired one
        # by placing its code in $v0. The code for exit is "10"

exit:
        li          $v0, 10             # Sets $v0 to "10" to select exit syscall
        syscall                         # Exit


        # FUNCTION: int gcd(int n1,int n2)
        # euclid's algorithm
        # a0: n1, a1: n2
gcd:
        beq         $a1, $zero, ret     # n2 == 0

        div         $a0, $a1
        mfhi        $t0                 # t0 = n1 % n2

        add         $a0, $zero, $a1     # set a0 to a1
        add         $a1, $zero, $t0     # gcd(n2, n1%n2)
        j           gcd                 # recursively call gcd

ret:
        add         $v0, $zero, $a0     # return n1

        jr          $ra                 # exit function


        # FUNCTION: get_random()
        # m_w = s1
        # m_z = s2

getrand:
                # m_z
        and         $t0, $s2, 65535     # m_z & 65535
        srl         $t1, $s2, 16        # m_z >> 16

        addu        $t2, $zero, 36989
        mul         $t0, $t0, $t2       # 36989 * m_z & 65535

        addu        $s2, $t0, $t1       # m_z = 36969 * (m_z & 65535) + (m_z >> 16)

                # m_w

        and         $t0, $s1, 65535     # m_w & 65535
        srl         $t1, $s1, 16        # m_w >> 16

        addu        $t2, $zero, 18000
        mul         $t0, $t0, $t2       # 18000 * m_w & 65535

        addu        $s1, $t0, $t1       # m_w = 18000 * (m_w & 65535) + (m_w >> 16)


        sll         $t0, $s2, 16        # m_z << 16

        addu        $v0, $t0, $s1       # return m_z << 16 + m_w

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

        # All memory structures are placed after the
        # .data assembler directive
        .data

        # The .word assembler directive reserves space
        # in memory for a single 4-byte word (or multiple 4-byte words)
        # and assigns that memory location an initial value
        # (or a comma separated list of initial values)
        #For example:
        #value: .word 12
gcdmessage1: .asciiz"\nG.C.D of "
gcdmessage2: .asciiz" and "
gcdmessage3: .asciiz" is "
gcdmessage4: .asciiz". "

