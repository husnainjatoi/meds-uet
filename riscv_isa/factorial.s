.text
main:
    li a0, 5
    ecall
    mv t0, a0
    
    addi t1, x0, 1 # i
    addi t2, x0, 1 # n!
    
    loop:
        ble t0, t1, done
        mul t2, t2, t0
        sub t0, t0, t1
        j loop
        
    done:
        mv a1, t2
        li a0, 1
        ecall
        
        li a0, 10
        ecall
