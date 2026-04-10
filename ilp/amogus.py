_ = input()
kills = list(map(int, input().split()))


def custom_sort(arr, low, high):
    if low < high:
        pivot = arr[high]
        i = low - 1

        for j in range(low, high):
            if arr[j] <= pivot:
                i = i + 1
                (arr[i], arr[j]) = (arr[j], arr[i])

        (arr[i + 1], arr[high]) = (arr[high], arr[i + 1])

        part_index = i + 1

        custom_sort(arr, low, part_index - 1)
        custom_sort(arr, part_index + 1, high)


custom_sort(kills, 0, len(kills) - 1)
print(*kills)
