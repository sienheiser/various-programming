#include <stdio.h>

// intput space are stings of instructions like 1 2 + 5 9 + + which means (1+2) + (5+9).
// The operators must be binary operators. We can have integers and decimals.
// Behaviour of compiled code is
// a.out < "1 2 + 5 9 + +" writes 17 to the terminal.
// Generally a.out < "a1 a2 op1 a3 a4 op2 op3" = (a1 op1 a2) op3 (a3 op2 a4)

char gethead(char s[]);
int main()
{
    while ((type = gethead(s)) != EOF)
    {
        switch (type){
            case NUMBER:
                push(atof(s));
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
            case '/':
                op2 = pop();
                if (op2 != 0)
                {
                    printf("Division by zero error\n");
                }
                break;
            case '%':
                break;
            case '^':
                break;
            case 'd':
                break;
            case 'p':
                break;
            case 's':
                break;
            default:
                printf("Cannot interpret %s",s);
                break;
        }
    }
    return 0;
}