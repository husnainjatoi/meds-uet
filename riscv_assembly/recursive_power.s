.text
main:
    addi sp, sp, -16
    sw ra, 12(sp)
    
    li a0, 2
    li a1, 5
    
    call power
    
    mv a1, a0
    li a0, 1
    ecall
    
    lw ra, 12(sp)
    addi sp, sp, 16
    
    li a0, 10
    ecall
    
power:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw a0, 8(sp)

    beqz a1, base_zero
    addi a1, a1, -1
    
    call power
    
    lw t1, 8(sp)
    mul a0, a0, t1
    j exit
    
    base_zero:
        li a0, 1         
        j exit
    
    exit:
        lw ra, 12(sp)
        addi sp, sp, 16
        ret
