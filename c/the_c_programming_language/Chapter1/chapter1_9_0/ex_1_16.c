#include <stdio.h>
#define MAXLINE 6

int get_line(char line[],int len);
void copy(char to[], char from[]);

int main(){
    char line[MAXLINE],longest[MAXLINE];
    int len = 0;
    int max = 0;
    while ((len = get_line(line,MAXLINE))>0){
        if (len > max){
            max = len;
            copy(longest,line);
        }
    }
    if (max > 0)
        printf("length %d\n",max);
        printf("%s",longest);
    return 0;
}

int get_line(char line[],int len){
    int i = 0;
    int c = 0;
    while ((c = getchar()) != EOF){
        ++i;
        if (i < len - 1){
            line[i] = c;

            if (c == '\n'){
                line[i] = c; 
                ++i;
                line[i] = '\0';
            }
        }
        else if (i == len - 1){
            line[i] = '\0';
        }
    }

    return i;
}

void copy(char to[], char from[]){
    int i;
    i = 0;
    while ((to[i] = from[i]) != '\0'){
        ++i;
    }
}