adj_x = [1, 0, -1, 0]
adj_y = [0, -1, 0, 1]

grid = []
for i in range(10):
    row = list(map(str, input().split()))
    grid.append(row)

for i in range(10):
    for j in range(10):
        for k in range(4):
            x = j + adj_x[k]
            y = i + adj_y[k]

            if x < 0 or x > 9 or y < 0 or y > 9:
                continue

            adj = grid[y][x]
            if adj == "*" and grid[i][j] == "t":
                grid[i][j] = "p"
                break

for row in grid:
    print(" ".join(row))
