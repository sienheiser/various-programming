#include <stdio.h>



void countDigitAppearance(void);
void wordLengthHorizontalHist(void);
void record_words(int *word_length_bin,int max_length_word);
int is_whitespace(int c);
void print_horizontal_hist(int max_length_word,int *word_length_bin);
int get_max_length(int max_length_word, int *word_length_bin);
int get_max_count(int max_length_word, int *word_length_bin);
void print_numbers(int max_length);
void print_hypen(int num_letters, int count);

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

    int word_length_bin[max_length_word];
    int i;

    record_words(word_length_bin,max_length_word);

    // for (i=0;i<max_length_word;i++){
    //     printf("%d\n",word_length_bin[i]);
    // }

    print_horizontal_hist(max_length_word,word_length_bin);

}

void record_words(int *word_length_bin,int max_length_word){
    int num_char,c,i;

    for (i=0;i<max_length_word;i++){
        word_length_bin[i] = 0;
    }

    num_char = c = 0;
    while ((c = getchar()) != EOF){
        ++num_char;
        if (is_whitespace(c)){
            if ((0 <= num_char) && (num_char <= max_length_word)){
                ++word_length_bin[num_char-2];
                num_char = 0;
            }
        }
    }
}

int is_whitespace(int c){
    if (c == ' ' || c == '\n' || c=='\t')
        return 1;
    else
        return 0;
}

void print_horizontal_hist(int max_length_word, int *word_length_bin){
    int max_length,i;
    int max_count = get_max_count(max_length_word,word_length_bin);
    print_numbers(max_count);
    for (i=0;i<max_length_word;i++){
        print_hypen(i,word_length_bin[i]);
    }
}

int get_max_length(int max_length_word, int *word_length_bin){
    int index,i;
    for (i=0;i<max_length_word;i++)
        if (word_length_bin[i] != 0)
            index = i;
    return index;
}

int get_max_count(int max_length_word, int *word_length_bin){
    int count,i;
    count = 0;
    for (i=0;i<max_length_word;i++){
        if (word_length_bin[i] > count)
            count = word_length_bin[i];
    }
    return count;
}

void print_numbers(int max_length){
    int i;
    printf("  ");
    for (i=0;i<max_length;i++){
        printf("%d ",i+1);
    }
    printf("%d\n", max_length+1);
}

void print_hypen(int num_letters, int count){
    int i, num_hyphpen;
    num_hyphpen = count + count - 1;
    printf("%d ",num_letters+1);
    for (i=0;i<num_hyphpen;i++){
        printf("-");
    }
    printf("\n");
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