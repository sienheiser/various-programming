#include <stdio.h>
#define MAXLINE 10

int get_line(char line[],int len);
void reverse(int len,char line[],char revline[]);


int main()
{
    int len;
    char line[MAXLINE],revline[MAXLINE];

    while ((len = get_line(line,MAXLINE)) != 0)
    {
        reverse(len,line,revline);
        printf("%s",revline);
    }
}
int get_line(char line[], int len)
{
    int i,c;
    i = c = 0;

    for (i=0; i<len-1 && (c = getchar()) != EOF && c != '\n';++i)
    {
        line[i] = c;
    }
    if (c == '\n'){
        line[i] = c;
        ++i;
    }
    line[i] = '\0';
    return i;
}

void reverse(int len, char line[],char revline[])
{
    int i;
    for (i = len - 2; i >= 0; --i)
    {
        revline[len - 2 - i] = line[i];
    }
    revline[len - 1] = '\n';
    revline[len] = '\0';
}