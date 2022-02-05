from collections import Counter
# Write Once Read Never... ooph

def identify_ship(a,b,field,x,y):
    # assuming that only valid ships come here
    c = max(a,b)
    if field[y][x] == 0:
        return ' '
    if c == 0:
        return 'sub'
    if c == 1:
        return 'des'
    if c == 2:
        return 'cru'
    if c == 3: 
        return 'bat'

def add_tuple(t1,t2):
    return (t1[0]+t2[0],t1[1]+t2[1])

def add_neighbors(x,y,field,w,h):
    vc = lambda dx,dy: vector_count(x,y,(dx,dy),field,w,h)
    # lengths of vert and hor
    a,b = vc(0,-1)+vc(0,1),vc(-1,0)+vc(1,0)
    
    # ensure no diag - this makes the a,b values invalid
    c = vc(-1,-1)+vc(-1,1)+vc(1,-1)+vc(1,1)
    a += c
    b += c
    return a,b

def valid_neighbors(x,y,field,w,h):
    a,b = add_neighbors(x,y,field,w,h)
    return (bool(a) ^ bool(b) or a+b==0) and identify_ship(a,b,field,x,y)

def vector_count(x,y,d,field,h,w):
    c = -1
    while x>=0 and y>=0 and x<w and y<h and field[y][x] == 1:
        c+=1
        x,y=add_tuple((x,y),d)
    return max(c,0)

def validate_battlefield(field):
    h,w = len(field), len(field[0])
    ret = [valid_neighbors(x,y,field,w,h) for x in range(w) for y in range(h)]
    count = Counter(ret)
    return all(ret) and count['bat'] == 4 and count['des'] == 6 and count['cru'] == 6 and count['sub'] == 