def find_missing_letter(chars):
    abc='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    index=abc.index(chars[0])
    slen = len(chars)-1
    for a,c in zip(abc[index+1:index+slen+1],chars[1:]):
        if a != c:
            return a