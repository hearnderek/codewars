struct SumGroup {
    let sum: Int
    let distance: Int
    let group: [Int]
}

func GenerateSumGroupsOrAnswer(_ xs: [Int],_ goal: Int,_ memo: inout [[Int]:[SumGroup]]) -> (groupsOrderedByDistance: [SumGroup], perfectResult: [Int]?) {
    
    // Do we already have the memoized result?
    let memoRet = memo[xs]
    if memoRet != nil {
        return (memo[xs]!, nil)
    }    
    
    // hashset
    var seen = Set<Int>()
    var groups: [SumGroup] = []

    //for i in stride(from: xs.count - 1, through: 0, by: -1) {
    for i in 0..<xs.count {
        if i < xs.count - 1 {
            let subResult = GenerateSumGroupsOrAnswer(Array(xs[i+1..<xs.count]), goal, &memo)
            let possibleResult = subResult.1
            if possibleResult != nil {
                return ([], possibleResult!)
            }
            let subGroups = subResult.0

            for subGroup in subGroups {
                let sum = subGroup.sum + xs[i]
                let distance = abs(goal - sum)

                if distance <= subGroup.distance {
                    let sumGroup = SumGroup(
                        sum: sum, 
                        distance: distance, 
                        group: subGroup.group + [xs[i]])
                    if !seen.contains(distance) {
                        seen.insert(distance)
                        groups.append(sumGroup)
                    }
                }
            }
        }

        let distance = abs(goal - xs[i])
        if !seen.contains(distance) {
            seen.insert(distance)
            let sumGroup = SumGroup(
                sum: xs[i], 
                distance: distance, 
                group: [xs[i]])
            groups.append(sumGroup)
        }
    }
    
    // Keeps optimal answer on top
    groups.sort { $0.distance < $1.distance }
    memo[xs] = groups
    return (groups, nil)
}

func FindOptimalGroup(_ xs: [Int]) -> [Int] {
    // skip first element
    if xs.count > 2 {
        let goal = xs.reduce(0, +) / 2
        var memo = [[Int]:[SumGroup]]()
        let result = GenerateSumGroupsOrAnswer(xs, goal, &memo)
        guard let perfectResult = result.perfectResult else {
            return result.groupsOrderedByDistance[0].group
        }
        return perfectResult
    }


    print("returning trival result: \([xs[0]])")
    return  [xs[0]]

}

func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    if list.count == 0 {
        return ([], [])
    }

    // find optimal group
    let optimalGroup = FindOptimalGroup(list)
    print("optimal group: \(optimalGroup.reduce(0, +)) -- \(optimalGroup)")

    var matchingGroup = list
    for x in optimalGroup {
        // remove first instance of x
        if let i = matchingGroup.firstIndex(of: x) {
            matchingGroup.remove(at: i)
        }
        else {
            print("error \(x) not found in \(matchingGroup)")
            print("BestGroup: \(optimalGroup)")
            print("MatchingGroup: \(matchingGroup)")
        }
    }

    print("goal \(list.reduce(0, +) / 2)")
    print("optimal group: \(optimalGroup.reduce(0, +)) - vs - matchingGroup: \(matchingGroup.reduce(0, +))")

    return (optimalGroup, matchingGroup)
}
