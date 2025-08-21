#include <stdio.h>
#define MAXLINE 10
#define PRTINT_LINE_AFTER 6

int get_line(char line[],int len);

int main()
{
    int len;
    char line[MAXLINE];
    len = 0;
    while ((len = get_line(line,MAXLINE)) != 0)
    {
        // printf("length %d\n",len);
        if (len >= PRTINT_LINE_AFTER)
            printf("%s",line);
    }
    return 0;
}

int get_line(char line[], int len)
{
    int i,c;
    i = 0;
    c = 0;
    for (i=0; (c = getchar()) != EOF &&  c != '\n' && i < len-1;++i)
    {
        line[i] = c;
    }
    if (c == '\n')
    {
        line[i] = '\n';
        ++i;
    }
    line[i] = '\0';
    return i;
}