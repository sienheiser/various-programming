#include <stdio.h>
#define MAXLINE 1000

int getline(char line[],int len);
void copy(char to[], char from[]);

int main(){
    char line[MAXLINE],longest[MAXLINE];
    int len = 0;
    int max = 0;
    while ((len = getline(line,MAXLINE))>0){
        if (len > max){
            max = len;
            copy(longest,line);
        }
    }
    if (max > 0)
        printf("%s",longest);
    return 0;
}

int getline(char line[],int len){
    int i = 0;
    int c = 0;
    for (i=0;i<len-1 && (c=getchar())!=EOF && c != '\n';++i){
        line[i] = c;
    }
    if (c == '\n'){
        line[i] = c;
        ++i;
    }
    line[i] = '\0';

    return i;
}

void copy(char to[], char from[]){
    int i;
    i = 0;
    while ((to[i] = from[i]) != '\0'){
        ++i;
    }
}