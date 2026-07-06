.data
array: .word 1,5,6,7,9,3,8

.text
main:
    la s0, array # base address of array
    li t0, 6 # size N - 1
    li t1, 0 # outer loop counter i
    li t2, 0 # inner loop counter j
    
    outer_loop:
        bge t1, t0, sorted
        li t2, 0
        mv t3, s0
        inner_loop:
            bge t2, t0, inner_done
            lw s1, 0(t3)
            lw s2, 4(t3)
            ble s1, s2, skip_swap
            sw s1, 4(t3)
            sw s2, 0(t3)

    skip_swap:
        addi t3, t3, 4
        addi t2, t2, 1
        j inner_loop
        
    inner_done:
        addi t1, t1, 1
        j outer_loop
        
    sorted:
        la t1, array
        li t2, 0
        li t5, 7
        
    print:
        bge t2, t5, exit
        lw a1, 0(t1)
        li a0, 1
        ecall
        li a1, 10
        li a0, 11
        ecall
        addi t1, t1, 4
        addi t2, t2, 1
        j print
        
    exit:
        li a0, 10
        ecall
