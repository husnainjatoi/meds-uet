.text
main:
    addi sp, sp, -16
    sw ra, 12(sp)
    
    li a0, 10
    jal fibonacci
    
    mv a1, a0
    li a0, 1
    ecall
    
    lw ra, 12(sp)
    addi sp, sp, 16
    
    li a0, 10
    ecall

fibonacci:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw a0, 8(sp)
    li t0, 1 #condition
    
    ble a0, t0, base_case
    addi a0, a0, -1
    jal ra, fibonacci
    sw a0, 4(sp)
    
    lw a0, 8(sp)
    addi a0, a0, -2
    jal ra, fibonacci

    lw t2, 4(sp)
    add a0, a0, t2
    
    base_case:
        lw ra, 12(sp)
        addi sp, sp, 16
        ret
