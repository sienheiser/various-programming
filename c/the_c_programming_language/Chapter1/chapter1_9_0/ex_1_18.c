#include <stdio.h>
#define MAXLINE 10

int get_line(char line[],int len);
void remove_blanks(char line[], int len);
int has_trailing_blank(char line[],int len);
int blank_line(char line[], int len);

int main()
{
    char line[MAXLINE];
    int len = 0;

    while ((len = get_line(line,MAXLINE)) != 0)
    {
        remove_blanks(line,len);

        if (blank_line(line,len) != 1)
        { 
            printf("%s",line);
        }
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
    char c;
    if (has_trailing_blank(line, len))
    {
        for (len = len-2; len >= 0 && (line[len] == ' ' || line[len] == '\t'); --len)
        {

            line[len] = '\0';
        }
        line[len+1] = '\n';
    } 
}

int has_trailing_blank(char line[],int len)
{
    return line[len-3] == ' ' || line[len-3] == '\t';
}

int blank_line(char line[], int len)
{
    return len == 1;
}