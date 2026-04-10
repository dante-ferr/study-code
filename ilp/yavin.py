N, M = map(int, input().split())

grid = []
for _ in range(N):
    grid.append(list(map(int, input().split())))

destroyed_ships = 0

for _ in range(M):
    tel_y, tel_x = map(int, input().split())

    for attack_y in reversed(range(tel_y)):
        if grid[attack_y][tel_x] == 1:
            grid[attack_y][tel_x] = 0
            destroyed_ships += 1
            break

print(destroyed_ships)
