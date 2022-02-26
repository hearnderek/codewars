struct SumGroup {
    let sum: Int
    let distance: Int
    let group: [Int]
}

/// Can I generalize the OptimizeDistance function?
///

var goal: Int = 0
var calculated = 0
var calls = 0
var memoizedSumGroups = [[Int]:[SumGroup]]()
var bestDistance = 0

/// The tuple represents (the flattened tree, the answer)
func GenerateSumGroupsOrAnswer(_ xs: [Int]) -> ([SumGroup], [Int]?) {
    calls += 1
    // Handle all of the hypersimple cases
    let memo = memoizedSumGroups[xs]
    if memo != nil {
        return (memoizedSumGroups[xs]!, nil)
    }    
    
    calculated += 1
    var 
    var groups: [SumGroup] = []
    for i in stride(from: xs.count - 1, through: 0, by: -1) {
    //for i in 0..<xs.count {
        groups.append(SumGroup(
            sum: xs[i], 
            distance: abs(goal - xs[i]) , 
            group: [xs[i]]))

        if i < xs.count - 1 {
            let subResult = GenerateSumGroupsOrAnswer(Array(xs[i+1..<xs.count]))
            let possibleResult = subResult.1
            if possibleResult != nil {
                return ([], possibleResult!)
            }
            let subGroups = subResult.0

            for subGroup in subGroups {
                let sum = subGroup.sum + xs[i]
                let distance = abs(goal - sum)
                if sum > goal {

                }

                if distance <= subGroup.distance && sum < goal {
                    let sumGroup = SumGroup(
                        sum: sum, 
                        distance: distance, 
                        group: subGroup.group + [xs[i]])
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

    print("\(list.count) -> \(groups.count): \(calculated)/\(calls)")
    
    return (list, [])
}
