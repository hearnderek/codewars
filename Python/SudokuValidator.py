def validBoard(board):
    validRowNum = len(board)==9
    validColumns = all(map(lambda xs: len(xs)==9,board))
    return validRowNum and validColumns

validRowSet = set(range(1,10))
def validRow(row):
    return len(validRowSet.difference(set(row))) == 0

def validColumns(board):
    return all(map(validRow,zip(*board)))

def validRows(board):
    return all(map(validRow,board))

def validSection(section):
    """ [[1,2,3],[1,2,3],[1,2,3]] """
    print(section)
    return validRow(section[0]+section[1]+section[2])

def flatten(xs):
    ys = []
    for x in xs:
        ys += x
    return ys
    

def group3(r):
    return [r[:3],r[3:6],r[6:9]]

def mapg3(xs):
    return list(map(group3,xs))

def validSections(board):
    for gy in range(3):
        for gx in range(3):
            if not validRow([board[y][x] for y in range(0+3*gy, 3+3*gy) for x in range(0+3*gx, 3+3*gx)]):
                return False
    return True

def validSolution(board):
    for r in board:
        print(r)
    checks = [validBoard, validRows, validColumns, validSections]
    for valid in checks:
        if not valid(board):
            return False
    return True 