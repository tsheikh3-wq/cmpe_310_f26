#include <stdio.h>
extern unsigned char ram[]; // RAM declared in assembly
extern void fill_ram(void); // Assembly function

int main()
{ fill_ram();
    printf("Sum at RAM+0X50:\n");
    printf("%02X", ram[0x50]);
    printf("\n");
     return 0;

}

