#include <stdio.h>
#include <ctype.h>
#define MAXWORD 100

struct key {
    char *word;
    int count;
};
struct key keytab[] = {
    "auto", 0,
    "break", 0,
    "char", 0,
    "double", 0,
    "int", 0,
    "unsigned", 0,
};

int getword(char word[],int maxword);
int main(){
    int n;
    char word[MAXWORD];
    int NKEYS = sizeof(keytab)/sizeof(struct key);
    while (getword(word,MAXWORD) != EOF){
        if (isalpha(word[0])){
            if (n = binsearch(word,keytab,NKEYS) >= 0){
                keytab[n].count++;
            }
        }
    }

    for (n = 0; n < NKEYS; n++){
        if (keytab[n].count > 0)
            printf("%4d %s\n",
                    keytab[n].count, keytab[n].word);
    }
    return 0;
}