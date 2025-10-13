#include <stdio.h>

int run_op(int (*bin_op)(int,int), int a, int b);
int add(int x, int y);

int main(){
    int a = 1;
    int b = 2;
    int result = run_op(add,a,b);
    printf("result=%d\n",result);
    return 0;
}
int run_op(int (*bin_op)(int,int), int a, int b){
    return bin_op(a,b);
}
int add(int x, int y){
   return x + y; 
}
