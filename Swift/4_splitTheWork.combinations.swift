var totalSolutionAttempts = 0
var totalTreeSteps = 0



func factorial(_ n: Int) -> Int {
    return n == 0 ? 1 : n * factorial(n - 1)
}

func combinatoricGroups(appendTo: [Int], chooseFrom: [Int]) -> [[Int]] {
    if chooseFrom.count == 0 {
        return []
    }

    totalTreeSteps+=1
    var results: [[Int]] = []

    for (i, x) in chooseFrom.enumerated() {
        // concat x with appendTo
        var newAppendTo: [Int] = []
        for y in appendTo {
            newAppendTo.append(y)
        }
        newAppendTo.append(x)
        totalSolutionAttempts+=1
        results.append(newAppendTo)


        var remaining: [Int] = []
        for y in chooseFrom[i+1..<chooseFrom.count] {
            remaining.append(y)
        }

        let subResults = combinatoricGroups(appendTo: newAppendTo, chooseFrom: remaining)
        results.append(contentsOf: subResults)
    }

    return results
}

func combinatoricGroups(_ xs: [Int]) -> [[Int]] {
    return combinatoricGroups(appendTo: [], chooseFrom: xs)
}



func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    totalSolutionAttempts = 0
    totalTreeSteps = 0


    // sum list
    let sumList = list.reduce(0, +) / 2

    // Generate all possible groups
    let groups = combinatoricGroups(list)
    
    // Find optimal group
    var bestGroup: [Int] = []
    var bestDist: Int = sumList
    for group in groups {
        let sumGroup = group.reduce(0, +)
        let distGroup = abs(sumGroup - sumList)
        if distGroup < bestDist {
            bestGroup = group
            bestDist = distGroup
        }
        if distGroup == 0 {
            break
        }
    }

    // build matching group
    var matchingGroup = list
    for x in bestGroup {
        // remove first instance of x
        matchingGroup.remove(at: matchingGroup.firstIndex(of: x)!)
    }
    
    //print("n^2 = \(list.count * list.count) -- 2^n = \(pow(2, (Double(list.count)))) -- n! = \(factorial(list.count)) -- n^n = \(pow(Double(list.count), Double(list.count)))")
    print("for n = \(list.count) -- solutionsTried = \(totalSolutionAttempts) -- treeSteps = \(totalTreeSteps)")
    return (bestGroup, matchingGroup)
}
