#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXWORD 100

struct tnode {
    char *word;
    int count;
    struct tnode *left;
    struct tnode *right;
};

typedef struct tnode tnode;
int main(){
    tnode *root;
    char word[MAXWORD]; 

    root = NULL;
    while (getword(word,MAXWORD) != EOF){
        if (isalpha(word[0]))
            root = addtree(root,word);
    
    treeprint(root, word);
    return 0;
}

