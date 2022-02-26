var totalSolutionAttempts = 0
var totalTreeSteps = 0



func factorial(_ n: Int) -> Int {
    return n == 0 ? 1 : n * factorial(n - 1)
}

// [1], [2,3,4]
// [1,2], [3,4]
// [1,2,3], [4]
// [1,2,3,4], []
// [1,2,4], [3]
// [1,3], [2,4]
// [1,3,4], [2]
// [1,4], [2,3]

/// Issues:
///
/// Need to optimize for worst case...
/// 
/// O(2^(n+1))
///
/// Plan:
/// 1. Start to Explore tree from largest child (done in bestCombinatoricGroup())
///    - using a single child node as our head splits the tree in half.
///    - using the largest child will get us to the goal value in less steps
/// 2. Pass the sum down the tree to reduce summation cycles
/// 3. Skipping when previous value is the same as current value (will produce duplicate groups)
/// 4. Add in memoization?
///    - 
func bestCombinatoricGroup(appendTo: [Int], chooseFrom: [Int], lastSum: Int, lastDistance: Int, goal: Int) -> (group: [Int], dist: Int)? {
    if chooseFrom.count == 0 {
        return nil
    }

    totalTreeSteps+=1
    var bestDist = lastDistance
    var best: [Int]? = nil


    for (i, x) in chooseFrom.enumerated() {
        totalSolutionAttempts+=1
        let newSum = lastSum + x
        let newDist = abs(newSum - goal)
        if newDist >= lastDistance || (i > 1 && x == chooseFrom[i-1]) {
            continue
        }        

        // concat x with appendTo
        var newAppendTo: [Int] = []
        for y in appendTo {
            newAppendTo.append(y)
        }
        newAppendTo.append(x)

        if newDist < bestDist {
            bestDist = newDist
            best = newAppendTo
        }
        
        var remaining: [Int] = []
        for y in chooseFrom[i+1..<chooseFrom.count] {
            remaining.append(y)
        }

        // If something was returned we found an improved value
        guard let subResult = bestCombinatoricGroup(
                appendTo: newAppendTo, 
                chooseFrom: remaining,
                lastSum: newSum,
                lastDistance: newDist,
                goal: goal) else {
            continue
        }

        if subResult.dist < bestDist {
            best = subResult.group
            bestDist = subResult.dist
        }
    }

    guard let bestResult = best else {
        return nil
    }
    return (bestResult, bestDist)
}

func bestCombinatoricGroup(_ xs: [Int]) -> [Int] {
    if xs.count <= 1 {
        return [Int]()
    }
    let goal = xs.reduce(0, +) / 2

    // we are looking at one mirror half of the groups by only looking at the 1s tree
    guard let result = bestCombinatoricGroup(
        appendTo: [xs[0]], 
        chooseFrom: Array(xs[1..<xs.count]), 
        lastSum: xs[0], 
        lastDistance: abs(xs[0] - goal), 
        goal: goal
    ) else {
        // We didn't find a solution -- which happens when the initial appendTo is the best case
        return [xs[0]]
    }
    
    // this gets skipped in the above function
    
    return result.group
}



func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    totalSolutionAttempts = 0
    totalTreeSteps = 0

    // if list.count > 22 {
    //     print("list too long")
    //     print(list)
    //     return (list, [])
    // }

    print("Find optimal group")
    // Find optimal group
    let bestGroup = bestCombinatoricGroup(list.sorted().reversed())
    
    print("build matching group")
    // build matching group
    var matchingGroup = list
    for x in bestGroup {
        // remove first instance of x
        if let i = matchingGroup.firstIndex(of: x) {
            matchingGroup.remove(at: i)
        }
        else {
            print("error \(x) not found in \(matchingGroup)")
            print("BestGroup: \(bestGroup)")
            print("MatchingGroup: \(matchingGroup)")
        }
    }
    

    //print("n^2 = \(list.count * list.count) -- 2^n = \(pow(2, (Double(list.count)))) -- n! = \(factorial(list.count)) -- n^n = \(pow(Double(list.count), Double(list.count)))")
    print("for n = \(list.count) -- solutionsTried = \(totalSolutionAttempts) -- treeSteps = \(totalTreeSteps)")
    print("return")
    print("")
    return (bestGroup, matchingGroup)
}