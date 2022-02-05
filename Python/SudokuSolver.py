class Cell(object):
    def __init__(self,x,y,val,groups):
        self.x = x
        self.y = y
        self.groups = groups
        self.val = 0

        self.set(val)

    def set(self,val):
        self.val = val
        for group in self.groups:
            group.set(val)
    
    def possible(self):
        if self.val != 0:
            return set()
        s = set(range(1,10))
        for group in self.groups:
            s.intersection_update(group.needed)
        return s

class Group(object):
    def __init__(self):
        self.needed = set(range(1,10))

    def set(self, val):
        if val != 0:
            self.needed.remove(val)

class Board(object):
    def __init__(self, board):
        self.board = board
        rows = list([Group() for _ in range(9)])
        cols = list([Group() for _ in range(9)])
        secs = list([Group() for _ in range(9)])
        
        def get_row(x,y):
            return y
        def get_col(x,y):
            return x
        def get_sec(x,y):
            return x//3*3 + y//3
        def get_groups(x,y):
            return [rows[get_row(x,y)], cols[get_col(x,y)], secs[get_sec(x,y)]]
        
        self.cells = list([Cell(x,y, board[y][x], get_groups(x,y)) for x in range(9) for y in range(9)])

    def unsolved(self):
        return any([cell.val == 0 for cell in self.cells])

    def set(self, cell, val):
        cell.set(val)
        self.board[cell.y][cell.x] = cell.val

    def print(self):
        for y in range(9):
            print(list([self.cells[x+y*9].val for x in range(9)]))

def sudoku(puzzle):
    b = Board(puzzle)
    updated = True
    while b.unsolved() and updated == True:
        updated = False
        for cell in b.cells:
            possible = cell.possible()
            if len(possible) == 1:
                b.set(cell, possible.pop())
                updated = True
    return b.board