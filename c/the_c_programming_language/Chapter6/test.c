#include <stdio.h>
#define WORDLEN 100


char get_word(char *word, int word_len);
int main(){
  char word[WORDLEN];
  while (get_word(word,WORDLEN) != EOF){
    printf("word = %s",word);
  }
}

char get_word(char *word, int word_len){
  int i;
  char c;
  for (i = 0; i < word_len && (c = getchar()) && (c != '\n' || c != ' ' || c != EOF);i++)
    word[i] = c;
  word[i] = '\0';
  if (c == EOF)
    return c;
  else 
    return '0';
}
