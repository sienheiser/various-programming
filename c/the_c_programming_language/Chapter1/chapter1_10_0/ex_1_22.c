#include <stdio.h>
#define MAX_WIDTH 8
#define MAXLENGTH 14

int get_line(char line[], int len);
void fold(char line[], int line_len, int width);
int is_blank(char a);
int find_prev_blank(char line[], int index);

int main()
{
    int line_len;
    char line[MAXLENGTH];
    while ((line_len = get_line(line,MAXLENGTH)) != 0)
    {
        fold(line,line_len,MAX_WIDTH);
        printf("%s",line);
    }
    return 0;
}


int get_line(char line[], int len)
{
    int i;
    char c;
    for (i = 0; i < len - 1 && (c = getchar()) != EOF && c != '\n'; ++i)
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

void fold(char line[], int line_length, int width)
{
    int i = width;
    while (i <= line_length)
    {
        if (is_blank(line[i]))
        {
            line[i] = '\n';
            ++i;
        } else
        {
            i = find_prev_blank(line,i);
            line[i] = '\n';
            ++i;
        }
        i = i + width;
    }
}

int is_blank(char a)
{
    return a == ' ' || a == '\t';
}

int find_prev_blank(char line[],int index)
{
    while (!(is_blank(line[index])))
    {
        --index;
    }
    return index;
}