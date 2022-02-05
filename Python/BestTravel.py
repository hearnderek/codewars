from itertools import combinations

def choose_best_sum(t, k, ls):
    possibles = list(
        filter(lambda x: x<=t, 
        sorted(ls, reverse=True)))
    
    max_found = None
    for x in combinations(possibles, k):
        total = sum(x)
        if total == t:
            return t
        elif total < t:
            max_found = max(max_found, total) if max_found else total
                
    return max_found