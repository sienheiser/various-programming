#include <stdio.h>




int main()
{
    //Write same for loop without using && and ||
    //for (i = 0;i < lim-1 && (c=getchar()) != '\n' && c != EOF;++i)

    for (i = 0; i < lim - 1; ++i)
    {
        c = getchar();
        s[i] = c;
        if (c == '\n')
            break;
        else if (c != EOF)
        break;
    }
    return 0;
}