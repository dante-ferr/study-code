N, M = map(int, input().split())

direction = 1
eggs = 0

for y in range(N):
    row = list(map(int, input().split()))
    loop_row = row if direction == 1 else row[::-1]

    for a in loop_row:
        eggs = max(eggs + a, 0)

    direction = -direction

print(eggs)
