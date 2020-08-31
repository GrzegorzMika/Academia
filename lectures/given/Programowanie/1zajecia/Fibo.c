#include<stdio.h>
#include<stdlib.h>

int fibonacci(int m);

int main(){
    printf("%d", fibonacci(7));
    return 0;
}



int fibonacci(int m){
    int series[m];

    if(m == 1)
        series[0] = 1;
    if(m == 2){
        series[0] = 1;
        series[1] = 2;
    }
    else{
        series[0] = 1;
        series[1] = 2;
        for(int i = 2; i < m; i++){
            series[i] = series[i - 1] + series[i - 2];
        }
    }

    return series[m-1];
}
