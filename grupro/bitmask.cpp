#include <iostream>
#include <vector>

using namespace std;

int main() {
    int n; cin >> n;
    int a[n][n];
    vector<int> dp(1ll << n, 0);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> a[i][j];
        }
    }

    dp[0] = 1;

    for (int msk = 0; msk < (1ll << n); msk++) {
        const int k = __builtin_popcount(msk);
        for (int j = 0; j < n; j++) {
            if ((msk & (1ll << j)) == 0 && a[k - 1][j]) {
                dp[msk] = (dp[msk] + dp[msk | (1ll << j)]) % MOD;
            }
        }
    }
}