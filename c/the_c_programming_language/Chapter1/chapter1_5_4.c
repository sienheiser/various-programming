#include <stdio.h>
#include <string.h>

#include <stdio.h>
#include <string.h>

void run_function(char *name);
void word_counting(void);
void ex1_11(void);
void ex1_12(void);

int main(void) {
    char *name = "ex1_12";
    run_function(name);
    return 0;
}

void run_function(char *name) {
    if (strcmp(name, "word_counting") == 0) {
        word_counting();
    } else if (strcmp(name, "ex1_11") == 0) {
        ex1_11();
    } else if (strcmp(name, "ex1_12") == 0) {
        ex1_12();
    } else {
        printf("Unknown function name: %s\n", name);
    }
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

void ex1_11(){
   /*Q:How would you test the word count program? What kinds of input are most likely to uncover bugs if there are any?
     A: Make a text file with a known number of lines, words and charaters and check whether the word counting program
     counts these parameters correctly. The most likely bugs will occur from escape characters like the arrow keys.*/ 
   
}

void ex1_12(){
    /*Q:Write a program that prints its input one word per line.*/
    #define IN 1
    #define OUT 0

    int c, state;
    state = OUT;
    while ((c = getchar()) != EOF){
        if (c == ' ' || c == '\n' || c == '\t'){
            putchar('\n');
            state = OUT;
        }
        else if (state == OUT) {
            state = IN;
            putchar(c);
        } else {
            putchar(c);
        }
    }

}

