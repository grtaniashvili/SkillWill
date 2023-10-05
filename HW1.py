
lst = [input() for _ in range(5)]

MaxLen = len(lst[0])

for i in lst:
    if len(i) > MaxLen:
        MaxLen = len(i)

print(MaxLen)




