#define STACKSIZE 100
double val[STACKSIZE];
int sp = 0;


void push(double f)
{
    val[sp++] = f;
}

double pop(void)
{
    return val[--sp];
}

void prtop(void)
{
    int i;
    printf("stack = ");
    for (i = 0; i < sp+1; i++)
    {
        printf("%g ", val[i]);
    }
    printf("\n");
}

void duplicate(double t[])
{
    int i;
    for (i = 0; i < sp; i++)
    {
        t[i] = val[i];
    }
}
void swap(void)
{
    double t; 
    if (sp > 1){
        t = val[0];
        val[0] = val[1];
        val[1] = t;
    } else {
        printf("Cannot swap first two elements since there are less than 2\n");
    }
}
