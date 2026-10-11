#include <iostream>
#include <algorithm>
#include <set>

typedef unsigned long long int ulint;

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n; 
    if (!(cin >> n)) return 0;

    multiset<int> heads;

    for (int i = 0; i < n; i ++) {
        int k; cin >> k;

        auto it = heads.lower_bound(k);

        if (it != heads.begin()) {
            heads.erase(prev(it));
        }

        heads.insert(k);
    }

    cout << heads.size();
}