amount = 0

for i in range(7):
    row = list(map(int, input().split()))
    for j in range(i + 1):
        if row[j] == 1:
            amount += 1

print(amount)