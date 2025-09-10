
#include <stdio.h>

unsigned getbits(unsigned x, int p, int n);
unsigned setbits(unsigned x, int p, int n, int y);
int main()
{
    int x,y,z;
    x = 0xAAA;
    y = 0x7;
    z = setbits(x,7,3,y);
    printf("%d\n",z);
    return 0;
}
unsigned getbits(unsigned x, int p, int n)
{
    return (x >> (p+1-n)) & ~(~0 << n);
}

unsigned setbits(unsigned x, int p, int n, int y)
{
    return (x | (y << (p+1-n)));
}
unsigned invert(unsigned x, int p, int n)
{
    
}