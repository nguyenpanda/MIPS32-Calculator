.data
    inputArr:.space 64
    resultArray: .space 40
    promt: .asciiz "The sorted array is: "
    promt2: .asciiz ","

.text
    # read the input
    li $v0, 8
    la $a0, inputArr
    li $a1, 80
    syscall

    # Set the pointers
    andi $t0, $t0, 0            # pointer to inputArr           | t0 = i 
    andi $t1, $t1, 0            # load byte from inputArr       | t0 = inputArr[i = t0]
    andi $t2, $t2, 0            # pointer to inputArr2          | t2 = j (this j memory address)
    li $t3, 1	                # is_positive                   | 1 = true, -1 = false 
    andi $t4, $t4, 0            # multipler                     | 
    andi $t5, $t5, 0            # take_element_from_inputArr2   | 

convert_string_to_int:
    lb $t1, inputArr($t0)       # t1 = inputArr[t0 = i]
        beq $t1, 44, skip_char     	# if the char is ',' , go to skip_comma
        beq $t1, 32, skip_char      # if the char is ' ' , go to skip_char
        beq $t1, 45, set_negative   # if the char is '-' , go to set_negative
        beq $t1, 00, main           # if the char is '\0', go to main
        beq $t1, 10, main           # if the char is '\n', go to main
    andi $t5, $t5, 0            # reset t5
    li $t4, 10                  # 

    addi $t1, $t1, -48          # number = digit - 48
    mult $t1, $t3               # lo = number * is_negative
    mflo $t1                    # number = lo
    lw $t5, resultArray($t2)    # t5 = resultArray[t2 = j]
    mult $t5, $t4               # lo = t5 * 10   
    mflo $t5                    # t5 = lo
    add $t1, $t1, $t5           # number = number + t5
    sw $t1, resultArray($t2)    # resultArray[t2 = j] = number
    addi $t0, $t0, 1            # i++

    j convert_string_to_int         # go to convert_string_to_int

skip_char:
    addi $t0, $t0, 1                # i++
    addi $t2, $t2, 4                # j++
    li $t3, 1                       # reset is_positive 
    j convert_string_to_int

set_negative:
	addi $t3, $t3, -2               # is_negative = -1
	addi $t0, $t0, 1                # i++
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

bubble_sort_inner:
    andi $t1, $t1, 0
    beq $t0, 36, bubble_sort
    lw $t2, resultArray($t0)
    add $t1, $t1, $t0
    addi $t1, $t1, 4
    lw $t3, resultArray($t1)
    bgt $t2, $t3, swap
    addi $t0, $t0, 4
    j bubble_sort_inner

swap:
    sw $t3, resultArray($t0)
    sw $t2, resultArray($t1)
    addi $t0, $t0, 4
    j bubble_sort_inner

loop_print:
    beq $t9, 0, print_promt
    li $v0, 4
    la $a0, promt2
    syscall

	lw $a0, resultArray($t9)
    li ,$v0, 1
    syscall
    addi $t9, $t9, 4
    beq $t9, 40, end
    j loop_print

print_promt:
    li $v0, 4
    la $a0, promt
    syscall

    lw $a0, resultArray($t9)
    li ,$v0, 1
    syscall
    addi $t9, $t9, 4

    j loop_print

end :
