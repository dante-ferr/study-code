N, M = map(int, input().split())

tipos = {}

for i in range(N):
    for tipo in map(int, input().split()):
        if tipos.get(tipo):
            tipos[tipo] += 1
        else:
            tipos[tipo] = 1

P = int(input())
print(f"Ash pegou {tipos[P]} pokemon")