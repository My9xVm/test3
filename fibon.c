#include <stdio.h>
 
int main()
{
    int i, n = 32, t1 = 0, t2 = 1, nextTerm;
 
    for (i = 1; i <= n; ++i)
    {
        printf("%d ", t1);
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
    printf("\n");
    return 0;
}
