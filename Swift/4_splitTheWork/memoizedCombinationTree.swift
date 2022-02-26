struct SumGroup {
    let sum: Int
    let distance: Int
    let group: [Int]
}

/// Can I generalize the OptimizeDistance function?
///


var goal: Int = 0
var calculated = 0
var memoizedSumGroups = [[Int]:[SumGroup]]()
var bestDistance = 0
func GenerateSumGroupsOrAnswer(_ xs: [Int]) -> ([SumGroup], [Int]?) {
    // Handle all of the hypersimple cases
    let memo = memoizedSumGroups[xs]
    if memo != nil {
        return (memoizedSumGroups[xs]!, nil)
    }    
    
    calculated += 1
    var groups: [SumGroup] = []
    for i in 0..<xs.count {
        groups.append(SumGroup(sum: xs[i], distance: abs(goal - xs[i]) , group: [xs[i]]))
        if i < xs.count - 1 {
            let subResult = GenerateSumGroupsOrAnswer(Array(xs[i+1..<xs.count]))
            let possibleResult = subResult.1
            if possibleResult != nil {
                return ([], possibleResult!)
            }
            let subGroups = subResult.0

            for subGroup in subGroups {
                let sum = subGroup.sum + xs[i]
                let group = subGroup.group + [xs[i]]
                let distance = abs(goal - sum)
                if distance > subGroup.distance {
                    continue
                }
                let sumGroup = SumGroup(sum: sum, distance: distance, group: group)
                if sum < goal {
                    groups.append(sumGroup)
                }
            }
        }
    }

    memoizedSumGroups[xs] = groups
    return (groups, nil)
}

func GenerateSumGroupsTop(_ xs: [Int]) -> ([SumGroup], [Int]?) {
    // skip first element
    if xs.count > 2 {
        let ordered = Array(xs.sorted().reversed())
        goal = xs.reduce(0, +) / 2 - ordered[0]
        bestDistance = goal

        let ys = Array(ordered[1..<ordered.count])
        return GenerateSumGroupsOrAnswer(ys.reversed())
    }

    return ([], [xs[0]])

}

func splitlist(_ list: [Int]) -> ([Int], [Int]) {
  
    let groupResult = GenerateSumGroupsTop(list)
    let groups = groupResult.0
    let perfectResult = groupResult.1
    if perfectResult != nil {
        return (perfectResult!, [])
    }

    
    //for group in groups {
    //    print("\(group.sum) -- \(group.group)")
    //}

    print("\(list.count) -> \(groups.count): \(calculated)")
    
    return (list, [])
}
