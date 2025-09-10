#include <stdio.h>

int any(char s1[], char s2[]);
int in(char a, char s[]);

int main()
{
    char s1[5] = "abcd";
    char s2[3] = "cd";
    int ans = any(s1,s2);
    printf("ans=%d\n",ans);
}

int any(char s1[], char s2[])
{
    int i,ans;
    char a;

    for (i = 0; s1[i] != '\0';++i)
    {
        if ((ans = in(s1[i],s2)) >= 0)
            return i;
    }
    return -1;
}

int in(char a, char s[])
{
    int i;
    for (i = 0; s[i] != '\0'; ++i)
    {
        if (a == s[i])
            return i;
    }
    return -1;
}