#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define MAXOP 100 //Max size of operand. If n then can only handle n digit long numbers
#define NUMBER '0'


char getop(char s[]);
void push(double f);
double pop(void);

int main()
{
    char type,s[MAXOP];
    double op2;
    
    while((type = getop(s)) != EOF)
    {
        switch (type) {
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


#define STACKSIZE 100
double val[STACKSIZE];
int sp = 0;

void push(double f)
{
    if (sp < STACKSIZE)
        val[sp++] = f;
    else 
        printf("push: Stack is full cannot push %g\n",f);
    
}

double pop(void)
{
    if (sp > 0)
        return val[--sp];
    else {
        printf("pop: Stack is empty");
        return 0.0;
    }
}

char getch(void);
void ungetch(char);
char getop(char s[])
{
    char c;
    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;
    s[1] = '\0';

    if (!isdigit(c) && c != '.')
        return c;

    int i = 0;
    if (isdigit(c))
        while (isdigit(s[++i] = c = getch()))
            ;
    if (c == '.')
        while (isdigit(s[++i] = c = getch()))
            ;
    s[i] = '\0';
    if (c != EOF)
        ungetch(c);
    return NUMBER;
}


#define BUFFSIZE 100
char buff[BUFFSIZE];
int buffp;

char getch(void)
{
    return (buffp>0) ? buff[--buffp] : getchar();
}

void ungetch(char c)
{
    if (buffp >= BUFFSIZE)
        printf("ungetch: too many characters\n");
    else
        buff[buffp++] = c;
}
