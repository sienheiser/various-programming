#include <stdio.h>
#include "constants.h"
#include <stdlib.h>
#include <math.h>
// intput space are stings of instructions like 1 2 + 5 9 + + which means (1+2) + (5+9).
// The operators must be binary operators. We can have integers and decimals.
// Behaviour of compiled code is
// a.out < "1 2 + 5 9 + +" writes 17 to the terminal.
// Generally a.out < "a1 a2 op1 a3 a4 op2 op3" = (a1 op1 a2) op3 (a3 op2 a4)

char gethead(char s[]);
void push(double f);
double pop(void);
void printstack(void);
void duplicate(char dup[]);
void swap(void);
int main()
{
    double op2;
    char type, s[MAXOP],dup[MAXOP];
    while ((type = gethead(s)) != EOF)
    {
        switch (type){
            case NUMBER:
                push(atof(s));
                break;
            case '+':
                push(pop()+pop());
                break;
            case '-':
                op2 = pop();
                push(pop()-op2);
                break;
            case '*':
                push(pop()*pop());
                break;
            case '%':
                op2 = pop();
                if (op2 == 0)
                    printf("Mod zero error\n");
                else
                    push((int)pop() % (int)op2);
                break;
            case '\n':
                printf("\t%.8g\n", pop());
                break;
            case '/':
                op2 = pop();
                if (op2 == 0)
                    printf("Division by 0 error\n");
                else
                    push(pop() / op2);
                break;
            case '^':
                op2 = pop();
                push(pow(pop(),op2));
                break;
            case 'd':
                duplicate(dup);
                break;
            case 'p':
                printstack();
                break;
            case 's':
                swap();
                break;
            default:
                printf("Cannot interpret %s",s);
                break;
        }
    }
    return 0;
}