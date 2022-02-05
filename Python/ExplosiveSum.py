def exp_sum(n):
    # exponent, coeficient
    cs = {0:1}
    for i in range(1,n+1):
        l = {}
        for ex, c in cs.items():
            for exp in [ex+i*j for j in range(n//i + 1)]:
                if exp <= n:
                    l[exp] = l.get(exp, 0) + c
        cs = l
    return(cs[n])