#include <iostream>

using namespace std;

class ciag{
    protected:
        int n;
        float a[1000];
    public:
        ciag();
        int arytmetyczny ();
        void usun(int i);
        friend ostream & operator<<(ostream &, ciag);
        void wypiszn();
        int ary();

};
ciag::ciag(){
   n = 3;
}
int ciag::arytmetyczny(){
    int r;
    r = a[1] - a[0];
    int i = 1;
    while(i < n - 1){
        if(a[n + 1] - a[n] != r)
            break;
    }
    if(i == n) return 1;
    else return 0;
}

void ciag::usun(int i){
    ciag c;
    for(int j = i; j < c.n; ++j)
        c.a[j + 1] = c.a[j];
    --c.n;
}
void ciag::wypiszn(){
    cout << n;
}

ostream & operator<<(ostream &wy, ciag c){
    for(int i = 0; i < c.n; ++i)
        wy << c.a[i] << ',';
    return wy;
}
int ciag::ary(){

int r = a[1] - a[0];
for(int i = i; i < n; ++i){
    if(a[i+1] - a[i] != r)
        return 0;
    else
        return 1;
        }

}

int main()
{
    int p = 1;
   ciag c;
   p = c.ary();
   c.wypiszn();
   c.usun(1);
   cout << 3%2;
}
