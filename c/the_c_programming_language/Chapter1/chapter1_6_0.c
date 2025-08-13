#include <stdio.h>



void countDigitAppearance(void);
void wordLengthHorizontalHist(void);
int* record_words(int max_length_word);
int is_whitespace(int c);
void print_horizontal_hist(int *word_length_bin);


int main()
{
    wordLengthHorizontalHist();
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

void wordLengthHorizontalHist(void){
    int max_length_word;
    max_length_word = 10;

    int *word_length_bin;
    word_length_bin = record_words(max_length_word);

    // print_horizontal_hist(word_length_bin);

}

int* record_words(int max_length_word){
    int num_char,c,i;

    int word_length_bin[max_length_word];
    for (i=0;i<max_length_word;i++){
        word_length_bin[i] = 0;
    }

    num_char = c = 0;
    while ((c = getchar()) != EOF){
        ++num_char;
        if (is_whitespace(c)){
            if (num_char <= max_length_word){
                ++word_length_bin[num_char];
            }
        }
    }
    return word_length_bin;
}

int is_whitespace(int c){
    if (c == ' ' || c == '\n' || c=='\t')
        return 1;
    else
        return 0;
}

/*
max_length_word = 10
word_length_bin = get_word_length_bin(max_length_word)

print_horizontal_hist(word_length_bin)

def get_word_length_bin(max_length_word:int)->List[int]:
    num_char = 0
    c = 0
    word_length_bin[max_length_word]
    for i in range(max_length_word):
        word_length_bin[i] = 0

    while (c = getchar()) != EOF:
        ++num_char
        if is_whitespace(c):
            if num_char <= max_length_word:
                word_length_bin[num_char] += 1
    return word_length_bin

def print_horizontal_hist(word_length_bin:List[int])->None:
    max_length = get_max_length(word_length_bin)
    print_numbers(max_length)
    for i in range(word_length_bin):
        print_hypen(i,word_length_bin[i])

*/