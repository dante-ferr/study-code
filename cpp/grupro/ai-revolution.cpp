#include <iostream>

typedef unsigned long long int ulint;

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    ulint q; 
    if (!(cin >> q)) return 0;

    while (q--) {
        ulint a; 
        cin >> a;

        ulint count = 0;

        for (ulint factor = 2; factor * factor <= a; factor++) {
            if (a % factor == 0) {
                count++;
                while (a % factor == 0) {
                    a /= factor;
                }
            }
        }

        if (a > 1) {
            count++;
        }

        cout << count << "\n";
    }

    return 0;
}