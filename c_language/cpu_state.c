#include <stdio.h>
#include <stdint.h>
#include <string.h>

typedef struct {
    uint32_t x[32];          
    uint32_t pc;            
    uint8_t  *memory;        
    size_t   mem_size;        
    uint64_t instr_count;    
    uint64_t cycle_count;
} cpu_state_t;

const char *abi_names[32] = {
    "zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
    "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
    "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
    "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

void cpu_init(cpu_state_t *cpu) {
    memset(cpu->x, 0, sizeof(cpu->x));
    
    cpu->pc = 0;
    cpu->instr_count = 0;
    cpu->cycle_count = 0;
    cpu->memory = NULL;
    cpu->mem_size = 0;
}

void reg_write(cpu_state_t *cpu, uint8_t rd, uint32_t val) {
    if (rd > 31) {
        printf("HARDWARE FAULT: Invalid register write index %u!\n", rd);
        return;
    }
    if (rd != 0) {
        cpu->x[rd] = val;
    }
}

uint32_t reg_read(const cpu_state_t *cpu, uint8_t rs) {
    if (rs > 31) {
        printf("HARDWARE FAULT: Invalid register read index %u!\n", rs);
        return 0;
    }
    return cpu->x[rs];
}

void dump_registers(const cpu_state_t *cpu) {
    for (int i = 0; i < 32; i++) {
        printf("x%-2d (%-4s): 0x%08X\n", i, abi_names[i], cpu->x[i]);
    }
}

int main(void) {
    cpu_state_t my_cpu;

    cpu_init(&my_cpu);

    reg_write(&my_cpu, 2, 0x7FFFFFFF); 
    reg_write(&my_cpu, 10, 42);        
    
    reg_write(&my_cpu, 0, 0xDEADBEEF); 
    reg_write(&my_cpu, 35, 0x1234);   

    printf("\n=== CPU Register Dump ===\n");
    dump_registers(&my_cpu);

    return 0;
}
