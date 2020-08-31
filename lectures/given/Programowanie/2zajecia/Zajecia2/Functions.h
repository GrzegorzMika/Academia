#ifndef FUNCTIONS_H_INCLUDED
#define FUNCTIONS_H_INCLUDED

void FillTable(int Table[], int TabSize, int seed){
    srand(seed);
    for(int i = 0; i < TabSize; ++i){
        Table[i] = rand() % 100;
    }
}

int Check(int Table[], int TabSize){

    int flag = 1;

    for(int i = 1; i < TabSize; ++i){
        if(Table[i - 1] > Table[i])
            flag = 0;
    }

    return flag;
}

void SelectionSort(int Table[], int TabSize){

    int tmp;

    for(int i = 0; i < TabSize; ++i){
        for(int j = i + 1; j < TabSize; ++j){
            if(Table[j] < Table[i]){
                tmp = Table[i];
                Table[i] = Table[j];
                Table[j] = tmp;
            }
        }

    }

}

void BubbleSort(int Table[], int TabSize){

    int Iter = TabSize;
    int tmp;

    do{
        for(int i = 1; i < Iter; ++i){
            if(Table[i - 1] > Table[i]){
                tmp = Table[i];
                Table[i] = Table[i - 1];
                Table[i - 1] = tmp;
            }
        }
    Iter--;
    }
    while (Iter > 1);

}

void InsertSort(int Table[], int TabSize){

    int i = 1;
    int j = 0;
    int tmp = 0;

    while( i < TabSize){
        j = i - 1;
        tmp = Table[i];
        while(j >= 0 & Table[j] > tmp){
            Table[j + 1] = Table[j];
            --j;
        }
        Table[j + 1] = tmp;
        ++i;
    }
}


void MergSort(int Start, int End, int Table[], int TabSize){

    int i,j,k, Middle;
    int TmpTable[TabSize];

    Middle = (Start + End) / 2;

    if(Middle > Start)
        MergSort(Start, Middle, Table, TabSize);
    if(Middle + 1 < End)
        MergSort(Middle + 1, End, Table, TabSize);

    i = Start;
    j = Middle + 1;
    k = 0;

    while(i <= Middle && j <= End){

        if(Table[i] < Table[j]){
            TmpTable[k] = Table[i];
            k++;
            i++;
        }
        else{
            TmpTable[k] = Table[j];
            k++;
            j++;
        }
    }

    while(i <= Middle){
        TmpTable[k] = Table[i];
        k++;
        i++;
    }

    while(j <= End){
        TmpTable[k] = Table[j];
        k++;
        j++;
    }

    for(int iter = 0; iter < k; ++iter){
        Table[Start + iter] = TmpTable[iter];
    }
}


void QuickSort(int Start, int End, int Table[]){

    int i,j;
    int Middle,Tmp;

    i = Start;
    j = End;

    Middle = Table[(Start + End) / 2];

    while(i <= j){
        while(Table[i] < Middle)
            i++;
        while(Table[j] > Middle)
            j--;
        if(i <= j){
            Tmp = Table[i];
            Table[i] = Table[j];
            Table[j] = Tmp;
            i++;
            j--;
        }
    }

    if(j > Start)
        QuickSort(Start, j, Table);
    if(i < End)
        QuickSort(i, End, Table);
}


void CountingSort(int Table[], int TabSize, int MaxValue){

    int TmpTable[TabSize];
    int CountingTable[MaxValue];

    for(int i = 0; i < MaxValue; ++i){
        CountingTable[i] = 0;
    }

    for(int i = 0; i < TabSize; ++i){
        CountingTable[Table[i]]++;
    }

    for(int i = 1; i < MaxValue; ++i){
        CountingTable[i] = CountingTable[i - 1] + CountingTable[i];
    }

    for(int i = TabSize - 1; i >= 0; --i){
        CountingTable[Table[i]]--;
        TmpTable[CountingTable[Table[i]]] = Table[i];
    }

    for(int i = 0; i < TabSize; ++i){
        Table[i] = TmpTable[i];
    }
}

void Sifting(int Start, int End, int Table[]){

    int tmp, i, j;

    tmp = Table[Start];
    i = Start;
    j = 2 * i + 1;
    while(j <= End){
        if(j < End && Table[j] < Table[j + 1])
            ++j;
        if(tmp < Table[j]){
            Table[i] = Table[j];
            i = j;
            j = 2 * i + 1;
        }
        else break;
    }
    Table[i] = tmp;
}

void CreateHeap(int Table[], int TabSize){
    for(int i = (TabSize - 2) / 2; i >= 0; --i)
        Sifting(i, TabSize - 1, Table);
}

void HeapSort(int Table[], int TabSize){
    int tmp;

    CreateHeap(Table, TabSize);
    for(int i = TabSize - 1; i >= 0; --i){
        tmp = Table[0];
        Table[0] = Table[i];
        Table[i] = tmp;
        Sifting(0, i - 1, Table);
    }
}


#endif // FUNCTIONS_H_INCLUDED
