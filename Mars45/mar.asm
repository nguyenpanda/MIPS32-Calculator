.data
    ## Variables
        M:                  .space 8   # M
        temp_operand:       .space 32   # Temporary operand
        # 1 (top_pointer) + 1 (length) + 50 (memory space) words // TODO: Change 50
        stack:              .space 208 # Stack
        
        input_string:       .space 104 # MAX LENGTH OF INPUT STRING IS 100
        postfix_string:     .space 304 # MAX LENGTH OF POSTFIX STRING IS 300
        number_buffer:      .space 204 # Buffer for number
        temp_space:         .space 204 # Temporary space for stack

    ### Constant
        double_0:       .double 0.0
        double_1:       .double 1.0
        double_10:      .double 10.0
        double_10p8:    .double 100000000.0
        double_test:    .double 123.0012345

    ### file    
        filename:   .asciiz "calc_log.txt"

    ## String
        ascii_check_point:  .asciiz "Check point: "
        ascii_new_char:     .asciiz "\033[1;92m----------------------------\033[0m\n"
        ascii_ddd:          .asciiz "\t---\n"
        ascii_num_buffer:   .asciiz "\tNumber buffer: "
        ascii_for_char:     .asciiz "Getting info for: "
        quit_string:        .asciiz "quit"
        ascii_infix_prompt: .asciiz "Infix: "
        ascii_postfix:      .asciiz "Postfix: "
        ascii_result:       .asciiz "Result: "
        ascii_in_prompt:    .asciiz "Please insert your expression: "
        ascii_quit_prompt:  .asciiz "You have typed 'quit'.\n"
        ascii_exit_prompt:  .asciiz "Exiting program...!\n"
        ascii_stack_top:	.asciiz "<-TOP (Length="
        ascii_write_result: .asciiz ","
        ascii_lot_of_new_line:      .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        ascii_intro:        .asciiz "\033[1;94m#########################################################################################################\033[0m\n\033[1;94m#\033[0m   \033[1;93mAuthor: \033[1;97mHa Tuong Nguyen a.k.a nguyenpanda                                                           \033[1;94m#\033[0m\n\033[1;94m#\033[0m   \033[1;93mID:\033[1;97m     2250013                                                                                     \033[1;94m#\033[0m\n\033[1;94m#\033[0m   \033[1;93mDate:\033[1;97m   2024-05-09                                                                                  \033[1;94m#\033[0m\n\033[1;94m#\033[0m   \033[1;94mHo Chi Minh University of Technology\033[0m                                                                \033[1;94m#\033[0m\n\033[1;94m#\033[0m                                                                                                       \033[1;94m#\033[0m\n\033[1;94m#\033[0m    \033[1;97mWELCOME TO MY CALCULATOR WRITTEN IN MIPS32 ASSEMBLY LANGUAGE                                       \033[1;94m#\033[0m\n\033[1;94m#\033[0m      \033[1;97mA simple calculator that can evaluate infix expression by converting it to postfix expression\033[0m    \033[1;94m#\033[0m\n\033[1;94m#\033[0m                                                                                                       \033[1;94m#\033[0m\n\033[1;94m#\033[0m   \033[1;96mExpression can contain:\033[0m                                                                             \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - \033[1;94mNumber:\033[0m 0-9                                                                                     \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - \033[1;94mOperator:\033[0m +, -, *, /, ^, !                                                                      \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - \033[1;94mParentheses:\033[0m (, )                                                                               \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - \033[1;94mSpace:\033[0m ' ' (this is optional becase the calculator will remove all spaces before evaluating)    \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - \033[1;94mM:\033[0m store the result of the last expression                                                      \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - `\033[1;91mquit\033[0m`: quit the program                                                                        \033[1;94m#\033[0m\n\033[1;94m#\033[0m                                                                                                       \033[1;94m#\033[0m\n\033[1;94m#\033[0m   \033[1;96mExample:\033[0m                                                                                            \033[1;94m#\033[0m\n\033[1;94m#\033[0m     \033[1;93m>>>\033[0m (((-10.2-3)*8-2/7)*2-M!*2^7)*(-1)                                                             \033[1;94m#\033[0m\n\033[1;94m#\033[0m     \033[1;93m>>>\033[0m 1 + 2 * 3 - 4 / 5                                                                             \033[1;94m#\033[0m\n\033[1;94m#\033[0m     \033[1;93m>>>\033[0m 1 + 2 * 3 - 4 / 5 ^ 6                                                                         \033[1;94m#\033[0m\n\033[1;94m#\033[0m                                                                                                       \033[1;94m#\033[0m\n\033[1;94m#\033[0m   \033[1;96mNote:\033[0m                                                                                               \033[1;94m#\033[0m\n\033[1;94m#\033[0m     - This program contains a lot of comments to help you understand the code                         \033[1;94m#\033[0m\n\033[1;94m#########################################################################################################\033[0m\n"
        ascii_menu:         .asciiz "\033[1;91m#########################################################################################################\033[0m\n\033[1;91m#\033[0m                                                                                                       \033[1;91m#\033[0m\n\033[1;91m#\033[0m   \033[1;97mRemember expression only only contain\033[0m: 0-9, +, -, *, /, ^, !, (, ), space, `M`, `quit`              \033[1;91m#\033[0m\n\033[1;91m#\033[0m   Type `\033[1;91mquit\033[0m` to \033[1;97mEND\033[0m the program                                                                      \033[1;91m#\033[0m\n\033[1;91m#\033[0m   \033[1;97mResult will be display on \033[1;91mterminal\033[0m \033[1;97mand log out\033[0m `\033[1;91mcalc_log.txt\033[0m`                                       \033[1;91m#\033[0m\n\033[1;91m#\033[0m                                                                                                       \033[1;91m#\033[0m\n\033[1;91m#########################################################################################################\033[0m\n"
        ## Exception
            exc_invalid_exponentiation:     .asciiz "\033[1;91mError: Invalid exponentiation 0^0\033[0m\n"
            exc_divide_by_zero:             .asciiz "Error: Divide by zero\n"
            exc_invalid_character:          .asciiz "Error: Invalid character at position = "
            exc_invalid_postfix_expression: .asciiz "\033[1;91mError: Invalid postfix expression\n\033[0m"
            exc_inval_length_expression:    .asciiz "Error: Expression length must >= 1 or <= 100, got length = "
            exc_factorial_out_of_bound:     .asciiz "Error: Factorial's argument must less than 16, got n="
            exc_write_to_file_invalid_mode: .asciiz "WRITE_TO_FILE only accept 'w' ($a2=1) or 'a' ($a2=9) mode, got = "
            exc_stack_overflow:             .asciiz "Stack overflow!\n"
            exc_stack_underflow:            .asciiz "Stack underflow!\n"
            exc_double_to_string:           .asciiz "\033[1;91mError: Double to string conversion failed\n\033[0m"
        
        ## Color
            color_r: .asciiz "\033[1;91m" 	# Red color escape sequence
            color_g: .asciiz "\033[1;92m" 	# Green color escape sequence
            color_y: .asciiz "\033[1;93m" 	# Yellow color escape sequence
            color_b: .asciiz "\033[1;94m" 	# Blue color escape sequence
            color_m: .asciiz "\033[1;95m" 	# Magenta color escape sequence
            color_c: .asciiz "\033[1;96m" 	# Cyan color escape sequence
            reset:   .asciiz "\033[0m" 	    # Reset color escape sequence
            
.text
    .globl  main

main:
    la $a0, ascii_intro
    jal PRINT_STRING

    jal INIT_MAIN

    main_loop_TEST_MAIN: # Loop and ask user to input
        ##### Init main  #####
            # Print "Menu"
                la $a0, ascii_menu
                jal PRINT_STRING
                
            # Print "Please insert your expression: "
                jal BLUE
                la $a0, ascii_in_prompt     # Load address of input prompt
                jal PRINT_STRING            # Print input prompt
                jal RESET

            # Read input from user
                la $a0, input_string        # Load address of input buffer
                li $a1, 102                 # Set max length of input buffer (1 space for null character)
                li $v0, 8                   # READ_STRING_FROM_USER
                syscall

            # 'quit' check
                la $a0, quit_string         # Load address of quit string
                la $a1, input_string        # Load address of user input
                jal COMPARE_STRING          # Compare 2 strings
                beq $v0, 1, TYPE_QUIT       # If 2 strings are the same, jump to TYPE_QUIT

        #####    MAIN    #####
            la $a0, input_string        # Evaluate the infix expression
            jal INFIX_TO_POSTFIX
            
            # Evaluate the postfix expression
            la $a0, postfix_string
            jal EVALUATE_POSTFIX # BREAKPOINT

            # Print "Result: "
                jal CYAN
                la $a0, ascii_result
                jal PRINT_STRING
                jal RESET
                
                # Print the result
                jal GREEN
                mov.d $f12, $f0
                jal PRINT_DOUBLE
                jal RESET
                jal new_line

                la $a0, ascii_lot_of_new_line
                jal PRINT_STRING

        ##### Write file #####
            # Write input to file (need 3 arguments: $a0=message, $a1=filename, $a2=mode)
            la $a0, postfix_string      # string buffer
            li $a1, 0                   # Mode 0: replace string
            mov.d $f12, $f0
            jal DOUBLE_TO_STRING

            la $a0, postfix_string
            jal STRING_LENGHT
            add $a0, $v0, $a0 # BREAKPOINT
            li $v0, '\n'
            sb $v0, 0($a0)

            la $a0, postfix_string
            la $a1, filename            # Load address of the filename
            li $a2, 9                   # Mode 9: write only with create and append
            jal WRITE_TO_FILE           # Write the postfix string to the file

        ##### Reset main  #####
            la $a0, stack
            jal STACK_RESET
            
            la $a0, postfix_string
            jal RESET_STRING

            la $a0, number_buffer
            jal RESET_STRING

            la $a0, temp_space
            jal RESET_STRING
    j main_loop_TEST_MAIN

j END_PROGRAM

INIT_MAIN:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    la $a0, stack
    jal STACK_INIT

    l.d $f24, double_test
    l.d $f26, double_0
    l.d $f28, double_1
    l.d $f30, double_10
    s.d $f26, M

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

### STACK "struct"
STACK: # nguyenpanda
    # MUST CALL STACK_INIT($a0 = stack) BEFORE USING STACK
    # STACK ACHITECTURE
    # |   address of element_n   |      int       |    <T>    |    <T>    | ... |     <T> (top)   | null | null | ... | null (MAX_CAPACITY) |
    # | top_pointer -> element_n | length = n + 1 | element_0 | element_1 | ... | element_n (top) | null | null | ... | null (MAX_CAPACITY) |
    #                |                                                               ^
    #                |_______________________________________________________________|
    
    STACK_INIT: # nguyenpanda (leaf function)(stack_pointer = $a0) => void
        # STACK_INIT(stack_pointer $a0) => void
        #   - Initialize the stack by setting top_pointer to the first element and length to 0
        #   - Noted that data in the stack won't be reset when calling this function
        # Parameters:
        #   a0: stack_pointer
        ##### Init function  #####
            addi $sp, $sp, -4 # STACK_INIT: use 1 registers $a0
            sw $a0, 0($sp)
            move $t0, $a0
            
        ##### Main function  #####
            # Initialize top_pointer
            addiu $t0, $a0, 8
            sw $t0, 0($a0)

            # Initialize length
            li $t0, 0
            sw $t0, 4($a0)
        
        ##### Reset function  #####
            lw $a0, 0($sp)
            addi $sp, $sp, 4
        jr $ra  # Return STACK_INIT

    __STACK_POINTER: # nguyenpanda (leaf function)(stack_pointer = $a0) => $v0 (address)
        # STACK_LENGTH(stack_pointer $a0) => $v0 (address)
        #  - Get the address of the top_pointer
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: address of the top_pointer 
        move $v0, $a0 # __STACK_POINTER
        jr $ra  # Return __STACK_POINTER

    __STACK_INSERT_ADDRESS: # nguyenpanda (leaf function)(stack_pointer = $a0) => $v0 (address)
        # __STACK_INSERT_ADDRESS(stack_pointer $a0) => $v0 (address)    
        #  - Get the address of the top, which is the next available space
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: address of the top where we can insert new element
        lw $v0, 0($a0) # __STACK_INSERT_ADDRESS
        jr $ra  # Return __STACK_INSERT_ADDRESS

    STACK_LENGTH: # nguyenpanda (leaf function)(stack_pointer = $a0) => $v0 (int)
        # STACK_LENGTH(stack_pointer $a0) => $v0 (int)
        #   - Get the length of the stack
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: length
        lw $v0, 4($a0) # STACK_LENGTH
        jr $ra  # Return STACK_LENGTH

    STACK_PUSH: # nguyenpanda (function)(stack_pointer = $a0, value: <T> = $a1) => void
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

    STACK_TOP: # nguyenpanda (function)(stack_pointer = $a0) => $v0 (value: <T>)
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

    STACK_POP: # nguyenpanda (function)(stack_pointer = $a0) => $v0 (value: <T>)
        # STACK_POP(stack_pointer $a0) => void
        #   - Pop the top element of the stack
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #  v0: value
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

    #### FOR DOUBLE
    STACK_PUSH_DOUBLE: # nguyenpanda
        # STACK_PUSH_DOUBLE(stack_pointet = $a0, double = $f12) => void
        #   - Push a double to stack
        # Parameters:
        #   a0: stack_pointer
        #   f12: double
        ##### Init function  #####
            addi $sp, $sp, -16  # STACK_PUSH_DOUBLE: use 5 registers $ra, $a0, $a1, $t0, $t1
            sw $ra, 0($sp)
            sw $a1, 4($sp)
            sw $t0, 8($sp)  # double
            sw $t1, 12($sp) # double

            mfc1.d $t0, $f12

        ##### Main function  #####
            move $a1, $t0
            jal STACK_PUSH
            move $a1, $t1
            jal STACK_PUSH

        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a1, 4($sp)
            lw $t0, 8($sp)
            lw $t1, 12($sp)
            addi $sp, $sp, 16
        jr $ra  # Return STACK_PUSH_DOUBLE

    STACK_POP_DOUBLE: # nguyenpanda
        # STACK_POP_DOUBLE(stack_pointer = $a0) => $f0: double
        #   - Pop a double from stack
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   f0: double
        ##### Init function  #####
            addi $sp, $sp, -12  # STACK_POP_DOUBLE: use 5 registers $ra, $a0, $a1, $t0, $t1
            sw $ra, 0($sp)
            sw $t0, 4($sp)  # double
            sw $t1, 8($sp)  # double

        ##### Main function  #####
            # MUST POP IN REVERSE ORDER
            jal STACK_POP
            move $t1, $v0
            jal STACK_POP
            move $t0, $v0

            mtc1.d $t0, $f0
        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $t0, 4($sp)
            lw $t1, 8($sp)
            addi $sp, $sp, 12
        jr $ra  # Return STACK_POP_DOUBLE

    STACK_LENGTH_DOUBLE: # nguyenpanda
        # STACK_LENGTH_DOUBLE(stack_pointer = $a0) => $v0: int
        #   - Get the length of the stack
        # Parameters:
        #   a0: stack_pointer
        # Return:
        #   v0: length
        ##### Init function  #####
            addi $sp, $sp, -8  # STACK_LENGTH_DOUBLE: use 2 registers $ra, $a0
            sw $ra, 0($sp)
            sw $t0, 4($sp)
            
            li $t0, 2
        
        ##### Main function  #####
            jal STACK_LENGTH
            div $v0, $t0
            mfhi $t0        # $t0 = $v0 / 2
            bne $t0, $zero, __exception_STACK_LENGTH_DOUBLE # Check for stack underflow (length is not even)
            j __RESET_STACK_LENGTH_DOUBLE

        ##### Exception function #####
            __exception_STACK_LENGTH_DOUBLE:
                eret

        ##### Reset function  #####
        __RESET_STACK_LENGTH_DOUBLE:
            mflo $v0       # $v0 = $v0 / 2
            lw $ra, 0($sp)
            lw $t0, 4($sp)
            addi $sp, $sp, 8
        jr $ra  # Return STACK_LENGTH_DOUBLE

    #### 
    STACK_RESET:
        # STACK_RESET(stack_pointer $a0) => void
        #   - Reset the stack
        # Parameters:
        #   a0: stack_pointer
        ##### Init function  #####
            addi $sp, $sp, -16 # STACK_RESET: use 5 registers $ra, $a0, $t0, $t1, $t2
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            sw $t0, 8($sp)  # first element in the stack
            sw $t1, 12($sp) # end element of the stack

            move $t0, $a0
            addiu $t0, $t0, 8

            jal __STACK_INSERT_ADDRESS
            move $t1, $v0

        ##### Main function  #####
            __loop_STACK_RESET:
                # Check if stack.begin() == stack.top()
                beq $t0, $t1, __end_STACK_RESET

                # Reset stack contents
                sw $zero, 0($t0)

                # Move to the next element in the stack
                addiu $t0, $t0, 4
                j __loop_STACK_RESET
            
            __end_STACK_RESET:
            
            # Reset length
            li $t0, 0
            sw $t0, 4($a0)

            # Reset top_pointer
            addi $t0, $a0, 8
            sw $t0, 0($a0)

        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $t0, 8($sp)
            lw $t1, 12($sp)
            addi $sp, $sp, 16
        jr $ra  # Return STACK_RESET

    PRINT_STACK:
        # PRINT_STACK(stack_pointer $a0, print_function $a1) => void
        #   - Print stack contents
        # Parameters:
        #   a0: stack_pointer
        #   a1: print_function (la $a1, <PRINT_FUNCTION>)
        ##### Init function  #####
            addi $sp, $sp, -24  # PRINT_STACK: use 6 registers $ra, $a0, $a1, $t0, $t1, $t2
            sw $ra, 0($sp)
            sw $a0, 4($sp)
            sw $a1, 8($sp)      # print_function
            sw $t0, 12($sp)     # begin
            sw $t1, 16($sp)     # top
            sw $t2, 20($sp)     # length
            
            jal __STACK_POINTER
            move $t0, $v0
            addiu $t0, $t0, 8

            jal __STACK_INSERT_ADDRESS
            move $t1, $v0

            jal STACK_LENGTH
            move $t2, $v0

        ##### Main function  #####
            # Print vertical bar
            li $a0, '|'
            jal PRINT_CHAR
        
        __loop_PRINT_STACK:
            # Check if stack.begin() == stack.top()
            beq $t0, $t1, __end_PRINT_STACK

            # Print stack contents
            jal MAGENTA
            lw $a0, 0($t0)
            jalr $a1
            jal RESET

            # Print vertical bar
            li $a0, '|'
            jal PRINT_CHAR

            # Move to the next element in the stack
            addiu $t0, $t0, 4
            j __loop_PRINT_STACK
            
            __end_PRINT_STACK:
        
        	# Print TOP
        	la $a0, ascii_stack_top
        	jal PRINT_STRING

            # Print stack length
            jal CYAN
            move $a0, $t2
            jal PRINT_INT
            jal RESET

            # Print )
            li $a0, ')'
            jal PRINT_CHAR

            # Print new line
            jal new_line

        ##### Reset function  #####
            lw $ra, 0($sp)
            lw $a0, 4($sp)
            lw $a1, 8($sp)
            lw $t0, 12($sp)
            lw $t1, 16($sp)
            lw $t2, 20($sp)
            addi $sp, $sp, 24
        jr $ra  # Return PRINT_STACK

    __STACK_OVERFLOW:
        # Handle stack overflow (optional)
        # This could involve printing an error message and exiting the program.
        # For simplicity, we just halt the program here.
        la $a0, exc_stack_overflow
        jal PRINT_STRING
        eret

    __STACK_UNDERFLOW:
        # Handle stack underflow (optional)
        # This could involve printing an error message and exiting the program.
        # For simplicity, we just halt the program here.
        la $a0, exc_stack_underflow
        jal PRINT_STRING
        eret

### PRINT
PRINT_DOUBLE: # nguyenpanda (leaf function)(double = $f12) => void
    # PRINT_DOUBLE(double = $f12) => void
    #   - Print a double to screen
    # Parameters:
    #   f12: Display double
    ##### Main function  #####
        li $v0, 3   # PRINT_DOUBLE
        syscall
    jr $ra  # Return PRINT_DOUBLE

PRINT_STRING: # nguyenpanda (leaf function)(string = $a0) => void
    # PRINT_STRING(string = $a0) => void
    #   - Print a string to screen
    # Parameters:
    #   a0: Display string
    ##### Init function  #####
        addi $sp, $sp, -4  # PRINT_STRING: use 1 registers $a0
        sw $a0, 0($sp)
        
    ##### Main function  #####
        li $v0, 4   # PRINT_STRING
        syscall

    ##### Reset function #####
        lw $a0, 0($sp)
        addi $sp, $sp, 4
    jr $ra  # Return PRINT_STRING
    
PRINT_CHAR: # nguyenpanda (leaf function)(char = $a0) => void
    # PRINT_CHAR(char = $a0) => void
    #   - Print a char to screen
    # Parameters:
    #   a0: Display char
    ##### Init function  #####
        addi $sp, $sp, -4  # PRINT_CHAR: use 1 registers $a0
        sw $a0, 4($sp)
        
    ##### Main function  #####
        li $v0, 11  # PRINT_CHAR
        syscall

    ##### Reset function #####
        lw $a0, 4($sp)
        addi $sp, $sp, 4
    jr $ra  # Return PRINT_CHAR

PRINT_INT: # nguyenpanda (leaf function)(int = $a0) => void
    # PRINT_INT(int = $a0) => void
    #   - Print a int to screen
    # Parameters:
    #   a0: Display int
    ##### Init function  #####
        addi $sp, $sp, -4  # PRINT_INT: use 1 registers $a0
        sw $a0, 4($sp)

    ##### Main function  #####
        li $v0, 1  # PRINT_INT
        syscall

    ##### Reset function #####
        lw $a0, 4($sp)
        addi $sp, $sp, 4
    jr $ra  # Return PRINT_INT

### INFIX TO POSTFIX
IS_OPERAND: # nguyenpanda (leaf function)(char = $a0) => $v0: boolean
    # IS_OPERAND(char = $a0) => $v0: boolean
    #   - Check if a character is an operand
    # Parameters:
    #   a0: Character
    # Return:
    #   v0: 1 if character is an operand, 0 if not
    ##### Init function  #####
        addi $sp, $sp, -12  # IS_OPERAND: use 3 registers $a0, $t0, $t1
        sw $a0, 0($sp)
        sw $t0, 4($sp)      # t0 = character
        sw $t1, 8($sp)      # t1 = operator
        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        li $v0, 0           # Assume that character is not an operand

    ##### Main function  #####
        beq $t0, '.', __IS_OPERAND_RETURN_TRUE  # If character is '.', return true
        beq $t0, 'M', __IS_OPERAND_RETURN_TRUE  # If character is '.', return true
        blt $t0, '0', __IS_OPERAND_RETURN_FALSE # If character < '0', return false
        bgt $t0, '9', __IS_OPERAND_RETURN_FALSE # If character > '9', return false
        __IS_OPERAND_RETURN_TRUE:
            addi $v0, $zero, 1  # Return true

    ##### Reset function #####
    __IS_OPERAND_RETURN_FALSE:
        lw $a0, 0($sp)
        lw $t0, 4($sp)
        lw $t1, 8($sp)
        addi $sp, $sp, 12
    jr $ra  # Return IS_OPERAND

IS_OPERATOR: # nguyenpanda (leaf function)(char = $a0) => $v0: boolean
    # IS_OPERATOR(operator: char = $a0) => $v0: boolean
    #   - Check if a character is an operator ('+', '-', '*', '/', '^', '!') or not
    # Parameters:
    #   a0: Character
    # Return:
    #   v0: 1 if character is an operator, 0 if not
    ##### Init function  #####
        addi $sp, $sp, -12  # IS_OPERATOR: use 3 registers $a0, $t0, $t1
        sw $a0, 0($sp)
        sw $t0, 4($sp)      # t0 = character
        sw $t1, 8($sp)      # t1 = operator
        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        li $v0, 0           # Assume that character is not an operator
    
    ##### Main function  #####
        beq $t0, '+', __IS_OPERATOR_RETURN_TRUE # If character is '+', return true
        beq $t0, '-', __IS_OPERATOR_RETURN_TRUE # If character is '-', return true
        beq $t0, '*', __IS_OPERATOR_RETURN_TRUE # If character is '*', return true
        beq $t0, '/', __IS_OPERATOR_RETURN_TRUE # If character is '/', return true
        beq $t0, '^', __IS_OPERATOR_RETURN_TRUE # If character is '^', return true
        beq $t0, '!', __IS_OPERATOR_RETURN_TRUE # If character is '!', return true
        
        j __IS_OPERATOR_RESET
        
        __IS_OPERATOR_RETURN_TRUE:
            li $v0, 1   # Return true

    ##### Reset function #####
    __IS_OPERATOR_RESET:
        lw $a0, 0($sp)
        lw $t0, 4($sp)
        lw $t1, 8($sp)
        addi $sp, $sp, 12
    jr $ra  # Return IS_OPERATOR

OPERATOR_PRECEDENCE: # nguyenpanda (leaf function)(operator: char = $a0) => $v0: int
    # OPERATOR_PRECEDENCE(operator: char = $a0) => $v0: int
    #   - Get the precedence of an operator
    # Parameters:
    #   a0: Operator
    # Return:
    #   v0: Precedence of the operator, [invalid] = -1, ['+', '-'] = 1, ['*', '/'] = 2, ['^'] = 3, ['!'] = 4
    ##### Init function  #####
        addi $sp, $sp, -8       # OPERATOR_PRECEDENCE: use 2 registers $a0, $t0
        sw $a0, 0($sp)
        sw $t0, 4($sp)          # t0 = operator
        move $t0, $a0           # SUPPORT PASS BY REFERENCE
        li $v0, -1              # Assume that operator is not valid

    ##### Main function  #####
        beq $t0, '+', __OPERATOR_PRECEDENCE_RETURN_1 # If operator is '+', return 1
        beq $t0, '-', __OPERATOR_PRECEDENCE_RETURN_1 # If operator is '-', return 1
        
        beq $t0, '*', __OPERATOR_PRECEDENCE_RETURN_2 # If operator is '*', return 2
        beq $t0, '/', __OPERATOR_PRECEDENCE_RETURN_2 # If operator is '/', return 2

        beq $t0, '^', __OPERATOR_PRECEDENCE_RETURN_3 # If operator is '^', return 3
        beq $t0, '!', __OPERATOR_PRECEDENCE_RETURN_4 # If operator is '!', return 4

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
            lw $a0, 0($sp)
            lw $t0, 4($sp)
            addi $sp, $sp, 8
    jr $ra  # Return OPERATOR_PRECEDENCE

INFIX_TO_POSTFIX: # nguyenpanda
    # INFIX_TO_POSTFIX($a0 = string) -> $v0 = string
    #   - Convert an infix expression to a postfix expression
    # Parameters:
    #   a0: Infix expression
    # Return:
    #   v0: Postfix expression
    ##### Init function  #####
        addi $sp, $sp, -32  # INFIX_TO_POSTFIX: use 4 registers $ra, $a0, $t0, $t1
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $t0, 8($sp)      # t0 = input string
        sw $t1, 12($sp)     # t1 = string length
        sw $t2, 16($sp)     # t2 = stack
        sw $t3, 20($sp)     # t3 = postfix string
        sw $t4, 24($sp)     # t4 = char
        sw $t5, 28($sp)     # t5 = temp

        move $t0, $a0       # SUPPORT PASS BY REFERENCE

        jal STRING_LENGHT
        move $t1, $v0
        blt $t1, 001, __invalid_len_INFIX_TO_POSTFIX    # If length < 001, jump to exception
        bgt $t1, 100, __invalid_len_INFIX_TO_POSTFIX    # If length > 100, jump to exception

        la $t2, stack

        la $t3, postfix_string

    ##### Main function  #####
        __loop_INFIX_TO_POSTFIX: 
            # for char in infix:
            lb $t4, 0($t0)
            beq $t4, 0, __while_INFIX_TO_POSTFIX
            beq $t4, '\n', __while_INFIX_TO_POSTFIX
            addiu $t0, $t0, 1

            # if (isOperand(char)): include '0' to '9', 'M', and '.'
            move $a0, $t4
            jal IS_OPERAND
            beq $v0 1, __operand_INFIX_TO_POSTFIX
            
            # elif char == ' '
            beq $t4, ' ', __loop_INFIX_TO_POSTFIX
            
            # elif char == '('
            beq $t4, '(', __left_parenthesis_INFIX_TO_POSTFIX
            
            # elif char == ')'
            beq $t4, ')', __right_parenthesis_INFIX_TO_POSTFIX
            
            # elif (isOperator(char)):
            move $a0, $t4
            jal IS_OPERATOR
            beq $v0, 1, __operator_INFIX_TO_POSTFIX
            
            # else:
                jal RED
                la $a0, exc_invalid_character
                jal PRINT_STRING
                addi $t0, $t0, -1
                lb $a0, 0($t0)
                jal PRINT_CHAR
                jal RESET
                jal new_line
                j __RESET_INFIX_TO_POSTFIX
        
        j __loop_INFIX_TO_POSTFIX

        __while_INFIX_TO_POSTFIX:
            # while stack:
            move $a0, $t2
            jal STACK_LENGTH
            beq $v0, 0, __RESET_INFIX_TO_POSTFIX

            li $a0, ' '
            sb $a0, 0($t3)
            addiu $t3, $t3, 1

            # result += stack.pop()
            move $a0, $t2
            jal STACK_POP
            sb $v0, 0($t3)
            addiu $t3, $t3, 1
            j __while_INFIX_TO_POSTFIX

    ##### If/else if/else #####
        __operand_INFIX_TO_POSTFIX:
            sb $t4, 0($t3)
            addiu $t3, $t3, 1
            j __loop_INFIX_TO_POSTFIX

        __left_parenthesis_INFIX_TO_POSTFIX:
            move $a0, $t2
            move $a1, $t4
            jal STACK_PUSH
            j __loop_INFIX_TO_POSTFIX

        __right_parenthesis_INFIX_TO_POSTFIX:
            __while_right_parenthesis_INFIX_TO_POSTFIX:
                # while stack and stack[-1] != '(':
                move $a0, $t2
                jal STACK_LENGTH
                beq $v0, 0, __if_right_parenthesis_INFIX_TO_POSTFIX

                move $a0, $t2
                jal STACK_TOP
                beq $v0, '(', __if_right_parenthesis_INFIX_TO_POSTFIX

                li $t4, ' '
                sb $t4, 0($t3)
                addiu $t3, $t3, 1
                
                jal STACK_POP
                sb $v0, 0($t3)
                addiu $t3, $t3, 1

                j __while_right_parenthesis_INFIX_TO_POSTFIX    
            __if_right_parenthesis_INFIX_TO_POSTFIX:
                # if stack and stack[-1] == '(':
                move $a0, $t2
                jal STACK_LENGTH
                beq $v0, 0, __loop_INFIX_TO_POSTFIX

                move $a0, $t2
                jal STACK_TOP
                bne $v0, '(', __loop_INFIX_TO_POSTFIX

                move $a0, $t2
                jal STACK_POP
            j __loop_INFIX_TO_POSTFIX

        __operator_INFIX_TO_POSTFIX:
            __check_exclamation__operator_INFIX_TO_POSTFIX:
                bne $t4, '!', __check_minus__operator_INFIX_TO_POSTFIX
                li $t4, ' '
                sb $t4, 0($t3)
                addiu $t3, $t3, 1
                li $t4, '!'
                sb $t4, 0($t3)
                addiu $t3, $t3, 1
                j __loop_INFIX_TO_POSTFIX

            __check_minus__operator_INFIX_TO_POSTFIX:
                # if (char == '-' 
                # and (result.isNotEmpty or result[-1] in ('(', ' ', '*', '/', '^'))
                # and (stack.isNotEmpty or stack[-1] in ('(', ' ', '*', '/', '^'))):
                bne $t4, '-', __while_operator_INFIX_TO_POSTFIX

                la $a0, postfix_string
                jal STRING_LENGHT
                beq $v0, 0, __next_and__operator_INFIX_TO_POSTFIX
                
                addi $v0, $v0, -1
                lb $t5, postfix_string($v0)
                beq $t5, '(', __next_and__operator_INFIX_TO_POSTFIX
                beq $t5, ' ', __next_and__operator_INFIX_TO_POSTFIX
                beq $t5, '*', __next_and__operator_INFIX_TO_POSTFIX
                beq $t5, '/', __next_and__operator_INFIX_TO_POSTFIX
                beq $t5, '^', __next_and__operator_INFIX_TO_POSTFIX

                j __while_operator_INFIX_TO_POSTFIX

                __do_minus__operator_INFIX_TO_POSTFIX:
                    sb $t4, 0($t3)  # result += '-'
                    addiu $t3, $t3, 1
                    j __loop_INFIX_TO_POSTFIX

                __next_and__operator_INFIX_TO_POSTFIX:
                    move $a0, $t2
                    jal STACK_LENGTH
                    beq $v0, 0, __do_minus__operator_INFIX_TO_POSTFIX

                    move $a0, $t2
                    jal STACK_TOP
                    beq $v0, '(', __do_minus__operator_INFIX_TO_POSTFIX
                    beq $v0, ' ', __do_minus__operator_INFIX_TO_POSTFIX
                    beq $v0, '*', __do_minus__operator_INFIX_TO_POSTFIX
                    beq $v0, '/', __do_minus__operator_INFIX_TO_POSTFIX
                    beq $v0, '^', __do_minus__operator_INFIX_TO_POSTFIX
            
            __while_operator_INFIX_TO_POSTFIX:
                # while stack and isOperator(stacxk[-1]) != '(' and operator_precedence(char) <= operator_precedence(stack[-1]):
                move $a0, $t2
                jal STACK_LENGTH
                beq $v0, 0, __end_while_operator_INFIX_TO_POSTFIX

                move $a0, $t2
                jal STACK_TOP
                beq $v0, '(', __end_while_operator_INFIX_TO_POSTFIX

                move $a0, $v0
                jal OPERATOR_PRECEDENCE
                move $t5, $v0

                move $a0, $t4
                jal OPERATOR_PRECEDENCE
                blt $t5, $v0, __end_while_operator_INFIX_TO_POSTFIX

                li $t5, ' '
                sb $t5, 0($t3)
                addiu $t3, $t3, 1

                move $a0, $t2
                jal STACK_POP
                sb $v0, 0($t3)
                addiu $t3, $t3, 1

                j __while_operator_INFIX_TO_POSTFIX
            __end_while_operator_INFIX_TO_POSTFIX:

            move $a0, $t2
            move $a1, $t4
            jal STACK_PUSH
            
            li $t4, ' '
            sb $t4, 0($t3)
            addiu $t3, $t3, 1
            j __loop_INFIX_TO_POSTFIX

    ##### Exception function #####
        __invalid_len_INFIX_TO_POSTFIX:
            jal RED
            la $a0, exc_inval_length_expression
            jal PRINT_STRING
            move $a0, $t1
            jal PRINT_INT
            jal RESET
            jal new_line
            j __RESET_INFIX_TO_POSTFIX

    ##### Reset function #####
    __RESET_INFIX_TO_POSTFIX:
        sb $zero, 0($t3)    # Add null terminator
        la $a0, stack       # Reset stack
        jal STACK_RESET
        move $v0, $t3

        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $t0, 8($sp)
        lw $t1, 12($sp)
        lw $t2, 16($sp)
        lw $t3, 20($sp)
        lw $t4, 24($sp)
        lw $t5, 28($sp)
        addi $sp, $sp, 32
    jr $ra  # Return INFIX_TO_POSTFIX

EVALUATE_POSTFIX: # nguyenpanda
    # EVALUATE_POSTFIX(infix: str = $a0) => $f0: float
    #   - Evaluate a postfix expression
    #   - The function convert all int -> float to calculate
    # Parameters:
    #   a0: Postfix expression
    ##### Init function  #####
        addi $sp, $sp, -20  # EVALUATE_POSTFIX: use 8 registers $ra, $a0, $t0, $t1, $t2, $t3, $t4, $t5
        sw $ra, 0($sp)
        sw $a0, 4($sp)
        sw $t0, 8($sp)      # t0 = postfix string
        sw $t3, 12($sp)     # t3 = temp
        sw $t4, 16($sp)     # t4 = char

        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        la $t2, stack

    ##### Main function  #####
        __loop_EVALUATE_POSTFIX:

            # for char in infix:
            lb $t4, 0($t0) # BREAKPOINT
            beq $t4, 0, __END_LOOP_EVALUATE_POSTFIX
            beq $t4, '\n', __END_LOOP_EVALUATE_POSTFIX
            addiu $t0, $t0, 1

            beq $t4, 'M', __M_EVALUATE_POSTFIX # BREAKPOINT
            
            move $a0, $t4
            jal IS_OPERAND
            beq $v0, 1, __do_operand_EVALUATE_POSTFIX # BREAKPOINT
            beq $t4, '-', __operand_EVALUATE_POSTFIX # BREAKPOINT
            
            __check_space__EVALUATE_POSTFIX:
            beq $t4, ' ', __space_EVALUATE_POSTFIX # BREAKPOINT

            # else:
                la $a0, number_buffer
                jal STRING_LENGHT
                bne $v0, 0, __number_buffer_not_empty_postfix__EVALUATE_INFIX # BREAKPOINT

                __check_operator__EVALUATE_POSTFIX:
                beq $t4, '+', __plus__EVALUATE_INFIX # BREAKPOINT
                beq $t4, '-', __minus__EVALUATE_INFIX # BREAKPOINT
                beq $t4, '*', __multiply__EVALUATE_INFIX # BREAKPOINT
                beq $t4, '/', __divide__EVALUATE_INFIX # BREAKPOINT
                beq $t4, '!', __factorial__EVALUATE_INFIX # BREAKPOINT
                beq $t4, '^', __exponential__EVALUATE_INFIX # BREAKPOINT

            j __invalid_postfix__EVALUATE_INFIX

        __END_LOOP_EVALUATE_POSTFIX: 
            la $a0, number_buffer # if number: stack.append(float(number))
            jal STRING_LENGHT
            beq $v0, 0, __check_stack_len_EVALUATE_POSTFIX # BREAKPOINT

            la $a0, number_buffer
            jal STRING_TO_DOUBLE
            
            la $a0, stack
            mov.d $f12, $f0
            jal STACK_PUSH_DOUBLE # BREAKPOINT

        __check_stack_len_EVALUATE_POSTFIX:
            la $a0, stack # if len(stack) != 1: raise ValueError("Invalid expression")
            jal STACK_LENGTH_DOUBLE
            bne $v0, 1, __invalid_postfix__EVALUATE_INFIX # BREAKPOINT
            # j END_PROGRAM # CHECKPOINT
        j __RESET_EVALUATE_POSTFIX

    ### If/else if ###
        __M_EVALUATE_POSTFIX:
            la $a0, number_buffer
            li $a1, 1
            l.d $f12, M
            jal DOUBLE_TO_STRING
            j __loop_EVALUATE_POSTFIX

        __operand_EVALUATE_POSTFIX:
            la $a0, stack
            jal STACK_LENGTH_DOUBLE
            bge $v0, 2, __check_space__EVALUATE_POSTFIX
            __do_operand_EVALUATE_POSTFIX:
                la $a0, number_buffer
                jal STRING_LENGHT
                add $t3, $v0, $a0 # BREAKPOINT
                sb $t4, 0($t3)
                # j END_PROGRAM
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

        __space_EVALUATE_POSTFIX:
            la $a0, number_buffer
            jal STRING_LENGHT
            beq $v0, 0, __loop_EVALUATE_POSTFIX # BREAKPOINT

            ### Print info
            
            bne $t4, '-', __else__space_EVALUATE_POSTFIX # BREAKPOINT
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f16, $f0 # $f16 = operand 2

                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f18, $f0 # $f18 = operand 1

                sub.d $f12, $f18, $f16 # $f12 = operand 1 - operand 2
                jal STACK_PUSH_DOUBLE

                j __end_else__space_EVALUATE_POSTFIX
            __else__space_EVALUATE_POSTFIX:
                la $a0, number_buffer
                jal STRING_TO_DOUBLE
                # $f0 = double(nyumber_buffer)
                la $a0, stack # BREAKPOINT
                mov.d $f12, $f0
                jal STACK_PUSH_DOUBLE
            __end_else__space_EVALUATE_POSTFIX:
            la $a0, number_buffer
            jal RESET_STRING
            j __loop_EVALUATE_POSTFIX # BREAKPOINT
    
    ### Else ###
        __number_buffer_not_empty_postfix__EVALUATE_INFIX:
            la $a0, number_buffer
            jal STRING_TO_DOUBLE
            # $f0 = double(nyumber_buffer)
            la $a0, stack
            mov.d $f12, $f0
            jal STACK_PUSH_DOUBLE

            la $a0, number_buffer
            jal RESET_STRING
            j __check_operator__EVALUATE_POSTFIX # BREAKPOINT

        __plus__EVALUATE_INFIX:
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f16, $f0 # $f16 = operand 2

                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f18, $f0 # $f18 = operand 1

                add.d $f12, $f18, $f16 # $f12 = operand 1 + operand 2
                jal STACK_PUSH_DOUBLE
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

        __minus__EVALUATE_INFIX:
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f16, $f0 # $f16 = operand 2

                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f18, $f0 # $f18 = operand 1

                sub.d $f12, $f18, $f16 # $f12 = operand 1 - operand 2
                jal STACK_PUSH_DOUBLE
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

        __multiply__EVALUATE_INFIX:
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f16, $f0 # $f16 = operand 2

                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f18, $f0 # $f18 = operand 1

                mul.d $f12, $f18, $f16 # $f12 = operand 1 * operand 2
                jal STACK_PUSH_DOUBLE
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

        __divide__EVALUATE_INFIX: # TODO NOT DONE ZERO DIVISION
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f16, $f0 # $f16 = operand 2

                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f18, $f0 # $f18 = operand 1

                div.d $f12, $f18, $f16 # $f12 = operand 1 / operand 2
                jal STACK_PUSH_DOUBLE
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

        __factorial__EVALUATE_INFIX:
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f16, $f0 # $f16 = operand 1
                cvt.w.d $f16, $f16
                
                mfc1 $a0, $f16
                jal FACTORIAL
                mtc1 $v0, $f12
                cvt.d.w $f12, $f12

                la $a0, stack
                jal STACK_PUSH_DOUBLE
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

        __exponential__EVALUATE_INFIX:
                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f14, $f0 # $f16 = operand 2

                la $a0, stack
                jal STACK_POP_DOUBLE
                mov.d $f12, $f0 # $f18 = operand 1

                jal EXPONENTIATION # $f12 = operand 1 ($f12) ^ operand 2 ($f14)
                mov.d $f12, $f0

                la $a0, stack
                jal STACK_PUSH_DOUBLE
            j __loop_EVALUATE_POSTFIX # BREAKPOINT

    ### Exception function ###
        __invalid_len__EVALUATE_INFIX:
            jal RED
            la $a0, exc_inval_length_expression
            jal PRINT_STRING
            move $a0, $t0
            jal PRINT_INT
            jal RESET
            j __RESET_EVALUATE_POSTFIX

        __invalid_postfix__EVALUATE_INFIX:
            la $a0, exc_invalid_postfix_expression
            jal PRINT_STRING
            j __RESET_EVALUATE_POSTFIX

    ##### Reset function #####
    __RESET_EVALUATE_POSTFIX:
        la $a0, stack
        jal STACK_POP_DOUBLE

        s.d $f0, M

        la $a0, stack
        jal STACK_RESET

        la $a0, number_buffer  # Reset number buffer
        jal RESET_STRING

        lw $ra, 0($sp)
        lw $a0, 4($sp)
        lw $t0, 8($sp)
        lw $t3, 12($sp)
        lw $t4, 16($sp)
        addi $sp, $sp, 20
    jr $ra  # Return EVALUATE_INFIX

### MATH
FACTORIAL: # nguyenpanda (function)(int = $a0) => $v0: int
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

    __exception_FACTORIAL:
        jal RED         # __exception_FACTORIAL
        # la $a0, factorial_out_of_bound
        jal PRINT_STRING
        move $a0, $t0
        jal PRINT_INT
        jal RESET
        jal new_line
        eret

    ##### Reset function #####
    __END_FACTORIAL:
        lw $t0, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8
    jr $ra          # Return FACTORIAL

EXPONENTIATION: # nguyenpanda (leaf function)(double_1 = $f12, double_2 = $f14) => $f0: double
    # EXPONENTIATION(double_1 = $f12, double_2 = $f14) => $f0: double
    #   - Calculate the exponentiation of 2 numbers
    #   - The function floor $f14 to int
    # Parameters:
    #   $f12: First number
    #   $f14: Second number will be floor to int
    # Return:
    #   $f0: (First number ^ Second number)
    ##### Init function  #####
        addi $sp, $sp, -8   # EXPONENTIATION: use 2 registers $t0, $t1
        sw $t0, 0($sp)      # t0 = floor(f14)
        sw $t1, 4($sp)
    
        mov.d $f16, $f28    # $f16 = 1

        cvt.w.d $f14, $f14
        mfc1 $t0, $f14

    ##### Main function  #####
        bgt $t0, 0, __positive_loop_EXPONENTIATION
        blt $t0, 0, __negative_loop_EXPONENTIATION

        # check 0 ^ 0 case
        c.eq.d $f12, $f14
        bc1t __invalid_exponention_EXPONENTIATION

        mov.d $f0, $f28
        j __end_EXPONENTIATION

        __positive_loop_EXPONENTIATION:
            mul.d $f16, $f16, $f12
            addi $t0, $t0, -1
            bgt $t0, 0, __positive_loop_EXPONENTIATION
            mov.d $f0, $f16
        j __end_EXPONENTIATION

        __negative_loop_EXPONENTIATION:
            div.d $f16, $f16, $f12
            addi $t0, $t0, 1
            blt $t0, 0, __negative_loop_EXPONENTIATION
            mov.d $f0, $f16
        j __end_EXPONENTIATION
    
    ##### Exception function #####
        __invalid_exponention_EXPONENTIATION:
            la $a0, exc_invalid_exponentiation
            jal PRINT_STRING
            j END_PROGRAM

    ##### Reset function #####
        __end_EXPONENTIATION:
            lw $t0, 0($sp)
            lw $t1, 4($sp)
            addi $sp, $sp, 8
    jr $ra  # Return EXPONENTIATION

### STRING AND DOUBLE MANIPULATOR
STRING_LENGHT: # nguyenpanda (leaf function)(string = $a0) => $v0: unsighted int
    # STRING_LENGHT(string = $a0) => $v0: unsighted int
    #   - Get the lenght of a string
    #   - Cut off the new line character and null character
    # Parameters:
    #   $a0: Address of the string (argument PASS BY REFERENCE or PASS BY VALUE)
    # Return:
    #   $v0: Lenght of the string
    ##### Init function  #####
        addi $sp, $sp, -8      # STRING_LENGHT: use 2 registers $t0, $t1
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
            lw $t1, 4($sp)
            lw $t0, 0($sp)
            addi $sp, $sp, 8
    jr $ra  # Return STRING_LENGHT

COMPARE_STRING: # nguyenpanda (function)(str_0 = $a0, str_1 = $a1) => $v0: boolean
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
        addi $sp, $sp, -20      # COMPARE_STRING: use 5 registers $ra, $t0, $t1, $t2, $t3
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

RESET_STRING: # nguyenpanda (leaf function)(string = $a0) => void
    # RESET_STRING(string = $a0) => void
    #   - Reset a string to null character
    # Parameters:
    #   $a0: Address of the string, argument PASS BY REFERENCE
    ##### Init function  #####
        addi $sp, $sp, -12      # RESET_STRING: use 3 registers $a0, $t0, $t1
        sw $a0, 0($sp)
        sw $t0, 4($sp)          # t0 = string
        sw $t1, 8($sp)          # t1 = null character

    ##### Main function  #####
        move $t0, $a0           # SUPPORT PASS BY REFERENCE
        li $t1, 0               # t1 = null character

        __loop_RESET_STRING:
            sb $t1, 0($t0)      # str[t0] = null character
            addiu $t0, $t0, 1   # str[t0++] Move to next character
            lb $t2, 0($t0)      # t2 = str[t0] Load character from memory
            beq $t2, $zero, __end_loop_RESET_STRING    # If character is null, end loop
        j __loop_RESET_STRING

    ##### Reset function #####
    __end_loop_RESET_STRING:
        lw $t1, 8($sp)
        lw $t0, 4($sp)
        lw $a0, 0($sp)
        addi $sp, $sp, 12
    jr $ra  # Return RESET_STRING

DOUBLE_TO_STRING: # nguyenpanda (function)(string_buffer = $a0, is_append_mode = $a1, double = $f12) => $v0, $v1
    # DOUBLE_TO_STRING(string_buffer = $a0, += mode = $a1, double = $f12) => $v0, $v1
    #   - Convert a double to a string stored in string_buffer
    #   - The function use 9 registers $ra, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $a0
    #                      $f16, $f18, $f22 as temporary registers
    # Parameters:
    #   a0: String buffer
    #   a1: += mode (0: replace, 1: +=)
    #   f12: Double
    # Return:
    #   v0: Integer string
    #   v1: Decimal string
    ##### Init function #####
        addi $sp, $sp, -48  # DOUBLE_TO_STRING: use 7 registers $ra, $t0, $t1, $t2, $t3, $t4, $t5
        sw $ra, 0($sp)
        sw $t0, 4($sp)  # number_buffer
        sw $t1, 8($sp)  # temp_space
        sw $t2, 12($sp) # is_negative
        sw $t3, 16($sp) # temp
        sw $t4, 20($sp) # temp count
        sw $t5, 24($sp) # temp count
        sw $t6, 28($sp) # temp count
        sw $a0, 32($sp) # string_buffer
        sw $a1, 40($sp) # += mode (0: replace, 1: +=)
        sw $t9, 44($sp) # main loop count

        move $t0, $a0
        li $t9, 2

        bne $a1, 0, __adding_mode_DOUBLE_TO_STRING
            # Replace mode
            jal RESET_STRING
            j __next_init_DOUBLE_TO_STRING
        __adding_mode_DOUBLE_TO_STRING:
            # += mode
            jal STRING_LENGHT
            add $t0, $t0, $v0
        __next_init_DOUBLE_TO_STRING:
        la $t1, temp_space
        li $t2, 0                   # is_negative = False
        l.d $f22, double_10p8

        cvt.w.d $f18, $f12
	    mfc1.d $v0, $f18            # $v0 = integer part

        mtc1.d $v0, $f16
        cvt.d.w $f16, $f16          # $f16 = integer part

        sub.d $f16, $f12, $f16      # $f16 = decimal part
        
        mul.d $f16, $f16, $f22
        c.lt.d $f26, $f16      # If f16 > 0
        bc1t 0, __next_next_SECOND_LOOP_DOUBLE_TO_STRING
            neg.d $f16, $f16
        __next_next_SECOND_LOOP_DOUBLE_TO_STRING:
        cvt.w.d $f16, $f16
        mfc1 $v1, $f16              # $v1 = decimal part

        bge $v0, $zero, __MAIN_DOUBLE_TO_STRING
        bgt $v1, $zero, __exception_DOUBLE_TO_STRING
        li $t2, 1
        sub $v0, $zero, $v0
        sub $v1, $zero, $v1
        li $t3, '-'
        sb $t3, 0($t0)
        addi $t0, $t0, 1
        
    ##### Main function #####
        __MAIN_DOUBLE_TO_STRING:
        bne $v0, $zero, __NEXT_DOUBLE_TO_STRING
        li $t3, '0'
        sb $t3, 0($t0)
        addi $t0, $t0, 1

        __NEXT_DOUBLE_TO_STRING:
        move $a0, $v0
        jal __PRIVATE_LOOP_DOUBLE_TO_STRING

        beq $v1, $zero, __end_DOUBLE_TO_STRING  
            li $t3, '.'
            sb $t3, 0($t0)
            addi $t0, $t0, 1

        la $t1, temp_space # Reset $t1

        # Convert double_10p8 to integer at $t4
        cvt.w.d $f18, $f22
	    mfc1.d $t4, $f18 # $t4 = 1000000

        div $v1, $t4 # $t5 = quotient
        mfhi $t5
        blt $t5, 9, __NEXT_DOUBLE_TO_STRING_2
        li $t6, -1
        beq $t9, 2, __loop_count_0_DOUBLE_TO_STRING

        __SECOND_LOOP_DOUBLE_TO_STRING:
            la $a0, temp_space
            jal RESET_STRING
            la $t1, temp_space # Reset $t1

            c.lt.d $f26, $f16      # If f16 > 0
            bc1t 0, __next_SECOND_LOOP_DOUBLE_TO_STRING
                neg.d $f16, $f16

            __next_SECOND_LOOP_DOUBLE_TO_STRING:
            mtc1.d $v1, $f20 # $f20 = second decimal part (as integer)
            cvt.d.w $f20, $f20 # Convert to double

            sub.d $f20, $f16, $f20 # $f20 = second decimal part * 10^8 - second decimal part as integer
            c.lt.d $f26, $f20      # If f20 > 0
            bc1t 0, __next2_SECOND_LOOP_DOUBLE_TO_STRING
                neg.d $f20, $f20

            __next2_SECOND_LOOP_DOUBLE_TO_STRING:
            mul.d $f20, $f20, $f22 # $f20 = second decimal part * 10^8
            cvt.w.d $f20, $f20 # Convert to integer
            mfc1 $v1, $f20

            div $v1, $t4 # $t5 = quotient
            mfhi $t5
            blt $t5, 9, __NEXT_DOUBLE_TO_STRING_2
            li $t6, -1

        __loop_count_0_DOUBLE_TO_STRING:
            mul $t5, $t5, 10
            addi $t6, $t6, 1
            blt $t5, $t4, __loop_count_0_DOUBLE_TO_STRING

        __loop_add_0_DOUBLE_TO_STRING:
            beq $t6, 0, __NEXT_DOUBLE_TO_STRING_2
            li $t3, '0'
            sb $t3, 0($t0)
            addi $t0, $t0, 1
            addi $t6, $t6, -1
            bne $t6, $zero, __loop_add_0_DOUBLE_TO_STRING

        __NEXT_DOUBLE_TO_STRING_2:
        move $a0, $v1
        jal __PRIVATE_LOOP_DOUBLE_TO_STRING

        addi $t9, $t9, -1
        beq $t9, $zero, __end_DOUBLE_TO_STRING
        j __SECOND_LOOP_DOUBLE_TO_STRING

    ##### SUB FUNCTION #####
        __PRIVATE_LOOP_DOUBLE_TO_STRING:
            __LOOP_PRIVATE_LOOP_DOUBLE_TO_STRING:
                beq $a0, $zero, __END_LOOP_DOUBLE_TO_STRING
                div $a0, $a0, 10
                mflo $a0
                mfhi $t3
                addi $t3, $t3, '0'
                sb $t3, 0($t1)
                addi $t1, $t1, 1
                j __LOOP_PRIVATE_LOOP_DOUBLE_TO_STRING

            __END_LOOP_DOUBLE_TO_STRING:
                addi $t1, $t1, -1
                lb $t3, 0($t1)
                beq $t3, 0, __RETURN_DOUBLE_TO_STRING
                sb $t3, 0($t0)
                addi $t0, $t0, 1
                j __END_LOOP_DOUBLE_TO_STRING

            __RETURN_DOUBLE_TO_STRING:
                jr $ra

    ##### Exception function #####
		__exception_DOUBLE_TO_STRING:
            la $a0, exc_double_to_string
            jal PRINT_STRING
            eret
		
    ##### Reset function #####
    __end_DOUBLE_TO_STRING:
        la $a0, temp_space
        jal RESET_STRING

        cvt.w.d $f12, $f12
	    mfc1.d $v0, $f12

        lw $ra, 0($sp)
        lw $t0, 4($sp)  # number_buffer
        lw $t1, 8($sp)  # temp_space
        lw $t2, 12($sp) # is_negative
        lw $t3, 16($sp) # temp
        lw $t4, 20($sp) # temp count
        lw $t5, 24($sp) # temp count
        lw $t6, 28($sp) # temp count
        lw $a0, 32($sp) # string_buffer
        lw $a1, 40($sp) # += mode (0: replace, 1: +=)
        lw $t9, 44($sp) # main loop count
        addi $sp, $sp, 48
    jr $ra  # Return DOUBLE_TO_STRING

STRING_TO_DOUBLE: # nguyenpanda (function)(string = $a0) => $f0: double
    # STRING_TO_DOUBLE(string = $a0) => $f0: double
    # - Convert a string to a double
    # Parameters:
    #   a0: String
    # Return:
    #   f0: Double
    ##### Init function  #####
        addi $sp, $sp, -20  # STRING_TO_DOUBLE: use 5 registers $ra, $t0, $t1, $t2, $t3
        sw $a0, 0($sp)
        sw $t0, 4($sp)      # input string
        sw $t1, 8($sp)      # temp char in for loop
        sw $t2, 12($sp)     # is_negative
        sw $t3, 16($sp)     # is_unit_10

        move $t0, $a0       # SUPPORT PASS BY REFERENCE
        lb $t1, 0($a0)      # Load first character
        li $t2, 0           # is_negative = False
        li $t3, 1           # is_unit_10 = True
        mov.d $f0, $f26     # f0 = 0.0

        beq $t1, '-', __negative_STRING_TO_DOUBLE   # If character is '-', jump to negative
    ##### Main function  #####
        __loop_STRING_TO_DOUBLE:
            lb $t1, 0($t0)      # Load character
            addi $t0, $t0, 1    # Move to the next character
            beq $t1, 0, __end_STRING_TO_DOUBLE      # If character is null, end loop
            beq $t1, '\n', __end_STRING_TO_DOUBLE   # If character is new line, end loop

            bgt $t1, '9', __invalid_character_STRING_TO_DOUBLE  # If character > '9', jump to exception
            blt $t1, '0', __check_dot_STRING_TO_DOUBLE
            # If char == digit
            sub $t1, $t1, '0'   # Convert char to int
            mtc1 $t1, $f4       # Move value from register to float register
            cvt.d.w $f4, $f4    # Convert int to double (IEEE 754 format)

            # If is_unit_10
            bne $t3, 1, __unit_is_not_10_STRING_TO_DOUBLE
                mul.d $f0, $f0, $f30        # f0 *= 10
                add.d $f0, $f0, $f4         # f0 += digit
                j __loop_STRING_TO_DOUBLE   # Continue loop
            # If is_unit_10 = False
            __unit_is_not_10_STRING_TO_DOUBLE:
                div.d $f4, $f4, $f30        # f4 /= 10
                add.d $f0, $f0, $f4         # f0 += 0.1*digit
                l.d $f4, double_10          # f4 = 0.0
                mul.d $f30, $f30, $f4
                j __loop_STRING_TO_DOUBLE   # Continue loop

            j __invalid_character_STRING_TO_DOUBLE

    ##### If/elif/else functions #####
        __check_dot_STRING_TO_DOUBLE:
            bne $t1, '.', __invalid_character_STRING_TO_DOUBLE
            addi $t3, $zero, 0          # is_unit_10 = False
            j __loop_STRING_TO_DOUBLE

        __negative_STRING_TO_DOUBLE:
            addi $t0, $t0, 1            # Move to the next character
            li $t2, 1                   # is_negative = True
            j __loop_STRING_TO_DOUBLE   # Continue loop

    ##### Exception functions #####
        __invalid_character_STRING_TO_DOUBLE:
            la $a0, exc_invalid_character
            jal PRINT_STRING
            move $a0, $t0
            jal PRINT_CHAR
            jal new_line
            eret
         
    ##### Reset function #####
        __end_STRING_TO_DOUBLE:
            bne $t2, 1, __reset_STRING_TO_DOUBLE
            neg.d $f0, $f0          # f0 = -f0

        __reset_STRING_TO_DOUBLE:
            lw $a0, 0($sp)
            lw $t0, 4($sp)
            lw $t1, 8($sp)
            lw $t2, 12($sp)
            lw $t3, 16($sp)
            l.d $f30, double_10
            addi $sp, $sp, 20
    jr $ra  # Return STRING_TO_FLOAT

### UTILS
END_PROGRAM: # nguyenpanda
    jal YELLOW                  # END_PROGRAM
    la $a0, ascii_exit_prompt
    jal PRINT_STRING
    jal RESET
    li $v0, 10                  # syscall 10: exit
    syscall

TYPE_QUIT: # nguyenpanda
    jal RED                     # TYPE_QUIT
    la $a0, ascii_quit_prompt
    li $v0, 4
    syscall
    jal RESET
    j END_PROGRAM               # TYPE_QUIT

WRITE_TO_FILE: # nguyenpanda (function)(message = $a0, filename = $a1, mode = $a2) => void
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

        beq $a2, 1, __MAIN_WRITE_TO_FILE
        beq $a2, 9, __MAIN_WRITE_TO_FILE
        j __INVALID_MODE_WRITE_TO_FILE
    ##### Main function  #####
        __MAIN_WRITE_TO_FILE:
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

        j __RESET_WRITE_TO_FILE
    ##### Exception #####
        __INVALID_MODE_WRITE_TO_FILE:
            jal RED
            la $a0, exc_write_to_file_invalid_mode
            jal PRINT_STRING
            jal RESET
            eret

    ##### Reset function #####
        __RESET_WRITE_TO_FILE:
            lw $ra, 16($sp)
            lw $t3, 12($sp)
            lw $t2, 8($sp)
            lw $t1, 4($sp)
            lw $t0, 0($sp)
            addi $sp, $sp, 20
    jr $ra  # Return WRITE_TO_FILE

new_line: # RestingKiwi
    addi $sp, $sp, -8
    sw $a0, 0($sp)
    sw $v0, 4($sp)

    li $v0, 11    # new_line
    la $a0, '\n'
    syscall

    lw $a0, 0($sp)
    lw $v0, 4($sp)
    addi $sp, $sp, 8
    jr $ra  # Return new_line

### COLOR
COLOR: # nguyenpanda
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

    RESET: # nguyenpanda
        la $a0, reset   # RESET
        li $v0, 4
        syscall
        jr $ra  # Return RESET
