#include <stdio.h>


void str_cat(char *s,char *t);
int main()
{
    char s[10] = "abcd";
    char t[] = "efg";
    str_cat(s,t);
    printf("%s\n",s);
}

void str_cat(char *s,char *t)
{
    while (*s++);
    s--;
    while (*s++=*t++);
}
