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
func GenerateSumGroupsOrAnswer(_ xs: [Int]) -> (groupsOrderedByDistance: [SumGroup], perfectResult: [Int]?) {
    calls += 1
    // Handle all of the hypersimple cases
    let memo = memoizedSumGroups[xs]
    if memo != nil {
        return (memoizedSumGroups[xs]!, nil)
    }    
    
    calculated += 1
    var groups: [SumGroup] = []
    var distanceDict = [Int:SumGroup]()

    //for i in stride(from: xs.count - 1, through: 0, by: -1) {
    for i in 0..<xs.count {
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

                if distance <= subGroup.distance {
                    let sumGroup = SumGroup(
                        sum: sum, 
                        distance: distance, 
                        group: subGroup.group + [xs[i]])
                    if distanceDict[distance] == nil {
                        distanceDict[distance] = sumGroup
                        groups.append(sumGroup)
                    }
                }
            }
        }

        let distance = abs(goal - xs[i])
        if distanceDict[distance] == nil {
            let sumGroup = SumGroup(
                sum: xs[i], 
                distance: distance, 
                group: [xs[i]])
            groups.append(sumGroup)
            distanceDict[distance] = sumGroup
        }
    }
    
    groups.sort { $0.distance < $1.distance }
    

    


    memoizedSumGroups[xs] = groups
    return (groups, nil)
}

func FindOptimalGroup(_ xs: [Int]) -> [Int] {
    // skip first element
    if xs.count > 2 {
        let ordered = Array(xs.sorted().reversed())
        let largestValue = ordered[0]
        goal = xs.reduce(0, +) / 2 - largestValue
        bestDistance = goal

        let ys = Array(ordered[1..<ordered.count])
        let result = GenerateSumGroupsOrAnswer(ys)
        guard let perfectResult = result.perfectResult else {
            let optimalGroup = [largestValue] + result.groupsOrderedByDistance[0].group
            return optimalGroup
        }
        return perfectResult

    }


    print("returning trival result: \([xs[0]])")
    return  [xs[0]]

}

func splitlist(_ list: [Int]) -> ([Int], [Int]) {
  
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
    print("n=\(list.count): \(calculated)/\(calls)")

    return (optimalGroup, matchingGroup)
}
