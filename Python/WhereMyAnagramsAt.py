def anagrams(word, words):
    ordered = sorted(word)
    return list(filter(lambda w: sorted(w) == ordered, words))