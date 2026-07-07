.data
array: .word 1, 2, 5, 6, 7, 8

.text        
main:
    addi sp, sp, -16
    sw ra, 12(sp)
    
    li a0, 3
    li a1, 5
    jal ra, max
    
    mv a1, a0
    li a0, 1
    ecall
    li a0, 11
    li a1, 10
    ecall
    
    la a0, array
    li a1, 6
    jal ra, sum_array
    mv a1, a0
    li a0, 1
    ecall
    
    lw ra, 12(sp)
    addi sp, sp, 16
    
    li a0, 10
    ecall
    
max:
    bge a0, a1, exit_max
    mv a0, a1
    exit_max:
        ret

sum_array:
    mv t0, x0 #sum
    mv t1, x0 #i
    loop:
    bge t1, a1, exit_sum
    lw t2, 0(a0)
    add t0, t0, t2
    addi a0, a0, 4
    addi t1, t1, 1
    j loop
    exit_sum:
        mv a0, t0
        ret
