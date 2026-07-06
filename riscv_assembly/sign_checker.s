.data
str_pos:   .string "Positive\n"
str_neg:   .string "Negative\n"
str_zero:  .string "Zero\n"

.text
main:

    li a0, 5
    ecall
    mv t0, a0
    
    beqz t0 zero
    bltz t0 negative
    bgt t0, x0, positive
    
zero:
    la a1, str_zero
    li a0, 4
    ecall
    j exit

negative:
    la a1, str_neg
    li a0, 4
    ecall
    j exit
    
positive:
    la a1, str_pos
    li a0, 4
    ecall

exit:
li a0, 10
ecall
