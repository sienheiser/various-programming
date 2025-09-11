#include <stdio.h>


int binsearch(int x, int v[], int n);
int main()
{
    return 0;
}

int binsearch(int x, int v[], int n)
{
    int low,mid,high;
    low = 0;
    high = n-1;
    while (low <= high)
    {
        mid = (high + low)/2;
        if (x < v[mid])
            high = mid + 1;
        else if (v[mid] < x)
            low = mid + 1;
        else
            return mid;
    }
    return -1
}

int binsearch(int x, int v[], int n)
{
    mid = (low+high)/2;
    while ()
    {
        if (v[mid] == x)
            return mid;
        else
            
    }
}