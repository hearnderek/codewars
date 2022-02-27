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

    // These values will always be replaced
    var best: SumGroup = SumGroup(sum: 0, distance: goal + 1, group: []) 
    var bestIndex = -1

    //for i in stride(from: xs.count - 1, through: 0, by: -1) {
    for i in 0..<xs.count {
        if i != xs.count - 1 {
            let subResult = GenerateSumGroupsOrAnswer(Array(xs[i+1..<xs.count]), goal, &memo)
            let possibleResult = subResult.perfectResult
            if possibleResult != nil {
                return ([], possibleResult!)
            }
            let subGroups = subResult.groupsOrderedByDistance

            for subGroup in subGroups {
                let sum = subGroup.sum + xs[i]
                let distance = abs(goal - sum)

                if distance <= subGroup.distance {
                    if !seen.contains(distance) {
                        let sumGroup = SumGroup(
                            sum: sum, 
                            distance: distance, 
                            group: subGroup.group + [xs[i]])
                        seen.insert(distance)
                        groups.append(sumGroup)
                        if sumGroup.distance < best.distance {
                            best = sumGroup
                            bestIndex = groups.count - 1
                        }
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
            if sumGroup.distance < best.distance {
                best = sumGroup
                bestIndex = groups.count - 1
            }
        }
    }
    
    // Keeps optimal answer on top
    if groups.count > 1 {
        groups[bestIndex] = groups[0]
        groups[0] = best
    }

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


    // print("returning trival result: \([xs[0]])")
    return  [xs[0]]

}

func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    if list.count == 0 || list.count > 40 {
        print("list \(list.count): \(list)")
        return ([], [])
    }

    let zeros = list.filter { $0 == 0 }
    let nonzeros = list.filter { $0 != 0 }

    // find optimal group
    let optimalGroup = FindOptimalGroup(nonzeros)
    // print("optimal group: \(optimalGroup.reduce(0, +)) -- \(optimalGroup)")

    var matchingGroup = nonzeros
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
    matchingGroup += zeros

    // print("goal \(list.reduce(0, +) / 2)")
    print("n:\(list.count) -- optimal group: \(optimalGroup.reduce(0, +)) - vs - matchingGroup: \(matchingGroup.reduce(0, +))")

    return (optimalGroup, matchingGroup)
}
