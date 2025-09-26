#include <stdio.h>
#define STACKSIZE 100
int sp;
double val[STACKSIZE];

double pop(void);
void push(double);
void printstack(void);
void duplicate(char dup[]);
void swap(void);

double pop(void){
    if (sp > 0)
        return val[--sp];
    else 
        printf("Cannot pop from empty stack\n");
        return 0.0;
}

void push(double n){
    if (sp >= STACKSIZE)
        printf("Cannot push %g to full stack\n",n);
    else
        val[sp++] = n;
}

void printstack(void)
{
    printf("Stack = ");
    int i;
    for (i = 0; i < sp; i++)
    {
        printf("%g ",val[i]);
    }
    printf("\n");
}

void duplicate(char dup[])
{
    int i;
    for (i = 0; i < sp; i++)
    {
        dup[i] = val[i];
    }
}

void swap(void)
{
    double f = val[0];
    val[0] = val[1];
    val[1] = f;
}