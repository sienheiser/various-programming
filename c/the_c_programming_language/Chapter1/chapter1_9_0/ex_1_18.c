#include <stdio.h>
#define MAXLINE 10

int get_line(char line[],int len);
void remove_blanks(char line[],int len);
int main()
{
    char line[MAXLINE];
    int len = 0;

    while ((len = get_line(line,MAXLINE)) != 0)
    {
        remove_blanks(line);

        printf("%s",line);
    }
    return 0;
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

void remove_blanks(char line[],int len)
{
    for (len; len == 0; --len)
    {

    }
}