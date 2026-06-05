#include <stdio.h>
#include <stdint.h>

uint32_t extract_field(uint32_t instruction, int high, int low) {
    uint32_t num_bits = high - low + 1;
    uint32_t mask = (1U << num_bits) - 1;
    return (instruction >> low) & mask;
}

int main(void) {
    uint32_t instruction;

    printf("=== RV32 R-Type Instruction Decoder ===\n");
    printf("(Press CTRL+C to quit the program)\n");

    while (1) {
        printf("\nEnter 32-bit hex instruction (e.g., 00A28233): 0x");
        
        if (scanf("%x", &instruction) != 1) {
            printf("Invalid input detected. Exiting decoder...\n");
            break;
        }

        uint32_t opcode = extract_field(instruction, 6, 0);
        uint32_t rd     = extract_field(instruction, 11, 7);
        uint32_t funct3 = extract_field(instruction, 14, 12);
        uint32_t rs1    = extract_field(instruction, 19, 15);
        uint32_t rs2    = extract_field(instruction, 24, 20);
        uint32_t funct7 = extract_field(instruction, 31, 25);

        printf("\n--- Decoded Fields ---\n");
        printf("opcode = 0x%02X\n", opcode);
        printf("rd     = x%u\n", rd);
        printf("funct3 = %u\n", funct3);
        printf("rs1    = x%u\n", rs1);
        printf("rs2    = x%u\n", rs2);
        printf("funct7 = 0x%02X\n", funct7);
        printf("----------------------\n");
    }

    return 0;
}
