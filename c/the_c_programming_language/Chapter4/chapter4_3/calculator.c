#include <stdio.h>
#define NUMBER '0'

//Max operand size
#define MAXOP 100
#define BUFSIZ 100

char read_instruc(char s[]);
void push(double f);
double pop(void);
void prtop(void);
void swap(void);
void duplicate(double temp[]);
int main()
{
    double op2,temp[BUFSIZ];
    char type,s[MAXOP];
    while ((type = read_instruc(s)) != EOF)
    {
        switch (type)
        {
            case NUMBER:
                push(atof(s));
                break;
            case '+':
                push(pop()+pop());
                break;
            case '*':
                push(pop()*pop());
                break;
            case '-':
                op2 = pop();
                push(pop()-op2);
                break;
            case '/':
                op2 = pop();
                if (op2 != 0){
                    push(pop()/op2);
                } else {
                    printf("Error divisor is 0");
                }
                break;
            case 'p':
                prtop();
            case 's':
                swap();
            case 'd':
                duplicate(temp);
            case '\n':
                printf("\t%.8g\n", pop());
                break;
            default:
                printf("error: unknown command %s\n", s);
                break;
        }
    }
    return 0;
}