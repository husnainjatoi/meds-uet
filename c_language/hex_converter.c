#include <stdio.h>
#include <stdint.h>

int main(void){

    uint32_t hex_num;
    printf("Enter the 32bit hex value (format: 123ABC78): ");

    if(scanf("%X", &hex_num) !=1 ){
        printf("Error: Invalid Hex Number!\n");
        return 1;
    }
    
    printf("Hex: 0x%08X\n", hex_num);

    printf("Unsigned Decimal: %u\n", hex_num);
    printf("Signed Decimal: %d\n", hex_num);
    printf("Binary: ");

    for (int i = 31; i >= 0; i--) {

        if ((hex_num >> i) & 1U) {
            printf("1");
        } else {
            printf("0");
        }
        
        if (i % 4 == 0) {
            printf(" ");
        }
    }
    printf("\n");



    return 0;
};
