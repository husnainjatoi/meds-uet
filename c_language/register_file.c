#include <stdio.h>
#include <stdint.h>

void write_reg(uint32_t *regs, uint8_t rd, uint32_t value){
    regs[0] = 0;

    if(rd > 31) {
        printf("Error: Invalid register number!\n");
        return;
    }
    else if (rd == 0) {
        printf("Error: x0 cannot be configured!\n");
        return;
    }
    else {
        regs[rd] = value;
        printf("Value updated successfully!\n");
    }
}

uint32_t read_reg(const uint32_t *regs, uint8_t rs){
    if(rs > 31) {
        printf("Error: Invalid register number!\n");
        return 0;
    }

    else {
        printf("Value in x%u: %u\n", rs, regs[rs]);
        return regs[rs];
    }

}

int main(void) {

    uint32_t regs[32] = {0};

    write_reg(regs, 4, 6);
    read_reg(regs, 4);

    return 0;
}