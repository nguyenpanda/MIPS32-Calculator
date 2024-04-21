PRINT_STRING: # nguyenpanda
    # PRINT_STRING(string = $a0) => void
    #   - Print a string to screen
    # Parameters:
    #   a0: Display string
    ##### Main function  #####
        li $v0, 4
        syscall
        jr $ra
    
PRINT_CHAR: # nguyenpanda
    # PRINT_CHAR(char = $a0) => void
    #   - Print a char to screen
    # Parameters:
    #   a0: Display char
    ##### Main function  #####
        li $v0, 11
        syscall
        jr $ra

READ_STRING_FROM_USER: # nguyenpanda
    # READ_STRING_FROM_USER(buff_address = $a0, max_lenght = $a1) => void
    #   - Read a string from user
    # Parameters:
    #   a0: Where string is located
    #   a1: Max length of string
    ##### Main function  #####
        li $v0, 8
        syscall
        jr $ra
