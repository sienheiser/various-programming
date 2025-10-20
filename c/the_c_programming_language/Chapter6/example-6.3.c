#include <stdio.h>
//Input C code into program and count the amount of times 
//C keywords are used.

#define MAXLEN 100

struct keytab {
  char *key;
  int count;
};

char get_word(char *word, int max_len);
int binsearch(char *word, struct keytab *key, int arr_len);
void print_keytab(struct keytab key);

int main(){
  int num_key_words = 6;
  struct keytab keys[] = {
    "key1",0,
    "key2",0,
    "key3",0,
    "key4",0,
    "key5",0,
    "key6",0,
  };
  char word[MAXLEN];
  int binsearch_result;
  printf("Here1\n");
  while (get_word(word,MAXLEN) != EOF){
    printf("word = %s\n",word);
    binsearch_result = binsearch(word,keys,num_key_words);
    if (binsearch_result >= 0){
      keys[binsearch_result].count++;
    }
  }

  int i;
  for (i = 0; i < num_key_words; i++){
    print_keytab(keys[i]);
  }
}

char get_word(char *word, int max_len){
  char c;
  int i;
  for (i = 0; ((c = getchar()) != EOF || c != ' ' || c != '\n') && i < max_len; i++){
    printf("%c",c);
    word[i] = c;
  }
  word[i] = '\0';
  return c;
}

int binsearch(char *word, struct keytab *key, int arr_len){
  int low, mid, high;
  low = 0;
  high = arr_len;
  mid = (low+high)/2;

  while (low >= high){
    if (word < key[mid].key){
      high = mid;
      mid = (low+high)/2;
    } else if (word > key[mid].key){
      low = mid;
      mid = (low+high)/2;
    } else
      return mid;
  return 0; 
  }
}


void print_keytab(struct keytab key){
  printf("key = %s, count = %d\n",key.key,key.count);
}