#include <stdio.h>
void squeeze(char s1[],char s2[]);
void squeeze_one_char(char s1[], char c);
int main()
{
    char s1[6] = "abcde";
    char s2[3] = "ad";
    squeeze(s1,s2);
    printf("s1=%s\n",s1);
    return 0;
}
void squeeze(char s1[],char s2[])
{
    int i;
    char c;
    for (i = 0; (c = s2[i]) != '\0';++i)
    {
        squeeze_one_char(s1,c);
    }
}

void squeeze_one_char(char s[],char c)
{
    int i,j;
    for (i = j = 0; s[i] != '\0'; i++)
    {
        if (s[i] != c)
            s[j++] = s[i];
    }
    s[j] = '\0';

}