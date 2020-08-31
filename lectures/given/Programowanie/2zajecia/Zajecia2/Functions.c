int Check(int Table[], int TabSize){

    int flag = 1;

    for(int i = 1; i < TabSize; i++){
        if(Table[i - 1] > Table[i])
            flag = 0;
    }

    return flag;
}
