import itertools
def permutations(s):
    return list([''.join(x) for x in set(itertools.permutations(s))])