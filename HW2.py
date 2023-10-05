# 1
def FindMinstr(L = []):
    m = L[0]
    for i in L:
        if i < m:
            m = i
    return m

def dctmin(D):
    return FindMinstr(list(D.values()))

tpl = {1:21,2:34,2:43,4:9,5:-1}

print(dctmin(tpl))


# 2

def rec(x):
    if x <= 1:
        return 1
    return x * rec(x - 1)

print(rec(6))