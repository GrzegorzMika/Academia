#include <stdio.h>
#include <stdlib.h>

int main()
{
    // sum of natural number
    int i, m;
    int sum = 0;

    m = 10;

    for(i = 1; i <= m; i++){
    sum+=i;
    printf("%d\n", sum);
    }

    printf("\n\n%d\n", sum);

    return 0;
}
