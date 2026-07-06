.data
array: .word 1,2,3,4,5,6,7,8,9

.text
main:
    la t0, array #low
    li s0, 3
    addi t1, x0, 0 #low
    addi t2, x0, 8 #high
    addi t3, x0, 0 #mid
    
    search:
        bgt t1, t2, not_found
        add t3, t1, t2
        srli t3, t3, 1
        slli t4, t3, 2 # calculating byte offset
        add t4, t4, t0
        lw t5, 0(t4)
        beq s0, t5, found # middle == element
        bgt s0, t5, greater # element > middle
        blt s0, t5, smaller # element < middle
        
    greater:
        addi t1, t3, 1 # new low = middle + 1
        j search
        
    smaller:
        addi t2, t3, -1 # new high = middle - 1
        j search
        
    found:
        mv a1, t3
        li a0, 1
        ecall
        li a0, 10
        ecall
        
    not_found:
        li a1, -1
        li a0, 1
        ecall
    
    done:
        li a0, 10
        ecall
