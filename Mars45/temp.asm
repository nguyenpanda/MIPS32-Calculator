# spim .asm
.data
    test:  .asciiz "String length: "
    quit_string:        .asciiz "quit"
    same_string:        .asciiz "same"
    not_same_string:    .asciiz "not same"
    ascii_out_prompt:   .asciiz "Result: "
    ascii_in_prompt:    .asciiz "Please insert your expression: "
    ascii_quit_prompt:  .asciiz "You have typed 'quit'. Exiting program...!"
    
    arr_byte_valid:     .byte '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '*', '/', '.', 'M', '^', '!', '(', ')'
    arr_byte_operator:  .byte '+', '-', '*', '/', '^', 'M', '!', '(', ')'
    arr_byte_number:    .byte '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'

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
        input_string:       .space 101 # MAX LENGTH OF INPUT STRING IS 100

.text
    .globl  main
    
main:
    main_loop: # Loop and ask user to input
        # Print "Please insert your expression: "
        la $a0, ascii_in_prompt     # Load address of input prompt
        jal PRINT_STRING            # Print input prompt

        la $a0, input_string        # Load address of input buffer
        li $a1, 100                	# Set max length of input buffer (1 space for null character)
        jal READ_STRING_FROM_USER   # Read input from user
        
        la $a0, test                # Load address of input prompt
        jal PRINT_STRING            # Print input prompt
        la $a0, input_string        # Load address of input buffer
        jal STRING_LENGHT           # Get the lenght of the string
        move $a0, $v0
        jal PRINT_INT
        jal new_line

        la $a0, ascii_out_prompt
        jal PRINT_STRING            # Print input prompt

        la $a0, input_string        # Load address of input buffer
        la $a1, quit_string      # Load address of valid characters
        jal COMPARE_STRING          # Compare 2 strings
        beq $v0, 1, SAME     # If user type 'quit', exit program
        jal NOT_SAME

NOT_SAME:
    la $a0, not_same_string
    jal PRINT_STRING
    jal END_PROGRAM

SAME:
    la $a0, same_string
    jal PRINT_STRING
    jal END_PROGRAM

END_PROGRAM: # nguyenpanda
    li $v0, 10          # syscall 10: exit
    syscall

READ_STRING_FROM_USER: # nguyenpanda
    # READ_STRING_FROM_USER(buff_address = $a0, max_lenght = $a1) => void
    #   - Read a string from user
    # Parameters:
    #   a0: Where string is located
    #   a1: Max length of string
    ##### Main function  #####
        li $v0, 8
        syscall
    jr $ra  # Return READ_STRING_FROM_USER

PRINT_STRING: # nguyenpanda
    # PRINT_STRING(string = $a0) => void
    #   - Print a string to screen
    # Parameters:
    #   a0: Display string
    li $v0, 4   # PRINT_STRING
    syscall
    jr $ra  # Return PRINT_STRING

PRINT_INT: # nguyenpanda
    # PRINT_CHAR(int = $a0) => void
    #   - Print a int to screen
    # Parameters:
    #   a0: Display int
    ##### Main function  #####
    li $v0, 1  # PRINT_INT
    syscall
    jr $ra  # Return PRINT_INT

STRING_LENGHT: # nguyenpanda
    # STRING_LENGHT(string = $a0) => $v0: unsighted int
    #   - Get the lenght of a string
    # Parameters:
    #   $a0: Address of the string
    # Return:
    #   $v0: Lenght of the string
    ##### Init function  #####
        addi $sp, $sp, -8 # STRING_LENGHT: use 2 registers $t0, $t1
        sw $t1, 4($sp)
        sw $t0, 0($sp)
        li $v0, 0
        move $t1, $a0           # SUPPORT PASS BY REFERENCE
    ##### Main function  #####
        __loop_STRING_LENGHT:
            lb $t0, 0($t1)      # Load character from memory
            beq $t0, $zero, __end_loop_STRING_LENGHT    # If character is '\0', end loop
            beq $t0, 10, __end_loop_STRING_LENGHT       # If character is '\n', end loop
            addi $t1, $t1, 1    # Move to next character
            addi $v0, $v0, 1    # Increment counter
        j __loop_STRING_LENGHT

    ##### Reset function #####
        __end_loop_STRING_LENGHT:
            lw $t1, 4($sp)
            lw $t0, 0($sp)
            addi $sp, $sp, 8
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

    ##### Main function  #####
        __loop_COMPARE_STRING:
            lb $t4, 0($t0)      # t4 = str_0[t0] Load character from memory
            lb $t5, 0($t2)      # t5 = str_1[t2] Load character from memory

            bne $t4, $t5, __RETURN_NOT_SAME_COMPARE_STRING

            addiu $t0, $t0, 1   # str_0[t0++] Move to next character
            subiu $t1, $t1, 1   # lenght(str_0)--
            addiu $t2, $t2, 1   # str_1[t2++] Move to next character
            subiu $t3, $t3, 1   # lenght(str_1)--
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

new_line: # RestingKiwi
    li $v0, 11    # new_line
    la $a0, '\n'
    syscall
    jr $ra  # Return new_line
