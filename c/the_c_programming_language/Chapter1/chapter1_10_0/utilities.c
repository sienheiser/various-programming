#include <stdio.h>
int get_line(char line[],int len)
{
    int i;
    char c = 0;

    for (i = 0; i < len - 1 && (c = getchar()) != EOF && c != '\n';++i)
    {
        line[i] = c;
    }
    if (c == '\n')
    {
        line[i] = c;
        ++i;
    }
    line[i] = '\0';
    ++i;
    return i;
}