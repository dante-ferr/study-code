#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>

using namespace std;

long long satisfactions[19];
long long bonuses[19][19];
long long dp[1 << 18][18];

int dishes_amount, dishes_full, rules_amount;

long long solve(int mask, int last_dish)
{
    if (__builtin_popcount(mask) == dishes_full)
        return 0;
    if (dp[mask][last_dish] != -1)
        return dp[mask][last_dish];

    long long ans = 0;
    for (int next_dish = 0; next_dish < dishes_amount; next_dish++)
    {
        if (!(mask & (1 << next_dish)))
        {
            long long earn = satisfactions[next_dish] +
                             bonuses[last_dish][next_dish] +
                             solve(mask | (1 << next_dish), next_dish);
            ans = max(ans, earn);
        }
    }

    return dp[mask][last_dish] = ans;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin >> dishes_amount >> dishes_full >> rules_amount;

    for (int i = 0; i < dishes_amount; i++)
    {
        cin >> satisfactions[i];
    }

    for (int i = 0; i < rules_amount; i++)
    {
        int x, y;
        long long c;
        cin >> x >> y >> c;
        x--;
        y--;
        bonuses[x][y] = c;
    }

    memset(dp, -1, sizeof(dp));

    long long ans = 0;
    for (int i = 0; i < dishes_amount; ++i)
    {
        ans = max(ans, satisfactions[i] + solve(1 << i, i));
    }

    cout << ans << "\n";

    return 0;
}