#include "utilities.h"
#include <stdio.h>
#define MAXLINE 10
#define TAB_STOP_GORUP_LEN
#define TAB_STOP_APPEARANCE
int get_line(char line[],int len);
void detab(char line[],int len, char newline[]);
int main()
{
    int len = 0;
    char line[MAXLINE];
    char newline[MAXLINE];
    while ((len = get_line(line,MAXLINE)) != 0)
    {
        detab(line,len,newline);
        printf("%s",newline);
    }
    return 0;
}

int get_line(char line[],int len)
{
    int i;
    char c;

    for (i=0; (c = getchar()) != EOF && c != '\n' && i < len-1; ++i)
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

void detab(char line[], int len, char newline[])
{
    int i,j;
    j = 0;
    for (i = 0; i < len; ++i)
    {
        if (line[i] == '\t')
        {
            newline[i+j] = ' ';
            ++j;
            newline[i+j] = ' ';
        } else 
        {
            newline[i+j] = line[i];
        }
    }
}