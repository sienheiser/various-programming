#include <stdio.h>

int lower(int c);

int main()
{
   int c = 'A';
   int c_lower = lower(c);
   printf("%c\n",c_lower);
   return 0;
}

int lower(int c)
{
    return (c >= 'A' && c <= 'Z') ? c + 'a' - 'A':c;
}