.data 
    stack: .space 208 # 1 (top_pointer) + 1 (length) + 50 (memory space) words

.text
    .globl main

main:
    la $a0, stack
    jal STACK_INIT

    la $a0, stack
    li $a1, 'H'
    jal PUSH
    
    la $a0, stack
    li $a1, 'C'
    jal PUSH
        
    la $a0, stack
    li $a1, 'M'
    jal PUSH
    
    la $a0, stack
    li $a1, 'U'
    jal PUSH

    la $a0, stack
    li $a1, 'T'
    jal PUSH
    
    jal PRINT_STACK_CHAR

    jal END_PROGRAM

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

STACK_POINTER: # nguyenpanda
    # STACK_LENGTH(stack_pointer $a0) => $v0 (address)    
    move $v0, $a0
    jr $ra  # Return STACK_POINTER

STACK_TOP:
    # STACK_TOP(stack_pointer $a0) => $v0 (address)    
    lw $v0, 0($a0)
    jr $ra  # Return STACK_TOP

STACK_LENGTH: # nguyenpanda
    # STACK_LENGTH(stack_pointer $a0) => $v0 (int)    
    lw $v0, 4($a0)
    jr $ra  # Return STACK_LENGTH

PUSH: # nguyenpanda
    # PUSH(stack_pointer $a0, value: <T> = $a1) => void
    #   - Push a <T> to stack
    # Parameters:
    #   a0: stack_pointer
    #   a1: value
    ##### Init function  #####
        addi $sp, $sp, -24
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $a1, 8($sp)
        sw $t0, 12($sp) # pointer
        sw $t1, 16($sp) # length
        sw $t2, 20($sp) # stack_size or pointer to top

        jal STACK_POINTER
        move $t0, $v0

        jal STACK_LENGTH
        move $t1, $v0

    ##### Main function  #####
        # Check for stack overflow
        mul $t2, $t1, 4     # Calculate current stack size in bytes
        bge $t2, 200, STACK_OVERFLOW

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

    jr $ra  # Return PUSH

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

        jal STACK_POINTER
        move $t0, $v0
        addiu $t0, $t0, 8

        jal STACK_TOP
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

STACK_OVERFLOW:
    # Handle stack overflow (optional)
    # This could involve printing an error message and exiting the program.
    # For simplicity, we just halt the program here.
    li $v0, 10
    syscall


######
PRINT_CHAR: # nguyenpanda
    # PRINT_CHAR(char = $a0) => void
    #   - Print a char to screen
    # Parameters:
    #   a0: Display char
    ##### Main function  #####
    li $v0, 11  # PRINT_CHAR
    syscall
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
	ascii_exit_prompt:  .asciiz "Exiting program...!\n"