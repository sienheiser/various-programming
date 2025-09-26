#include "constants.h"
#include <ctype.h>
#include <stdio.h>

char gethead(char s[]);
char getch(void);
void ungetch(char c);

char gethead(char s[])
{
    int c,i;
    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;
    s[1] = '\0';
    if (!isdigit(c) && c != '.')
        return c;
    if (isdigit(c)){
        i = 0;
        while (isdigit(s[++i] = c = getch()))
            ;
    if (c == '.')
        while (isdigit(s[++i] = c = getch()))
            ;
    s[i] = '\0';
    if (c != EOF)
        ungetch(c);
    }
    return NUMBER;
}


char buff[BUFSIZE];
int bp = 0;

char getch(void)
{
    return (bp > 0) ? buff[--bp] : getchar();
}

void ungetch(char c)
{
    if (bp >= BUFSIZ)
        printf("Buffer overflow: Cannot add %c\n",c);
    else
        buff[bp++] = c;
}