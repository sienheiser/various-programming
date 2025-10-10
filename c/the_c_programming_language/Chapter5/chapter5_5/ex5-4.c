#include <stdio.h>

int str_end(char *s,char *t);

int main()
{
    char s[] = "abcdef";
    char t[] = "ef";
    int result = str_end(s,t);
    printf("result=%d\n",result);
    return 0;
}

int str_end(char *s, char *t)
{
    while (*s++);

    
    char *q = t;
    while (*q++)
        s--;
    s--;

    int i;
    for (i = 0 ;s[i] == t[i];i++)
    {
        if (s[i] == '\0')
            return 1;
    }
    return 0;
}
