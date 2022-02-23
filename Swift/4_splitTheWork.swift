class Solution {
    var makespan: Int = 0
    var buckets: [[Int]]
    var bucketSums: [Int]

    init(_ buckets: [[Int]]) {
        self.buckets = buckets
        self.bucketSums = buckets.map { $0.reduce(0, +) }
    }

    init(clone: Solution) {
        self.buckets = clone.buckets
        self.bucketSums = clone.bucketSums
        self.makespan = clone.makespan
    }

    func schedule(item: Int, bucket: Int) {
        buckets[bucket].append(item)
        let newSum = bucketSums[bucket] + item
        bucketSums[bucket] = newSum
        if newSum > makespan {
            makespan = newSum
        }
    }
}


func findSolution(remaining: [Int], buckets: Solution, bestMakespan: Int) -> Solution? {
    var currentBest = bestMakespan
    var currentBestSolution: Solution? = nil
    if remaining.count == 0 && buckets.makespan <= currentBest {
        return buckets
    } 
    else if remaining.count == 0 || buckets.makespan > currentBest {
        return nil
    }

    for nextChoice in 0..<remaining.count {
        var choiceRemoved: [Int] = remaining
        choiceRemoved.remove(at: nextChoice)

        for bucket in 0..<buckets.buckets.count {
            let clone = Solution(clone: buckets)
            clone.schedule(item: remaining[nextChoice], bucket: bucket)
            guard let foundSolution = findSolution( remaining: choiceRemoved, buckets: clone, bestMakespan: currentBest) else {
                continue
            } 

            if foundSolution.makespan <= currentBest {
                currentBest = foundSolution.makespan
                currentBestSolution = foundSolution
            }
        }
    }

    return currentBestSolution
}

func findSolution(list: [Int], bucketCount: Int = 2) -> Solution {
    var buckets: [[Int]] = []
    for _ in 0..<bucketCount {
        buckets.append([])
    }

    return findSolution(remaining: list, buckets: Solution(buckets), bestMakespan: list.reduce(1, +))!
}




func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    let foundSolution = findSolution(list: list)
    return (foundSolution.buckets[0], foundSolution.buckets[1])
}


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

func tooSlowSplitList(_ list: [Int]) -> ([Int], [Int]) {
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


func heuristicSplitList(_ list: [Int]) -> ([Int], [Int]) {
    // Makespan optimal optimization for 2-partition problem
    // Bruteforcing with combinatorics is generally not a good idea, but worst case is n = 40

    // a "good enough" greedy solution is to sort the list descending then always add to the smaller side
    // Annnd it has a name (Longest Process Time First(LPT))
    var xs: [Int] = []
    var ys: [Int] = []
    var sumx = 0
    var sumy = 0
    for z in list.sorted(by: >) {
        if sumx > sumy {
            ys.append(z)
            sumy += z
        } else {
            xs.append(z)
            sumx += z
        }
    }
    return (xs, ys)
}