#include <stdio.h>
#include <stdint.h>

int store_word(uint8_t *mem, size_t addr, uint32_t value){
    if(addr + 3 >= 256){
        printf("Error: Out of bounds!\n");
        return 1;
    }
    else if(addr % 4 != 0 ){
        printf("Error: Unaligned memory access!");
        return 1;
    }
    else{
    mem[addr]     = value & 0xFF;          
    mem[addr + 1] = (value >> 8)  & 0xFF;  
    mem[addr + 2] = (value >> 16) & 0xFF; 
    mem[addr + 3] = (value >> 24) & 0xFF;
    }

    return 0;
}

int load_word(const uint8_t *mem, size_t addr, uint32_t *out_value){

    if(addr + 3 >= 256){
        printf("Error: Out of bounds!\n");
        return 1;
    }
    else if(addr % 4 != 0 ){
        printf("Error: Unaligned memory access!");
        return 1;
    }
    else{
            *out_value = (mem[addr]) |
                 (mem[addr + 1] << 8) |
                 (mem[addr + 2] << 16) |
                 (mem[addr + 3] << 24);
    }

    return 0;
}

int main(void){

    uint8_t ram[256] = {0};
    uint32_t cpu_register = 0;

    printf("=== RISC-V Memory Controller Test ===\n\n");

    printf("Test 1: Writing 0xAABBCCDD to Address 4...\n");
    if (store_word(ram, 4, 0xAABBCCDD) == 0) {
        load_word(ram, 4, &cpu_register);
        printf("[SUCCESS] Read back value: 0x%08X\n\n", cpu_register);
    }

    printf("Test 2: Attempting to write to Address 5...\n");
    store_word(ram, 5, 0xFFFFFFFF);
    printf("\n");

    printf("Test 3: Attempting to read 4 bytes from Address 254...\n");
    load_word(ram, 254, &cpu_register);

    return 0;
}
