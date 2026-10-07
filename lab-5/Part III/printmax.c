#include <stdio.h>

extern int find_max(void);

int main(void)
{
    int result = find_max();

    printf("Maximum value = %d\n", result);

    return 0;
}