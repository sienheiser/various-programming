//Input C code into program and count the amount of times 
//C keywords are used.

#define MAXLEN 100

struct keytab {
  char *key;
  int count;
};

char *get_word(char *word,int word_len);
int binsearch(char *word, struct keytab *key, int num_key_words);
void print_keys(struct keytab *keys,int num_key_words);

int main(){
  int num_key_words = 6
  struct keytab keys[num_key_words] = {
    "key1",0,
    "key2",0,
    "key3",0,
    "key4",0,
    "key5",0,
    "key6",0,
  };
  while (get_word(word,MAXLEN)) != EOF){
    key_index = binsearch(word,keys,num_key_words);
    if (key_index != -1)
      keys[key_index].count++;
  }

  print_keys(keys);
}


char *get_word(char *word, int word_len){
  for (i = 0; i < word_len && c = getchar() && (c != '\n' || c != ' ');i++)
    word[i] = c;
  word[i] = '\0';
}
