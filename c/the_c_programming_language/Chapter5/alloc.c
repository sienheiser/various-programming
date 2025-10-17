#define ALLOCSIZE 100
static char alloc_buff[ALLOCSIZE];
static char *allocp = alloc_buff;


char *alloc(int n)
{
    if (alloc_buff + ALLOCSIZE - allocp >= n)
    {
        allocp += n;
        return allocp - n;
    } else {
        return 0;
    }
}

void afree(char *p)
{
    if (p >= alloc_buff && p < alloc_buff + ALLOCSIZE)
        allocp = p;
}