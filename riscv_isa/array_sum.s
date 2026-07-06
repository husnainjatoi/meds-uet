.data
numbers: .word 1, 2, 3, 4, 5, 6, 7, 8

.text
main:
     addi t0, x0, 0 #sum
     addi t1, x0, 1 #i
     addi t2, x0, 8 #size
     la s0, numbers
     
     loop:
        bgt t1, t2, done
        addi t1, t1, 1
        lw s1, 0(s0)
        add t0, t0, s1
        addi s0, s0, 4
        j loop
        
     done:
        mv a1, t0
        li a0, 1
        ecall
        
        li a0, 10
        ecall
