M, N = map(int, input().split())

mapa = []
for i in range(M):
    row = list(map(int, input().split()))
    mapa.append(row)

c, X = input().split()
c = str(c)
X = int(X)

if c == "L":
    a = mapa[X - 1]
if c == "C":
    a = []
    for i in range(M):
        a.append(mapa[i][X - 1])

s = 0
for n in a:
    s += n

print(s)