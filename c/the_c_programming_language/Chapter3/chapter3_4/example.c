#include <stdio.h>

int main()
{
    
    int c,nother,nwhite,ndigit[10];
    nother = nwhite = 0;
    int i;
    for (i = 0; i < 10; i++)
    {
        ndigit[i] = 0;
    }
    while ((c = getchar()) != EOF)
    {
        switch (c)
        {
            case '0': case '1' : case '2' : case '3' : case '4' :
            case '5': case '6' : case '7' : case '8' : case '9' :
                ndigit[c - '0'] += 1;
                break;
            case '\n':
            case '\t':
            case ' ':
                nwhite += 1;
                break;
            default:
                nother += 1;
                break;
        }
    }
    printf("nwhite = %d\nnother = %d\n",nwhite,nother);
    for (i = 0; i < 10; i++)
        printf("%d = %d\n",i,ndigit[i]);
    return 0;
}