#include <stdio.h>

int bitcount(unsigned n);
int main()
{
    unsigned n = 7;
    int i = bitcount(n);
    printf("%d\n",i);
    return 0;
}

int bitcount(unsigned n)
{
    int b;
    for (b = 0; n != 0; n &= (n - 1))
    {
        ++b;
    }
    return b;
}