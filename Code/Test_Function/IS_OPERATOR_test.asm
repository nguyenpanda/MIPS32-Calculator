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