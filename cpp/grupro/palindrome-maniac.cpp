#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int main() {
    int N; cin >> N;
    if (N == 0) {
        cout << 0;
        return 0;
    }

    vector<int> numbers;
    numbers.reserve(N);

    for (int i = 0; i < N; i ++) {
        int A; cin >> A;
        numbers.push_back(A);
    }

    int highest_possible_mod = 0;
    for (int i = 0; i < floor(N / 2); i ++) {
        int a = numbers[i];
        int b = numbers[N - i - 1];

        if (a != b) {
            highest_possible_mod = gcd(abs(a - b), highest_possible_mod);
        }
    }

    if (highest_possible_mod == 0) {
        cout << 0;
        return 0;
    }

    cout << highest_possible_mod;

    return 0;
}