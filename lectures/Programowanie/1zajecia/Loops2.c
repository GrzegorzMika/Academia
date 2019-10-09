#include<stdio.h>
#include<stdlib.h>

int main()
{
    int number[1000], flag[1000];
    int sum = 0;

    for(int i = 0; i <= 999; i++){
        number[i] = i + 1;
        flag[i] = 0;
    }

    for(int i = 0; i <= 999; i++){
        if(number[i] % 3 == 0 | number[i] % 5 == 0){
        flag[i] = 1;
        };
    }

    for(int i = 0; i <= 999; i++){
        if(flag[i] == 1)
            sum+=number[i];
    }

    printf("%d", sum);
}
