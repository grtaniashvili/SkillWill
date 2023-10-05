
lst = []
for i in range(5):
    a = input()
    lst.append(a)

MaxLen = len(lst[0])

for i in lst:
    if len(i) > MaxLen:
        MaxLen = len(i)

print(MaxLen,lst)


