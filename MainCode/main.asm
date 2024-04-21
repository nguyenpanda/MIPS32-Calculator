# spim .asm
.data
    filename:   .asciiz "calc_log.txt"

    ## Array
        # arr_byte_valid:     .byte '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '*', '/', '.', 'M', '^', '!', '(', ')'
        # arr_byte_operator:  .byte '+', '-', '*', '/', '^', 'M', '!', '(', ')'
        # arr_byte_number:    .byte '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'
        arr_byte_operator:  .byte '+', '-', '*', '/', '^', '!'

    ## String
        quit_string:        .asciiz "quit"
        ascii_out_prompt:   .asciiz "Result: "
        ascii_in_prompt:    .asciiz "Please insert your expression: "
        ascii_quit_prompt:  .asciiz "You have typed 'quit'.\n"
        ascii_exit_prompt:  .asciiz "Exiting program...!\n"

    ## Exception
        # exc_divide_by_zero:         .asciiz "Error: Divide by zero\n"
        # exc_inval_input:            .asciiz "Error: Invalid input\n"
        # exc_inval_expression:       .asciiz "Error: Invalid expression\n"
        # exc_inval_operator:         .asciiz "Error: Invalid operator\n"
        # exc_inval_number:           .asciiz "Error: Invalid number\n"
        # exc_inval_parenthesis:      .asciiz "Error: Invalid parenthesis\n"
        # exc_inval_factorial:        .asciiz "Error: Invalid factorial\n"
        # exc_inval_power:            .asciiz "Error: Invalid power\n"
        # exc_inval_logarithm:        .asciiz "Error: Invalid logarithm\n"
        factorial_out_of_bound:     .asciiz "Error: Factorial's argument must less than 16, got n="
    
    ## Color
        color_r: .asciiz "\033[1;91m" 	# Red color escape sequence
        color_g: .asciiz "\033[1;92m" 	# Green color escape sequence
        color_y: .asciiz "\033[1;93m" 	# Yellow color escape sequence
        color_b: .asciiz "\033[1;94m" 	# Blue color escape sequence
        color_m: .asciiz "\033[1;95m" 	# Magenta color escape sequence
        color_c: .asciiz "\033[1;96m" 	# Cyan color escape sequence
        color_w: .asciiz "\033[1;97m" 	# White color escape sequence
        reset:   .asciiz "\033[0m" 	    # Reset color escape sequence

    ## Variables
        input_string:   .space 101 # MAX LENGTH OF INPUT STRING IS 100
        stack0          .space 100 # Stack for INFIX_TO_POSTFIX
        stack1          .space 100 # Stack for EVALUATE_POSTFIX
.text
    .globl  main
    
main:
    main_loop: # Loop and ask user to input
        # Print "Please insert your expression: "
        jal CYAN
        la $a0, ascii_in_prompt     # Load address of input prompt
        jal PRINT_STRING            # Print input prompt
        jal RESET

        # Read input from user
        la $a0, input_string        # Load address of input buffer
        li $a1, 100                 # Set max length of input buffer (1 space for null character)
        jal READ_STRING_FROM_USER   # Read input from user

        # 'quit' check
        la $a0, quit_string         # Load address of quit string
        la $a1, input_string        # Load address of user input
        jal COMPARE_STRING          # Compare 2 strings
        beq $v0, 1, TYPE_QUIT       # If 2 strings are the same, jump to TYPE_QUIT

        # Print "Result: "
        jal CYAN
        la $a0, ascii_out_prompt    # Load address of output prompt
        jal PRINT_STRING            # Print output prompt
        jal RESET

        # # Write input to file (need 3 arguments: $a0=message, $a1=filename, $a2=mode)
        # la $a0, input_string        # Load address of input buffer
        # la $a1, filename            # Load address of the filename
        # li $a2, 9                   # Mode 9: write only with create and append
        # jal WRITE_TO_FILE           # Write the input string to the file

        # Print input_string
        la $a0, input_string        # Print user input
        jal PRINT_STRING
        
        # Use to check if a character is an operator/operand
        li $t0, 0                   # Index of the current character
        li $t2, 0                   # counter of the number of operators
        li $t3, 0                   # counter of the number of not operators

        loop:
            lb $t1, input_string($t0)   # Load character from input_string
            addi $t0, $t0, 1            # Move to next character
            beq $t1, $zero, out_loop    # If character is null, end loop
            beq $t1, 10, out_loop     # If character is new line, end loop
            move $a0, $t1               # Move character to $a0
            jal IS_OPERATOR             # Check if character is an operator
            beq $v0, 1, __if_operator     # If character is an operator, jump to is_operator
            addi $t3, $t3, 1
            j loop
        j loop

        __if_operator:
            addi $t2, $t2, 1
            j loop

        out_loop:
            move $a0, $t2
            jal PRINT_INT

            li $a0, '-'
            jal PRINT_CHAR

            move $a0, $t3
            jal PRINT_INT

            jal new_line

    j main_loop   
j END_PROGRAM

### READ INPUT
READ_STRING_FROM_USER: # nguyenpanda
    # READ_STRING_FROM_USER(buff_address = $a0, max_lenght = $a1) => void
    #   - Read a string from user
    # Parameters:
    #   a0: Where string is located in memory (.space)
    #   a1: Max length of string
    ##### Main function  #####
        li $v0, 8
        syscall
    jr $ra  # Return READ_STRING_FROM_USER

READ_INT: # nguyenpanda
    # READ_INT() => $v0: int
    #   - Read an integer from user
    ##### Main function  #####
    li $v0, 5
    syscall

### STACK
RESET_STACK:
    # RESET_STACK(stack: int[] = $a0, index = $a1) => void
    #   - Reset a stack
    # Parameters:
    #   a0: Address of the stack
    #   a1: Index of the stack
    ##### Init function  #####
        addi $sp, $sp, -12  # RESET_STACK: use 3 registers $t0, $t1, $ra
        sw $ra, 0($sp)
        sw $t0, 4($sp)
        sw $t1, 8($sp)
        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        move $t1, $a1       # SUPPORT PASS BY REFERENCE
        li $t0, 0
    ##### Main function  #####
        __loop_RESET_STACK:
            sw $t0, 0($t0)  # Reset stack
            addi $t0, $t0, 4
            bne $t0, $t1, __loop_RESET_STACK
        j __loop_RESET_STACK
        __end_loop_RESET_STACK:
    jr $ra  # Return RESET_STACK

### INFIX TO POSTFIX
IS_OPERAND: # nguyenpanda
    # IS_OPERAND(char = $a0) => $v0: boolean
    #   - Check if a character is an operand
    # Parameters:
    #   a0: Character
    # Return:
    #   v0: 1 if character is an operand, 0 if not
    ##### Init function  #####
        addi $sp, $sp, -16  # IS_OPERAND: use 4 registers $ra, $a0, $t0, $t1
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $t0, 8($sp)      # t0 = character
        sw $t1, 12($sp)     # t1 = operator
        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        li $v0, 0           # Assume that character is not an operand

    ##### Main function  #####
        beq $t0, 46, __IS_OPERAND_RETURN_TRUE # If character is '.', return true
        blt $t0, 48, __IS_OPERAND_RETURN_FALSE # If character < '0', return false
        bgt $t0, 57, __IS_OPERAND_RETURN_FALSE # If character > '9', return false
        __IS_OPERAND_RETURN_TRUE:
            addi $v0, $zero, 1  # Return true

    ##### Reset function #####
    __IS_OPERAND_RETURN_FALSE:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $t0, 8($sp)
        lw $t1, 12($sp)
        addi $sp, $sp, 16
    jr $ra  # Return IS_OPERAND

IS_OPERATOR: # nguyenpanda
    # IS_OPERATOR(operator: char = $a0) => $v0: boolean
    #   - Check if a character is an operator ('+', '-', '*', '/', '^', '!') or not
    # Parameters:
    #   a0: Character
    # Return:
    #   v0: 1 if character is an operator, 0 if not
    ##### Init function  #####
        addi $sp, $sp, -16  # IS_OPERATOR: use 4 registers $ra, $a0, $t0, $t1
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $t0, 8($sp)      # t0 = character
        sw $t1, 12($sp)     # t1 = operator
        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        li $v0, 0           # Assume that character is not an operator
    
    ##### Main function  #####
        beq $t0, 43, __IS_OPERATOR_RETURN_TRUE # If character is '+', return true
        beq $t0, 45, __IS_OPERATOR_RETURN_TRUE # If character is '-', return true
        beq $t0, 42, __IS_OPERATOR_RETURN_TRUE # If character is '*', return true
        beq $t0, 47, __IS_OPERATOR_RETURN_TRUE # If character is '/', return true
        beq $t0, 94, __IS_OPERATOR_RETURN_TRUE # If character is '^', return true
        beq $t0, 33, __IS_OPERATOR_RETURN_TRUE # If character is '!', return true
    j __IS_OPERATOR_RESET
    __IS_OPERATOR_RETURN_TRUE:
        li $v0, 1   # Return true

    ##### Reset function #####
    __IS_OPERATOR_RESET:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $t0, 8($sp)
        lw $t1, 12($sp)
        add $sp, $sp, 16
    jr $ra  # Return IS_OPERATOR

OPERATOR_PRECEDENCE: # nguyenpanda
    # OPERATOR_PRECEDENCE(operator: char = $a0) => $v0: int
    #   - Get the precedence of an operator
    # Parameters:
    #   a0: Operator
    # Return:
    #   v0: Precedence of the operator, [invalid] = -1, ['+', '-'] = 1, ['*', '/'] = 2, ['^'] = 3, ['!'] = 4
    ##### Init function  #####
        addi $sp, $sp, -12  # OPERATOR_PRECEDENCE: use 4 registers $ra, $a0, $t0, $t1
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $t0, 8($sp)          # t0 = operator
        move $t0, $a0           # SUPPORT PASS BY REFERENCE
        li $v0, -1              # Assume that operator is not valid

    ##### Main function  #####
        beq $t0, 43, __OPERATOR_PRECEDENCE_RETURN_1 # If operator is '+', return 1
        beq $t0, 45, __OPERATOR_PRECEDENCE_RETURN_1 # If operator is '-', return 1
        
        beq $t0, 42, __OPERATOR_PRECEDENCE_RETURN_2 # If operator is '*', return 2
        beq $t0, 47, __OPERATOR_PRECEDENCE_RETURN_2 # If operator is '/', return 2

        beq $t0, 94, __OPERATOR_PRECEDENCE_RETURN_3 # If operator is '^', return 3
        beq $t0, 33, __OPERATOR_PRECEDENCE_RETURN_4 # If operator is '!', return 4

        j __OPERATOR_PRECEDENCE_RESET
    ##### Return functions #####
        __OPERATOR_PRECEDENCE_RETURN_1:
            li $v0, 1   # Return 1
            j __OPERATOR_PRECEDENCE_RESET
        
        __OPERATOR_PRECEDENCE_RETURN_2:
            li $v0, 2   # Return 2
            j __OPERATOR_PRECEDENCE_RESET

        __OPERATOR_PRECEDENCE_RETURN_3:
            li $v0, 3   # Return 3
            j __OPERATOR_PRECEDENCE_RESET

        __OPERATOR_PRECEDENCE_RETURN_4:
            li $v0, 4   # Return 4
            j __OPERATOR_PRECEDENCE_RESET

    ##### Reset function #####
        __OPERATOR_PRECEDENCE_RESET:
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $t0, 8($sp)
            addi $sp, $sp, 12
    jr $ra  # Return OPERATOR_PRECEDENCE

INFIX_TO_POSTFIX: # nguyenpanda
    # INFIX_TO_POSTFIX(infix: str = $a0) => void
    #   - Convert an infix expression to a postfix expression
    # Parameters:
    #   a0: Infix expression
    ##### Init function  #####
        addi $sp, $sp, -44  # INFIX_TO_POSTFIX: use 4 registers $ra, $a0, $t0, $t1
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $t0, 8($sp)      # t0 = input_string
        sw $t1, 12($sp)     # t1 = operator
        sw $t2, 16($sp)     # t2 = operand  
        sw $t3, 20($sp)     # t3 = index of the current character
        sw $t4, 24($sp)     # t4 = index of the current operator
        sw $t5, 28($sp)     # t5 = index of the current operand
        sw $t6, 32($sp)     # t6 = index of the postfix expression
        sw $t7, 36($sp)     # t7 = index of the current operator stack
        sw $t8, 40($sp)     # t8 = index of the current operand stack
        sw $t9, 44($sp)     # t9 = index of the current postfix expression

        move $t0, $a0       # SUPPORT PASS BY REFERENCE
    
        li $t1, 0           # Init operator stack
        li $t2, 0           # Init operand stack
        li $t3, 0           # Init index of the current character
        li $t4, 0           # Init index of the current operator
        li $t5, 0           # Init index of the current operand
        li $t6, 0           # Init index of the postfix expression
        li $t7, 0           # Init index of the current operator stack
        li $t8, 0           # Init index of the current operand stack
        li $t9, 0           # Init index of the current postfix expression
    
    ##### Main function  #####
        
    ##### Reset function #####
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $t0, 8($sp)
        lw $t1, 12($sp)
        addi $sp, $sp, 16
    jr $ra  # Return INFIX_TO_POSTFIX

### PRINT
PRINT_STRING: # nguyenpanda
    # PRINT_STRING(string = $a0) => void
    #   - Print a string to screen
    # Parameters:
    #   a0: Display string
    ##### Main function  #####
    li $v0, 4   # PRINT_STRING
    syscall
    jr $ra  # Return PRINT_STRING
    
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

### MATH
FACTORIAL: # nguyenpanda
    # FACTORIAL(unsighted int = $a0) => $v0: unsighted int
    #   - Calculate the factorial of a number
    # Parameters:
    #   $a0: Number
    # Return:
    #   $v0: Factorial of the number
    ##### Init function  #####
        addi $sp, $sp, -8    # FACTORIAL: use 2 registers $t0, $ra
        sw $t0, 0($sp)
        sw $ra, 4($sp)
        move $t0, $a0
        jal __FACT
        j __END_FACTORIAL

    ##### Main function  #####
    __FACT:
        ##### Init function  #####
            bgt $t0, 15, __exception_FACTORIAL # n > 15: jump to exception
            addi $sp, $sp, -8       # FACTORIAL: use 2 registers $t0, $ra
            sw $ra, 4($sp)
            sw $t0, 0($sp)          

        ##### Main function  #####
            bgt $t0, 1, __recrusive_FACT    # n > 1: jump to recursive

            addi $v0, $zero, 1
            j __end__FACT
            
            __recrusive_FACT: 
                addi $t0, $t0, -1           # n >= 1: argument gets (n – 1)
                jal __FACT

        ##### Reset function #####
        __end__FACT:
            lw $t0, 0($sp)
            lw $ra, 4($sp)
            addi $sp, $sp, 8

            mul $v0, $t0, $v0

            jr $ra      # Return __FACT

    ##### Reset function #####
    __END_FACTORIAL:
        lw $t0, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8
        jr $ra          # Return FACTORIAL
    
    __exception_FACTORIAL:
        jal RED         # __exception_FACTORIAL
        # la $a0, factorial_out_of_bound
        jal PRINT_STRING
        move $a0, $t0
        jal PRINT_INT
        jal RESET
        jal new_line
        j END_PROGRAM   # Return __exception_FACTORIAL

### STRING MANIPULATOR
STRING_LENGHT: # nguyenpanda
    # STRING_LENGHT(string = $a0) => $v0: unsighted int
    #   - Get the lenght of a string
    #   - Cut off the new line character and null character
    # Parameters:
    #   $a0: Address of the string (argument PASS BY REFERENCE or PASS BY VALUE)
    # Return:
    #   $v0: Lenght of the string
    ##### Init function  #####
        addi $sp, $sp, -12      # STRING_LENGHT: use 3 registers $t0, $t1, $ra
        sw $ra, 8($sp)
        sw $t1, 4($sp)
        sw $t0, 0($sp)
        li $v0, 0
        move $t1, $a0           # SUPPORT PASS BY REFERENCE
    ##### Main function  #####
        __loop_STRING_LENGHT:
            lb $t0, 0($t1)      # Load character from memory
            beq $t0, $zero, __end_loop_STRING_LENGHT    # If character is null, end loop
            beq $t0, 10, __end_loop_STRING_LENGHT       # If character is new line, end loop
            addi $t1, $t1, 1    # Move to next character
            addi $v0, $v0, 1    # Increment counter
        j __loop_STRING_LENGHT

    ##### Reset function #####
        __end_loop_STRING_LENGHT:
            lw $ra, 8($sp)
            lw $t1, 4($sp)
            lw $t0, 0($sp)
            addi $sp, $sp, 12
    jr $ra  # Return STRING_LENGHT

COMPARE_STRING: # nguyenpanda
    # COMPARE_STRING(str_0 = $a0, str_1 = $a1) => $v0: boolean
    #   - Compare 2 strings
    # Parameters:
    #   $a0: Address of the first string, argument PASS BY REFERENCE or PASS BY VALUE
    #   $a1: Address of the first string, argument PASS BY REFERENCE or PASS BY VALUE
    # Return:
    #   $v0: 1 if 2 strings are the same, 0 if not
    ##### Init function  #####
        # Note: t0 = str_0, t1 = lenght(str_0), 
        # Note: t2 = str_1, t3 = lenght(str_1)
        addi $sp, $sp, -20      # COMPARE_STRING: use 4 registers $ra, $t0, $t1, $t2, $t3
        sw $ra, 16($sp)
        sw $t3, 12($sp)
        sw $t2, 8($sp)
        sw $t1, 4($sp)
        sw $t0, 0($sp)

        move $t0, $a0           # SUPPORT PASS BY REFERENCE
        move $t2, $a1           # SUPPORT PASS BY REFERENCE
        
        move $a0, $t0
        jal STRING_LENGHT
        addu $t1, $v0, $zero    # t1 = lenght(str_0)

        move $a0, $t2
        jal STRING_LENGHT
        addu $t3, $v0, $zero    # t3 = lenght(str_1)

        li $v0, 0               # Assume that 2 strings are not the same
        
        # If 2 strings have different lenght, return false
        bne $t1, $t3, __RETURN_NOT_SAME_COMPARE_STRING

    ##### Main function  #####
        __loop_COMPARE_STRING:
            lb $t4, 0($t0)      # t4 = str_0[t0] Load character from memory
            lb $t5, 0($t2)      # t5 = str_1[t2] Load character from memory

            bne $t4, $t5, __RETURN_NOT_SAME_COMPARE_STRING

            addiu $t0, $t0, 1   # str_0[t0++] Move to next character
            addiu $t1, $t1, -1  # lenght(str_0)--
            addiu $t2, $t2, 1   # str_1[t2++] Move to next character
            addiu $t3, $t3, -1  # lenght(str_1)--
        bnez $t1, __loop_COMPARE_STRING
        li $v0, 1               # Finish compare, 2 strings are the same
    
    ##### Reset function #####
        __RETURN_NOT_SAME_COMPARE_STRING:
            lw $ra, 16($sp)
            lw $t3, 12($sp)
            lw $t2, 8($sp)
            lw $t1, 4($sp)
            lw $t0, 0($sp)
            addi $sp, $sp, 20
    jr $ra  # Return COMPARE_STRING

### UTILS
END_PROGRAM: # nguyenpanda
    jal YELLOW                  # END_PROGRAM
    la $a0, ascii_exit_prompt
    jal PRINT_STRING
    jal RESET
    li $v0, 10                  # syscall 10: exit
    syscall

TYPE_QUIT: # nguyenpanda
    jal RED        # TYPE_QUIT
    la $a0, ascii_quit_prompt
    li $v0, 4
    syscall
    jal RESET

    j END_PROGRAM  # TYPE_QUIT

WRITE_TO_FILE_: # nguyenpanda
    # WRITE_TO_FILE_(message = $a0, length = $a1, filename = $a2, mode = $a3) => void
    #   - Write a message to a file, REMEMBER to check the length of the message
    # Parameters:
    #   $a0: Address of the message string
    #   $a1: Length of the message string (including null character)
    #   $a2: Address of the filename string
    #   $a3: Mode of the file (1 = write only with create / 9 = write only with creat and append)
    ##### Init function  #####
        addi $sp, $sp, -16 # WRITE_TO_FILE_: use 4 registers $t0, $t1, $t2, $t3
        sw $t3, 12($sp)
        sw $t2, 8($sp)
        sw $t1, 4($sp)
        sw $t0, 0($sp)
        move $t0, $a0   # message
        move $t1, $a1   # max length
        move $t2, $a2   # filename
        move $t3, $a3   # mode

    ##### Main function  #####
        # Open the file
        li $v0, 13      # syscall 13: open
        move $a0, $a2   # filename
        move $a1, $a3   # mode
        li $a2, 0       # Default mode
        syscall         
        move $s0, $v0   # Save file descriptor to $s0

        # Write message to the file
        li $v0, 15      # syscall 15: write
        move $a0, $s0   # File descriptor
        move $a1, $t0   # Address of message
        move $a2, $t1   # Length of message (including null character)
        syscall

        # Close the file
        li $v0, 16      # syscall 16: close
        move $a0, $s0   # File descriptor
        syscall

    ##### Reset function #####
        lw $t3, 12($sp)
        lw $t2, 8($sp)
        lw $t1, 4($sp)
        lw $t0, 0($sp)
        addi $sp, $sp, 16
    jr $ra  # Return WRITE_TO_FILE_

WRITE_TO_FILE: # nguyenpanda
    # WRITE_TO_FILE(message = $a0, filename = $a1, mode = $a2) => void
    #   - Write a message to a file, without checking the length of the message
    # Parameters:
    #   $a0: Address of the message string
    #   $a1: Address of the filename string
    #   $a2: Mode of the file (1 = write only with create / 9 = write only with creat and append)
    ##### Init function  #####
        addi $sp, $sp, -20  # WRITE_TO_FILE: use 5 registers $t0, $t1, $t2, $t3, $ra
        sw $ra, 16($sp)
        sw $t3, 12($sp)
        sw $t2, 8($sp)
        sw $t1, 4($sp)
        sw $t0, 0($sp)
        move $t0, $a0       # message
        jal STRING_LENGHT
        addi $t1, $v0, 1    # length of the message (including null character)
        move $t2, $a1       # filename
        move $t3, $a2       # mode
        
    ##### Main function  #####
        # Open the file
        li $v0, 13      # syscall 13: open
        move $a0, $a1   # filename
        move $a1, $a2   # mode
        li $a2, 0       # Default mode
        syscall         
        move $s0, $v0   # Save file descriptor to $s0

        # Write message to the file
        li $v0, 15      # syscall 15: write
        move $a0, $s0   # File descriptor
        move $a1, $t0   # Address of message
        move $a2, $t1   # Length of message (including null character)
        syscall

        # Close the file
        li $v0, 16      # syscall 16: close
        move $a0, $s0   # File descriptor
        syscall

    ##### Reset function #####
        lw $ra, 16($sp)
        lw $t3, 12($sp)
        lw $t2, 8($sp)
        lw $t1, 4($sp)
        lw $t0, 0($sp)
        addi $sp, $sp, 20
    jr $ra  # Return WRITE_TO_FILE

new_line: # RestingKiwi
    li $v0, 11    # new_line
    la $a0, '\n'
    syscall
    jr $ra  # Return new_line

### COLOR
    RED: # nguyenpanda
        la $a0, color_r # RED
        li $v0, 4
        syscall
        jr $ra  # Return RED

    GREEN: # nguyenpanda
        la $a0, color_g # GREEN
        li $v0, 4
        syscall
        jr $ra  # Return GREEN

    YELLOW: # nguyenpanda
        la $a0, color_y # YELLOW
        li $v0, 4
        syscall
        jr $ra  # Return YELLOW

    BLUE: # nguyenpanda
        la $a0, color_b # BLUE
        li $v0, 4
        syscall
        jr $ra  # Return BLUE

    MAGENTA: # nguyenpanda
        la $a0, color_m # MAGENTA
        li $v0, 4
        syscall
        jr $ra  # Return MAGENTA

    CYAN: # nguyenpanda
        la $a0, color_c # CYAN
        li $v0, 4
        syscall
        jr $ra  # Return CYAN

    WHITE: # nguyenpanda
        la $a0, color_w # WHITE
        li $v0, 4
        syscall
        jr $ra  # Return WHITE

    RESET: # nguyenpanda
        la $a0, reset   # RESET
        li $v0, 4
        syscall
        jr $ra  # Return RESET

### TEST
    