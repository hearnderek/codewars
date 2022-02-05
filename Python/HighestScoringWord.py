abc='abcdefghijklmnopqrstuvwxyz'
i=range(1,len(abc)+1)
char_score=dict(zip(abc,i))

def high(x):
    words = x.split()
    return max(words, key=word_score)
        
def word_score(word):
    return sum([char_score[c] for c in word])