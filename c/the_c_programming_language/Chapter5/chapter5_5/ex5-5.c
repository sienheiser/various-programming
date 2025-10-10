#include <stdio.h>


void str_cpy(char *s, char *t, int num_char);
int str_cmp(char *s, char *t, int num_char);
void str_cat(char *s, char *t, int num_char);

int main()
{
    char s1[10];
    char t1[] = "abcde";
    int num_char1 = 4;
    str_cpy(s1,t1,num_char1);
    printf("s1=%s\n",s1);

    char s2[] = "abc";
    char t2[] = "abcde";
    int num_char2 = 2;
    int result = str_cmp(s2,t2,num_char2);
    printf("result=%d\n",result);

    char s3[10] = "abcd";
    char t3[] = "efg";
    int num_char3 = 2;
    str_cat(s3,t3,num_char3);
    printf("s3=%s\n",s3);
    
    return 0;
}

void str_cpy(char *s, char *t, int num_char)
{
    int i;
    for (i = 0; (*s++ = *t++) && i < num_char; i++);
    *s++='\0';
}


int str_cmp(char *s, char *t, int num_char)
{
    int i;
    for (i = 0; s[i] == t[i] && i < num_char; i++)
    {
        if (i == num_char - 1)
            return 0;
    }
    return s[i] - t[i];
}

void str_cat(char *s, char *t, int num_char)
{
    while (*s++);
    s--;
    int i;
    for (i = 0;  i < num_char && (*s++ = *t++); i++);

    *s = '\0';
}

