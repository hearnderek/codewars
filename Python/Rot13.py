def rot(c):
    wrap = 26 if c.lower() > 'm' else 0
    return chr(ord(c)+13 - wrap) if str.isalpha(c) else c
    
def rot13(message):
    return(''.join(map(rot,message)))