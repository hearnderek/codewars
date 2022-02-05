import math
def who_is_next(names, r):
    i = 1
    d = 0
    x = len(names)
    while x+d < r:
        d+=x
        x*=2
        i*=2
    ret = names[math.ceil((r-d)/i)-1]
    return ret