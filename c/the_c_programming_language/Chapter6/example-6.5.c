struct tnode {
    char *word;
    int count;
    struct tnode *left;
    struct tnode *right;
};

typedef struct tnode tnode;


struct t {
    struct s *p;
};

struct s {
    struct t *q;
};

int main(){
    return 0;
}
