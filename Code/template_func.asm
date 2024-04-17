FUNCTION_NAME:
    # FUNCTION_NAME(<arg0> = $a0, <arg1> = $a1, <arg2> = $a2, ...) => void/int/...
    #   - 
    # Parameters:
    #   <arg0>: 
    #   <arg1>: 
    #   <arg2>: 
    ##### Init function  #####
        # addi $sp, $sp,  # FUNCTION_NAME: 
        # sw $t2, 8($sp)
        # sw $t1, 4($sp)
        # sw $t0, 0($sp)
        # move $t0, $a0   # 
        # move $t1, $a1   # 
        # move $t2, $a2   # 
        ...

    ##### Main function  #####
        ...

    ##### Reset function #####
        # addi $sp, $sp, -12 # FUNCTION_NAME:
        # sw $t2, 8($sp)
        # sw $t1, 4($sp)
        # sw $t0, 0($sp)
        ...
    # jr $ra

END_PROGRAM:
    # END_PROGRAM() => void
    #   - Terminate the program
    # Parameters: None
    ##### Main function #####
        li $v0, 10          # syscall 10: exit
        syscall
