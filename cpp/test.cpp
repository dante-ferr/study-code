#include <bits/stdc++.h>

using namespace std;

int main() {
    int n;
    cin >> n;
    
    int m = 100;
    long long x = 1;
    for (int i = 2; i <= n; i++) {
        x = (x*i)%m;
    }
    cout << x%m << "\n";
    return 0;
}