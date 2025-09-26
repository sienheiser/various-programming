#include "constants.h"
#include <stdio.h>

char gethead(char s[]);

int main ()
{
    char s[MAXOP];

    gethead(s);
    printf("%s\n",s);
    return 0;
}