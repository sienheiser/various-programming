#include <stdio.h>


int htoi(char s[]);
int has_0x(char s[]);
int is_digit(char a);
int ishexaletter(char a);
int is_lower(char a);

int main()
{
    int len = 10;
    char hex[10] = "0x12Ab";
    int h = htoi(hex);
    printf("Number is %d\n", h);
    return 0;
}


int htoi(char s[])
{
    int i, n;
    int cond1,cond2;
    n = 0;
    for (i = has_0x(s); (cond1 = is_digit(s[i])) || (cond2 = ishexaletter(s[i])); ++i)
        if (cond1)
            n = 16 * n + (s[i] - '0');
        else if (cond2)
            if (is_lower(s[i]))
                n = 16 * n + (10 + s[i] - 'a');
            else
                n = 16 * n + (10 + s[i] - 'A');
    return n;
}

int has_0x(char s[])
{
    if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
        return 2;
    else
        return 0;
}

int is_digit(char a)
{
    return '0' <= a && a <= '9';
}

int ishexaletter(char a)
{
    int cond1 = 'A' <= a && a <= 'F';
    int cond2 = 'a' <= a && a <= 'f';
    return cond1 || cond2;
}
int is_lower(char a)
{
    return 'a' <= a && a <= 'f';
}
