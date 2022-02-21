class Maze {
    // Constants 
    static let EMPTY: String = "."
    static let WALL: String = "W"

    // private members 
    private let  _maze: String

    // string member variables
    let locations: [[String]]
    let width: Int
  
    // constructor
    init(_ maze: String) {
        // HARD ASSUMPTION N by N maze
        self._maze = maze
        self.locations = maze.components(separatedBy: "\n").map { $0.map { String($0) } }
        self.width = locations.count
    }
  
    // member functions
    func toString() -> String {
        return _maze
    }

    // TODO move this into Traverser
    func getPossibleMoves(_ x: Int, _ y: Int) -> [(Int, Int)] {
        // HARD ASSUMPTION x and y are always in bounrds of the maze
        var moves: [(Int, Int)] = []
        if x > 0 && locations[y][x - 1] != Maze.WALL {
            moves.append((x - 1, y))
        }
        if x < locations.count - 1 && locations[y][x + 1] != Maze.WALL {
            moves.append((x + 1, y))
        }
        if y > 0 && locations[y - 1][x] != Maze.WALL {
            moves.append((x, y - 1))
        }
        if y < locations.count - 1 && locations[y + 1][x] != Maze.WALL {
            moves.append((x, y + 1))
        }
        return moves
    }
}

struct Point{
    var x: Int
    var y: Int
}

class DFSTraverser {
    static let VISITED: String = "V"
    let maze: Maze
    var mLocations: [[String]]
    let start: Point
    let goal: Point

    // set of positions order by distance to goal
    var distancedPositions: [(Int, Point)] = []

    init(_ maze: Maze, _ start: Point, _ goal: Point) {
        self.maze = maze
        self.mLocations = maze.locations
        self.start = start
        self.goal = goal
        add(start)
    }

    func getPossibleMoves(_ point: Point) -> [Point] {
        return maze
            .getPossibleMoves(point.x, point.y)
            .filter { mLocations[$0.1][$0.0] != DFSTraverser.VISITED }
            .map { Point(x: $0.0, y: $0.1) }
    }

    func add(_ point: Point) {
        let dist = abs(point.x - goal.x) + abs(point.y - goal.y)
        
        for i in 0..<distancedPositions.count {
            if distancedPositions[i].0 > dist {
                distancedPositions.insert((dist, point), at: i)
                return
            } else if distancedPositions[i].1.x == point.x && distancedPositions[i].1.y == point.y {
                // already in the set
                return
            }
        }
        distancedPositions.append((dist, point))
    }

    func pop() -> Point? {
        if distancedPositions.count == 0 {
            return nil
        }
        let point = distancedPositions.removeFirst().1
        mLocations[point.y][point.x] = DFSTraverser.VISITED
        return point
    }

    func tryTowardsGoal() -> Bool {
        while let point = pop() {

            if point.x == goal.x && point.y == goal.y {
                return true
            }

            // Could possibly persort these to improve insert performance
            for loc in getPossibleMoves(point) {
                add(loc)
            }
        }
        return false
    }
}

func pathFinder(_ maze: String) -> Bool {
    let m = Maze(maze)
    let travis = DFSTraverser(m, Point(x: 0, y: 0), Point(x: m.width - 1, y: m.width - 1))
    return travis.tryTowardsGoal()
}

