#include <stdio.h>

void escape(char from[], char to[]);

int main()
{
    char to[20];
    char from[10] = "This\nis\t ";
    escape(from,to);

    printf("%s\n",to);

    return 0;
}

void escape(char from[], char to[])
{
    int i,j;
    j = 0;
    for (i = 0; from[i] != '\0'; ++i)
    {
        switch (from[i]){
            case '\t' : 
                to[i+j] = '\\';
                to[i+j+1] = 't';
                ++j;
                break;
            case '\n' :
                to[i+j] = '\\';
                to[i+j+1] = 'n';
                ++j;
                break;
            default :
                to[i+j] = from[i];
                break;
        }
    }
    to[i+j] = '\0';
}