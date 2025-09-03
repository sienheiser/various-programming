#include <stdio.h>
#define MAXLENGHT 10

int get_line(char line[], int length);
void entab(char from[], int length, char to[]);
int grouped_spaces(char line[], int index, int arr_length);

int main()
{
    int len = 0;
    char line[MAXLENGHT],newline[MAXLENGHT];

    while ((len = get_line(line,MAXLENGHT)) != 0)
    {
        entab(line,len,newline);
        printf("%s",newline);
    }
    return 0;
}

int get_line(char line[], int length)
{
    int i;
    char c;
    for (i = 0; i < length-1 && (c = getchar()) != EOF && c != '\n'; ++i)
    {
        line[i] = c;
    }
    if (c == '\n')
    {
        line[i] = c;
        ++i;
    }
    line[i] = '\0';
    return i;
}

void entab(char from[], int length, char to[])
{
    int i,j;
    j = 0;
    for (i = 0; i < length; ++i)
    {
        if (grouped_spaces(from,i,length))
        {
            to[j] = '\t';
            ++j;
            ++i;
        } else
        {
            to[j] = from[i];
            ++j;
        }
    }
}

int grouped_spaces(char line[], int index, int arr_length)
{
    if (index < arr_length - 1)
    {
        if (line[index] == ' ' && line[index+1] == ' ')
            return 1;
        else
            return 0;
    } else
    return 0;
}