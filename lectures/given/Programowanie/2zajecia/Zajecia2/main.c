#include <stdio.h>
#include <stdlib.h>
#include "Functions.h"


int main()
{
    int TabSize = 5;
    int Table[TabSize];
    int seed = 123;
    int *TmpTable;
    //create random int table
    FillTable(Table, TabSize, seed);

    for(int i = 0; i < TabSize; i++){
        printf("%d\n", Table[i]);
    }

    //Check if table is sorted
    if(Check(Table, TabSize) == 1)
        printf("Sorted\n");
    else
        printf("Not sorted\n");

    // Sort table using various sorting algorithms

    //SelectionSort(Table, TabSize);
    //BubbleSort(Table, TabSize);
    //InsertSort(Table, TabSize);
    //MergSort(0, TabSize - 1, Table, TabSize);
    //QuickSort(0, TabSize - 1, Table);
    //CountingSort(Table, TabSize, 100);
    HeapSort(Table, TabSize);

    for(int i = 0; i < TabSize; i++){
        printf("%d\n", Table[i]);
    }

    //Check again if table is sorted
    if(Check(Table, TabSize) == 1)
        printf("Sorted\n");
    else
        printf("Not sorted\n");


    return 0;
}


