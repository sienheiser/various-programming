#include <stdio.h>

#define MAXLINE 1000

double atof(char []);
int main()
{
    double sum;
    char line[MAXLINE];
    char val[10] = "1.55e-3";
    printf("%g\n",atof(val));
}