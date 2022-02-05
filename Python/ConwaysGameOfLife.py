from collections import Counter


def get_generation(cells, generations):
    if generations == 0:
        return cells
        
    alive_coords = set([(y,x) for x in range(len(cells)) for y in range(len(cells[0])) if cells[x][y] == 1])
    
    for x in range(generations):
        alive_coords, mx, mn = sim_step(alive_coords)
    
    if len(alive_coords) == 0:
        return [[]]

    final_cells = []
    for y in range(mn[1], mx[1]+1):
            final_cells.append(list([1 if (x, y) in alive_coords else 0 for x in range(mn[0], mx[0] + 1)]))
    return final_cells
    
def sim_step(alive_coords: set) -> set:
    def all_neighbors(alive_coords):
        return chain.from_iterable([neighbors(x, y) for x, y in alive_coords])

    def neighbors(x, y):
        return [(x + x1, y + y1) for x1 in [-1, 0, 1] for y1 in [-1, 0, 1]
                if not (x1 == 0 and y1 == 0)]

    def life(coord, neighbors):
        return neighbors == 3 or (neighbors == 2 and coord in alive_coords)

    next_generation = set()
    # bounding box - max, min
    mx = mn = tuple()
    for coord, count in Counter(all_neighbors(alive_coords)).items():
        if life(coord, count):
            next_generation.add(coord)

            if len(mx) == 0:
                mx, mn = coord, coord
            else:
                mx = max(mx[0], coord[0]), max(mx[1], coord[1])
                mn = min(mn[0], coord[0]), min(mn[1], coord[1])
    
    return (next_generation, mx, mn)