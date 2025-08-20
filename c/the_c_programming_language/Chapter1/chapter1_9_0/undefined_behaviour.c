#include <stdio.h>

int getLine(char *line);
void copy(char *to, char *from);

int main(void){
    int len;
    int max;
    char *line;
    char *longest;

    max = 0;
    while ((len = getLine(line)) > 0)
        if (len > max) {
            max = len;
            copy(longest, line);
        }
    if (max >0)
        printf("%s",longest);
    return 0;
}

int getLine(char *s){
    int c,i;

    for (i=0; (c=getchar())!=EOF && c!='\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}

void copy(char *to, char *from){
    int i;

    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}