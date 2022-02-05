def valid(a):
    a1, a2, a3 = len(a[0]), len(a[0][0]), sorted(''.join(a[0]))
    names = set(''.join(a[0]))
    golfers = {}
    for x in names:
        golfers[x] = set()
    for day in a:
        if len(day) != a1 or a3 != sorted(''.join(day)):
            return False
        for group in day:
            if len(group) != a2:
                return False
            for x in group:
                s = set(group).difference(x)
                if any(s.intersection(golfers[x])):
                    return False
                else:
                    golfers[x] = golfers[x].union(s)
    return True