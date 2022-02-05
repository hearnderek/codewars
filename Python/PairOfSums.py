def sum_pairs(ints, s):
    lookup = set(ints[:1])
    for x in ints[1:]:
        needs = s - x
        if needs in lookup:
            return [needs,x]
        lookup.add(x)