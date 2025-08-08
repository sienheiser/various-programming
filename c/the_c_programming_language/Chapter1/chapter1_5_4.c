#include <stdio.h>

#define WORD_COUNTING 1
#define EX1_11 0
#define EX1_12 0

#if WORD_COUNTING
    void word_counting();
#elif EX1_11
    void ex1_11();
#elif EX2_11
    void ex1_12();
#endif

int main()
{
    if (WORD_COUNTING)
        word_counting();
    else if (EX1_11)
    {
        ex1_11();  
    }
    else if (EX1_12)
    {
        ex1_12();
    }
    return 0;
}

void word_counting(){
    #define IN 1
    #define OUT 0

    int c, nl, nw, nc, state;
    state = OUT;
    nl = nw = nc = 0;
    while ((c = getchar()) != EOF){
        ++nc;
        if (c == '\n')
            ++nl;
        if (c == ' ' || c == '\n' || c == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
    }
    printf("%d %d %d\n",nl,nw,nc);
}

