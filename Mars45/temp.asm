.data 
    stack: .space 208 # 1 (top_pointer) + 1 (length) + 50 (memory space) words // TODO: Change 50

.text
    .globl main

main:
    la $a0, stack
    jal STACK_INIT

    li $a1, 'H'
    jal STACK_PUSH    
    li $a1, 'C'
    jal STACK_PUSH
    li $a1, 'M'
    jal STACK_PUSH
    li $a1, 'U'
    jal STACK_PUSH
    li $a1, 'T'
    jal STACK_PUSH
    li $a1, ' '
    jal STACK_PUSH
    li $a1, 'N'
    jal STACK_PUSH
    li $a1, 'H'
    jal STACK_PUSH
    li $a1, 'U'
    jal STACK_PUSH
    li $a1, ' '
    jal STACK_PUSH
    li $a1, 'L'
    jal STACK_PUSH
    li $a1, 'O'
    jal STACK_PUSH
    li $a1, 'N'
    jal STACK_PUSH

    jal PRINT_STACK_CHAR

    la $a0, stack
    jal STACK_POP
    move $a0, $v0
    jal PRINT_CHAR

    jal new_line

    la $a0, stack
    jal STACK_POP
    move $a0, $v0
    jal PRINT_CHAR

    jal new_line

    la $a0, stack
    jal PRINT_STACK_CHAR

    la $a0, stack
    jal STACK_TOP
    move $a0, $v0
    jal PRINT_CHAR

    jal new_line

    jal END_PROGRAM

### STACK
STACK: # nguyenpanda
    # MUST CALL STACK_INIT($a0 = stack) BEFORE USING STACK
    # STACK ACHITECTURE
    # |   address of element_n   |      int       |    <T>    |    <T>    | ... |     <T> (top)   | null | null | ... | null (MAX_CAPACITY) |
    # | top_pointer -> element_n | length = n + 1 | element_0 | element_1 | ... | element_n (top) | null | null | ... | null (MAX_CAPACITY) |
    #                |                                                               ^
    #                |_______________________________________________________________|
    
    STACK_INIT: # nguyenpanda
        # STACK_INIT(stack_pointer $a0) => void
        #   - Initialize the stack
        # Parameters:
        #   a0: stack_pointer
        ##### Init function  #####
            addi $sp, $sp, -8
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            move $t0, $a0
            
        ##### Main function  #####
            # Initialize top_pointer
            addi $t0, $a0, 8
            sw $t0, 0($a0)

            # Initialize length
            li $t0, 0
            sw $t0, 4($a0)
        
        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            addi $sp, $sp, 8
        jr $ra  # Return STACK_INIT

    __STACK_POINTER: # nguyenpanda
        # STACK_LENGTH(stack_pointer $a0) => $v0 (address)
        #  - Get the address of the top_pointer
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: address of the top_pointer 
        move $v0, $a0
        jr $ra  # Return __STACK_POINTER

    __STACK_INSERT_ADDRESS: # nguyenpanda
        # __STACK_INSERT_ADDRESS(stack_pointer $a0) => $v0 (address)    
        #  - Get the address of the top, which is the next available space
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: address of the top where we can insert new element
        lw $v0, 0($a0)
        jr $ra  # Return __STACK_INSERT_ADDRESS

    STACK_LENGTH: # nguyenpanda
        # STACK_LENGTH(stack_pointer $a0) => $v0 (int)
        #   - Get the length of the stack
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: length
        lw $v0, 4($a0)
        jr $ra  # Return STACK_LENGTH

    STACK_PUSH: # nguyenpanda
        # STACK_PUSH(stack_pointer $a0, value: <T> = $a1) => void
        #   - Push a <T> to stack
        # Parameters:
        #   a0: stack_pointer
        #   a1: value
        ##### Init function  #####
            addi $sp, $sp, -24  # STACK_PUSH use 6 registers ($ra, $a0, $a1, $t0, $t1, $t2)
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            sw $a1, 8($sp)
            sw $t0, 12($sp)     # pointer
            sw $t1, 16($sp)     # length
            sw $t2, 20($sp)     # stack_size or pointer to top

            jal __STACK_POINTER
            move $t0, $v0

            jal STACK_LENGTH
            move $t1, $v0

        ##### Main function  #####
            # Check for stack overflow
            mul $t2, $t1, 4     # Calculate current stack size in bytes
            bge $t2, 200, __STACK_OVERFLOW    # // TODO: Change 50

            # Now $t2 is the pointer to the top of the stack
            # Increment stack length
            addi $t1, $t1, 1
            sw $t1, 4($t0)

            # Push value to stack
            lw $t2, ($t0)
            sw $a1, ($t2)

            # Move top_pointer to the next element
            addiu $t2, $t2, 4
            sw $t2, 0($t0)

        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $a1, 8($sp)
            lw $t0, 12($sp)
            lw $t1, 16($sp)
            lw $t2, 20($sp)
            addi $sp, $sp, 24

        jr $ra  # Return STACK_PUSH

    STACK_TOP: # nguyenpanda
        # STACK_TOP(stack_pointer $a0) => $v0 (value: <T>)    
        #   - Get the top element of the stack
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: value
        ##### Init function  #####
            addi $sp, $sp, -12  # STACK_TOP use 3 registers ($ra, $a0, $t0)
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            sw $t0, 8($sp)      # lenght

        ##### Main function  #####
            jal STACK_LENGTH
            move $t0, $v0

            blez $t0, __STACK_UNDERFLOW   # Check for stack underflow (length <= 0)
            bgt $t0, 50, __STACK_OVERFLOW # Check for stack underflow (length > 50) // TODO: Change 50

            jal __STACK_INSERT_ADDRESS
            move $t0, $v0
            addiu $t0, $t0, -4
            lw $v0, 0($t0)

        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $t0, 8($sp)
            addi $sp, $sp, 12

        jr $ra  # Return TOP

    STACK_POP: # nguyenpanda
        # STACK_POP(stack_pointer $a0) => void
        #   - Pop the top element of the stack
        # Parameters:
        #   a0: stack_pointer
        ##### Init function  #####
            addi $sp, $sp, -24  # STACK_POP use 6 registers ($ra, $a0, $t0, $t1, $t2, $t3)
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            sw $t0, 8($sp)      # stack_pointer
            sw $t1, 12($sp)     # length
            sw $t2, 16($sp)     # top_pointer
            sw $t3, 20($sp)     # return value

            move $t0, $a0

            jal STACK_TOP
            move $t3, $v0

        ##### Main function  #####
            jal STACK_LENGTH
            move $t1, $v0
        
            blez $t1, __STACK_UNDERFLOW   # Check for stack underflow (length <= 0)
            bgt $t1, 50, __STACK_OVERFLOW # Check for stack underflow (length > 50) // TODO: Change 50

            # Decrement stack length
            addiu $t1, $t1, -1
            sw $t1, 4($t0)

            # Move top_pointer to the previous element
            jal __STACK_INSERT_ADDRESS
            move $t2, $v0
            addiu $t2, $t2, -4
            sw $zero, 0($t2)
            sw $t2, 0($t0)
            
        ##### Reset function  #####
            move $v0, $t3 # Return value
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $t0, 8($sp)
            lw $t1, 12($sp)
            lw $t2, 16($sp)
            lw $t3, 20($sp)
            addi $sp, $sp, 24

        jr $ra  # Return STACK_POP

    PRINT_STACK_CHAR:
        # PRINT_STACK(stack_pointer $a0) => void
        #   - Print stack contents
        # Parameters:
        #   a0: stack_pointer
        ##### Init function  #####
            addi $sp, $sp, -24
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            sw $t0, 8($sp)  # begin
            sw $t1, 12($sp) # top

            jal __STACK_POINTER
            move $t0, $v0
            addiu $t0, $t0, 8

            jal __STACK_INSERT_ADDRESS
            move $t1, $v0

        ##### Main function  #####
        __loop_PRINT_STACK:
            # Check if stack.begin() == stack.top()
            beq $t0, $t1, __end_PRINT_STACK

            # Print stack contents
            lw $a0, 0($t0)
            jal PRINT_CHAR

            # Move to the next element in the stack
            addiu $t0, $t0, 4
            j __loop_PRINT_STACK

        __end_PRINT_STACK:
        jal new_line

        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $t0, 8($sp)
            lw $t1, 12($sp)
            lw $t2, 16($sp)
            addi $sp, $sp, 24
        jr $ra  # Return PRINT_STACK

    __STACK_OVERFLOW:
        # Handle stack overflow (optional)
        # This could involve printing an error message and exiting the program.
        # For simplicity, we just halt the program here.
        la $a0, ascii_stack_overflow
        jal PRINT_STRING
        li $v0, 10
        syscall

    __STACK_UNDERFLOW:
        # Handle stack underflow (optional)
        # This could involve printing an error message and exiting the program.
        # For simplicity, we just halt the program here.
        la $a0, ascii_stack_underflow
        jal PRINT_STRING
        li $v0, 10
        syscall
        
######
PRINT_CHAR: # nguyenpanda
    # PRINT_CHAR(char = $a0) => void
    #   - Print a char to screen
    # Parameters:
    #   a0: Display char
    ##### Init function  #####
        addi $sp, $sp, -8  # PRINT_CHAR: use 2 registers $a0, $ra
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        
    ##### Main function  #####
        li $v0, 11  # PRINT_CHAR
        syscall

    ##### Reset function #####
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8

    jr $ra  # Return PRINT_CHAR

PRINT_INT: # nguyenpanda
    # PRINT_CHAR(int = $a0) => void
    #   - Print a int to screen
    # Parameters:
    #   a0: Display int
    ##### Main function  #####
    li $v0, 1  # PRINT_INT
    syscall
    jr $ra  # Return PRINT_INT

new_line: # RestingKiwi
    li $v0, 11    # new_line
    la $a0, '\n'
    syscall
    jr $ra  # Return new_line

PRINT_STRING: # nguyenpanda
    # PRINT_STRING(string = $a0) => void
    #   - Print a string to screen
    # Parameters:
    #   a0: Display string
    ##### Main function  #####
    li $v0, 4   # PRINT_STRING
    syscall
    jr $ra  # Return PRINT_STRING

END_PROGRAM: # nguyenpanda
    la $a0, ascii_exit_prompt
    jal PRINT_STRING
    li $v0, 10                  # syscall 10: exit
    syscall
    
.data
	ascii_exit_prompt:      .asciiz "Exiting program...!\n"
    ascii_stack_overflow:   .asciiz "Stack overflow!\n"
    ascii_stack_underflow:  .asciiz "Stack underflow!\n"