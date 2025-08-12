#include <stdio.h>



void countDigitAppearance(void);
void WordLengthHorizontalHistorgram(void);
char isWhitespace(int c);

int main()
{
    WordLengthHorizontalHistorgram();
    return 0;
}

void countDigitAppearance(void){
    int nwhite,nother,c,i;
    int ndigit[10];

    for (i=0;i<10;i++){
        ndigit[i] = 0;
    }
    while ((c = getchar()) != EOF){
        if ('0' <= c && c <= '9')
            ++ndigit[c-'0'];
        else if (c == ' ' || c == '\n' || c == '\t')
            ++nwhite;
        else
            ++nother;
    }
    
    printf("digits = " );
    for (i=0;i<10;i++){
        printf(" %d",ndigit[i]);
    }
    printf(", nwhitespace = %d, nothers = %d\n",nwhite,nother);
}

void WordLengthHorizontalHistorgram(void){


    int nc,c,maxCount,maxWordLength;
    nc = maxCount = 0;
    maxWordLength = 10;
    int wordLengthBin[maxWordLength];

    int i;
    for (i=0;i<maxWordLength;i++){
        wordLengthBin[i]=0;
    }

    while ((c = getchar()) != EOF){
        ++nc;
        if (isWhitespace(c)){
            if (nc > 1 && nc < maxWordLength)
                ++wordLengthBin[nc - 1];
            nc = 0;
            if (wordLengthBin[nc - 1]>maxCount)
                maxCount = wordLengthBin[nc - 1];
        }     
    }

    if (nc > 0 && nc < maxWordLength)
        ++wordLengthBin[nc];

    printf("%d",0);
    for (i=1;i<(maxCount-1);i++){
        printf(" %d",i);
    }
    printf("\n");
    int j;
    for (i=0;i<maxWordLength;i++){
        nc = wordLengthBin[i];
        for (j=0;j<nc;j++)
            printf("--");
        printf("\n");
    }
    printf(" %d\n",maxWordLength-1);
}

char isWhitespace(int c){
    if (c == '\n' || c == '\t' || c == ' ')
        return 1;
    else
        return 0;
}

/*
int wordLengthBin[100];
define IN 1
define OUT 0
int nchar,c,state

int i
for (i=0;i<100;i++){
    wordLengthBin[i] = 0;
}
state = OUT

while c = getchar() != EOF:
    ++nchar
    if c == '\n' || c == '\t' || c == ' ':
        state = OUT;
        ++wordLengthBin[nchar]
        nchar = 0

printHorizontalHistorgram(wordLengthBin);

*/