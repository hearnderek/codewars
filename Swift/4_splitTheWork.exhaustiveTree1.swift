class ChoiceNode {
    let choice: Int
    let bucketNumber: Int
    var possibles: [ChoiceNode]
    let solution: [[Int]]?

    init(choice: Int, bucketNumber: Int, remaining: [Int], buckets: [[Int]]) {
        self.choice = choice
        self.bucketNumber = bucketNumber
        self.possibles = []
        
        // print("bc: \(choice) \(bucketNumber)")

        if remaining.count > 0 {
            self.solution = nil

            // Build the rest of the tree
            for nextChoice in 0..<remaining.count {
                var choiceRemoved: [Int] = remaining
                choiceRemoved.remove(at: nextChoice)

                for bucket in 0..<buckets.count {
                    var newBuckets = buckets
                    newBuckets[bucket].append(remaining[nextChoice])
                    self.possibles.append(ChoiceNode(
                        choice: remaining[nextChoice], 
                        bucketNumber: bucket,
                        remaining: choiceRemoved,
                        buckets: newBuckets
                    ))
                }
            }
        } else {
            // We are at the end of the word
            self.solution = buckets
        }

    }

    static func build(_ list: [Int], bucketCount: Int = 2) -> ChoiceNode {
        var buckets: [[Int]] = []
        for _ in 0..<bucketCount {
            buckets.append([])
        }
        return ChoiceNode(
            choice: 0xDEADBEEF, 
            bucketNumber: -1, 
            remaining: list, 
            buckets: buckets
        )
    }

    func getSolutions() -> [[[Int]]] {
        var solutions: [[[Int]]] = []
        if self.solution != nil {
            solutions.append(self.solution!)
        }
        for possible in self.possibles {
            solutions.append(contentsOf: possible.getSolutions())
        }
        return solutions
    }
}

func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    // Makespan optimal optimization for 2-partition problem
    // Bruteforcing with combinatorics is generally not a good idea, but worst case is n = 40

    // sum list
    let listSum = list.reduce(0, +)
    let shift = listSum & 1 == 1 ? 0 : 1
    let optimalMakespan = (listSum + shift) / 2
    print("optimalMakespan: \(optimalMakespan)")

    let head = ChoiceNode.build(list, bucketCount: 2)
    let solutions: [[[Int]]] = head.getSolutions()
    var best: [[Int]] = solutions[0]
    var bestMakespan: Int = calcMakespan(best)
    for solution in solutions.dropFirst() {
        let makespan: Int = calcMakespan(solution)
        if makespan < bestMakespan {
            best = solution
            bestMakespan = makespan
        }

        if makespan == optimalMakespan {
            break
        }
    }
    print(bestMakespan, best)
    print()
    return (best[0], best[1])
}

func calcMakespan(_ list: [[Int]]) -> Int {
    var makespan: Int = 0
    for bucket in list {
        var sum: Int = 0
        for item in bucket {
            sum += item
        }
        if makespan < sum {
            makespan = sum
        }
    }
    return makespan
}