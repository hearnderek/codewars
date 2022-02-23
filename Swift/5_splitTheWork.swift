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


func combinatoricGroups(appendTo: [Int], chooseFrom: [Int]) -> [[Int]] {
    if chooseFrom.count == 0 {
        return [[Int]()]
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

func firstHalfCombinatoricGroups(_ xs: [Int]) -> [[Int]] {
    if xs.count <= 1 {
        return [[Int]()]
    }

    // we are looking at one mirror half of the groups by only looking at the 1s tree
    var groups = combinatoricGroups(appendTo: [xs[0]], chooseFrom: Array(xs[1..<xs.count]))
    
    // this gets skipped in the above function
    groups.append([xs[0]])
    return groups
}



func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    totalSolutionAttempts = 0
    totalTreeSteps = 0

    if list.count > 22 {
        print("list too long")
        return (list, [])
    }

    // sum list
    let sumList = list.reduce(0, +) / 2

    // half of the possible groups
    let groups = firstHalfCombinatoricGroups(list)
    
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
        if let i = matchingGroup.firstIndex(of: x) {
            matchingGroup.remove(at: i)
        }
        else {
            print("error \(x) not found in \(matchingGroup)")
            print("BestGroup: \(bestGroup)")
            print("MatchingGroup: \(matchingGroup)")
        }
    }
    

    print("for n = \(list.count) -- solutionsTried = \(totalSolutionAttempts) -- treeSteps = \(totalTreeSteps)")
    return (bestGroup, matchingGroup)
}