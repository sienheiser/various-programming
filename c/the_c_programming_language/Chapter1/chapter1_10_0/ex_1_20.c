#include "utilities.h"
#define MAXLINE 10
void detab(char line[],int len);
int main()
{
    int len = 0;
    char line[MAXLINE];
    while ((len = get_line(line,MAXLINE)) != 0)
    {
        detab(line,len);
        printf("%s",line);
    }
    return 0;
}

void detab(char line[], int len)
{
    int i;
    for (i = 0; i < len; ++i)
    {
        if (line[i] = '\t')
        {
            line[i] = '  ';
        }
    }
}