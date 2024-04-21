WRITE_TO_FILE: # nguyenpanda
    # WRITE_TO_FILE(message = $a0, length = $a1, filename = $a2) => void
    #   - Write a message to a file, REMEMBER to check the length of the message
    # Parameters:
    #   $a0: Address of the message string
    #   $a1: Length of the message string (including null character)
    #   $a2: Address of the filename string
    ##### Init function  #####
        addi $sp, $sp, -12 # WRITE_TO_FILE: use 3 registers $t0, $t1, $t2
        sw $t2, 8($sp)
        sw $t1, 4($sp)
        sw $t0, 0($sp)
        move $t0, $a0   # message
        move $t1, $a1   # max length
        move $t2, $a2   # filename

    ##### Main function  #####
        # Open the file
        li $v0, 13      # syscall 13: open
        move $a0, $a2   # filename
        li $a1, 1       # Write only with create (flat = 1)
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
        lw $t2, 8($sp)
        lw $t1, 4($sp)
        lw $t0, 0($sp)
        addi $sp, $sp, 12
    jr $ra