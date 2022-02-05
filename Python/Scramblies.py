from collections import Counter
def scramble(s1,s2):
    c1,c2 = Counter(s1),Counter(s2)
    return all([c1.get(k,0) >= c for k,c in c2.items()])