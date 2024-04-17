.data
    myarr:.space 64
    myarray: .space 40
    promt: .asciiz "The sorted array is: "
    promt2: .asciiz ","

.text
sub:
    li $v0, 8
    la $a0, myarr
    li $a1, 80
    syscall
    andi $t0, $t0, 0    # pointer to myarr
    andi $t1, $t1, 0    # load byte from myarr
    andi $t2, $t2, 0    # pointer to myarr2
    li $t3, 1	        # negative 
    andi $t4, $t4, 0    # multipler
    andi $t5, $t5, 0    # take_element_from_myarr2

convert_string_to_int:
    lb $t1, myarr($t0)
    beq $t1, 44, skip_comma
    beq $t1, 0, main
    beq $t1, 10, main
    beq $t1, 45, set_negative
    # addi $t3, $t3, 1
    andi $t5, $t5, 0 # reset t5
    li $t4, 10
    # beq $t3, 1, add_unit
    j add_unit

add_unit:
    addi $t1, $t1, -48
    mult $t1, $t3
    mflo $t1
    lw $t5, myarray($t2)
    mult $t5, $t4
    mflo $t5
    add $t1, $t1, $t5
	sw $t1, myarray($t2)
	addi $t0, $t0, 1
    j convert_string_to_int

skip_comma:
    addi $t0, $t0, 1
    addi $t2, $t2, 4
    li $t3, 1# reset t3
    j convert_string_to_int

set_negative:
	addi $t3, $t3, -2  
	addi $t0, $t0, 1
	j convert_string_to_int
 
main:
    andi $t0, $t0, 0
    andi $t1, $t1, 0
    andi $t9, $t9, 0
    andi $t8, $t8, 0
    andi $t7, $t7, 0
    
bubble_sort:
    add $t7, $t7, 4
    andi $t0, $t0, 0
    beq $t7, 40, loop_print
    j bubble_sort_inner

bubble_sort_inner :
    andi $t1, $t1, 0
    beq $t0, 36, bubble_sort
    lw $t2, myarray($t0)
    add $t1, $t1, $t0
    addi $t1, $t1, 4
    lw $t3, myarray($t1)
    bgt $t2, $t3, swap
    addi $t0, $t0, 4
    j bubble_sort_inner

swap :
    sw $t3, myarray($t0)
    sw $t2, myarray($t1)
    addi $t0, $t0, 4
    j bubble_sort_inner

loop_print :
    beq $t9, 0, print_promt
    li $v0, 4
    la $a0, promt2
    syscall

	lw $a0, myarray($t9)
    li ,$v0, 1
    syscall
    addi $t9, $t9, 4
    beq $t9, 40, end
    j loop_print

print_promt:
    li $v0, 4
    la $a0, promt
    syscall

    lw $a0, myarray($t9)
    li ,$v0, 1
    syscall
    addi $t9, $t9, 4

    j loop_print

end :
