def round(n):
    return max(0,min(n,255))

def rgb(r, g, b):
    return '{:02X}{:02X}{:02X}'.format(round(r), round(g), round(b))