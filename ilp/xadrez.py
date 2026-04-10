grid = []
for i in range(8):
    row = list(map(int, input().split()))
    grid.append(row)

tower_pos = list(map(int, input().split()))

tower_r, tower_c = tower_pos[0], tower_pos[1]

killable = 0


def handle_pos(r, c):
    global killable
    if grid[r][c] == 1:
        return True
    if grid[r][c] == 2:
        killable += 1
        return True
    return False


for r in reversed(range(0, tower_r)):
    if handle_pos(r, tower_c):
        break

for r in range(tower_r + 1, 8):
    if handle_pos(r, tower_c):
        break

for c in reversed(range(0, tower_c)):
    if handle_pos(tower_r, c):
        break

for c in range(tower_c + 1, 8):
    if handle_pos(tower_r, c):
        break

print(killable)
