.data
numbers: .word 1, 2, 3, 4, -5, 6, 7, 56, 9, -10

.text
main:
     addi t1, x0, 10 # size
     addi t2, x0, 0 # i
     la s0, numbers
     lw t0, 0(s0) # max
     loop:
        beq t2, t1, done
        addi t2, t2, 1
        
        lw s1, 0(s0)
        addi s0, s0, 4
        
        bgt s1, t0, greater
        
        j loop
    
    greater:
        mv t0, s1
        j loop
        
    done:
        mv a1, t0
        addi a0, x0, 1
        ecall
        
        addi a0, x0, 10
        ecall
