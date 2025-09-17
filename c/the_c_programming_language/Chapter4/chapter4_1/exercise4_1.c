#include <stdio.h>
int strindex(char s[], char t[]);
int strindex_gen(char s[], char t[],int start);
int main()
{
    char s[20] = "could would";
    char t[5] = "uld";
    int i = strindex(s,t);
    
    int j;

    printf("%d\n",i);
    return 0;
}

int strindex(char s[], char t[])
{
    int i,start;
    start = 0;
    while ((i = strindex_gen(s,t,start)) != -1)
    {
        start = i + 1;
    }
    if (start - 1 >= 0)
        return start - 1;
    else
        return start - 1;
}

int strindex_gen(char s[], char t[], int start)
{
    int i,j,k;
    for (i=start;s[i]!='\0';i++)
    {
        for (j=i,k=0;t[k] != '\0' && s[j]==t[k];++j,++k)
            ;
        if (k > 0 && t[k] == '\0')
            return i;
    }
    return -1;
}