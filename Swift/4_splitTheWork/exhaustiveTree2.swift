var totalSolutionAttempts = 0
var totalTreeSteps = 0

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

    func getBucketIndexesWithDistinctSums() -> [Int] {
        var sumDict: [Int: Int] = [:]
        for (index, sum) in bucketSums.enumerated() {
            if sumDict[sum] == nil {
                sumDict[sum] = index
            }
        }
        return sumDict.keys.map {sumDict[$0]!}
    }
}

/// 
/// 
/// - Parameter remaining: is a presorted array
func findSolution(remaining: [Int], buckets: Solution, bestMakespan: Int) -> Solution? {
    totalTreeSteps+=1

    var currentBest = bestMakespan
    var currentBestSolution: Solution? = nil
    if remaining.count == 0 {
        totalSolutionAttempts += 1
        
        if buckets.makespan < currentBest {
            return buckets
        } 
        else {
            return nil
        }
    }
    
    if buckets.makespan >= currentBest {
        return nil
    }


    var lastChoice: Int = -1 // an impossible value
    for nextChoice in 0..<remaining.count {
        // Path reduction optimization: skip duplicates
        // if there are choices with the same size it is not necessary to try them all
        if lastChoice == remaining[nextChoice] {
            continue
        }
        lastChoice = remaining[nextChoice]

        var choiceRemoved: [Int] = remaining
        choiceRemoved.remove(at: nextChoice)

        // Path reduction optimization 2: getBucketIndexesWithDistinctSums
        // buckets any bucket that is of the same length (for example our start state where all are zero)
        // can all be considered as an equal choice.
        for bucket in buckets.getBucketIndexesWithDistinctSums() {
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

    // Note: Presorting the list is a requirement for the overloaded function
    // bestMakespan is worse (larger) than optimized worst case
    return findSolution(remaining: list.sorted(), buckets: Solution(buckets), bestMakespan: list.reduce(1, +))!
}


func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    let foundSolution = findSolution(list: list)

    
    print("for n = \(list.count) -- solutionsTried = \(totalSolutionAttempts) -- treeSteps = \(totalTreeSteps)")
    return (foundSolution.buckets[0], foundSolution.buckets[1])
}
