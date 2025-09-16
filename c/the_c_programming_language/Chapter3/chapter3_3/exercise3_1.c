#include <stdio.h>
#include <time.h>


int binsearch(int x, int v[], int n);
int binsearch2(int x, int v[], int n);
int main()
{
    int v[10] = {1,3,5,7,9,11,13,15,17,19};

    int n = binsearch2(19,v,10);

    printf("%d\n",n);
    return 0;
}

int binsearch(int x, int v[], int n)
{
    int low, high, mid;
    low = 0;
    high = n - 1;
    while (low <= high) {
        mid = (low+high)/2;
        if (x < v[mid])
            high = mid + 1;
        else if (x > v[mid])
            low = mid + 1;
        else 
            return mid;
    }
    return -1; 
}

int binsearch2(int x, int v[], int n)
{
    int mid,low,high;
    if (x == v[0])
        return 0;
    low = 0;
    high = n - 1;
    mid = (low+high)/2;
    while (x < v[mid] ? (high = mid + 1) : (low = mid) && (low <= high))
    {
        printf("%d\n",high);
        if (v[mid] == x)
            return mid;
        mid = (low+high)/2;
    }
    return -1;
}