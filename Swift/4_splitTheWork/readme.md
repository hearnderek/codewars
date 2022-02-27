This has been a much more difficult problem than what I anticipated.

Mostly I picked it up because I recently had this situation popup at work, where a crude heuristic was more than enough, but I wanted to know what it would take to get an optimal solution. And of course it's an NP-Hard?Complete? problem.

Now I'm going through and optimizing my brute force method.

# After Successful submission

Looks like I have overcomplicated the problem... 

Looking at the other solutions mine is by far the longest in terms of LoC.



``` swift
/// This is a very compact and fast implementation I found in the solutions section.
/// There were no comments, I have added them myself as an exercise in learning how this funciton works.
/// This is limited by size of values it can handle.
/// POSSIBLE IMPROVEMENT: Use a dictionary instead of an array to save on space
func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    // handle 0 case
    guard list != [] else { return ([], []) }

    // possibly perfect goal
    let target = list.reduce(0, +) / 2
    
    // order decending
    let reversedList = list.sorted(by: { $0 > $1 })
    
    // Handling case where a single massive value is larger than the average
    if reversedList[0] >= target {
        return ([reversedList[0]], Array(reversedList[1..<list.endIndex]))
    }



    /// This is where the magic happens
    /// We are searching for the smaller partition, as 'options' only support a max of target
    /// 
    /// First will fill up option[0 + first]
    /// Second will fill up option[0 + first + second] and option[0 + second]
    /// This way you fill up a path to the answer.
    /// 
    /// Complexity is roughly (xs.count * sum(xs) / 2)
    
    // Creating an array with every number inculding our target
    var options = Array<Array<Int>?>(repeating: nil, count: target + 1)
    // This is our base case that every number can build from
    options[0] = []
    for item in reversedList {
        for pos in (0...(target - item)).reversed() {
            // if「options[pos] != null」 we can build off of this path
            // if「options[pos + item] != nil」we have already found a combination to this value
            if let currentPosOption = options[pos], options[pos + item] == nil {
                options[pos + item] = currentPosOption + [item]
            }
        }
    }

    /// Just take the answer 

    let best = (options.filter({ $0 != nil }).last ?? [])!
    // take all of the elements not in best and put them in rest
    var rest: [Int] = []
    var bestPos = 0
    for item in list {
        if bestPos < best.count && item == best[bestPos] {
            bestPos += 1
        }
        else {
            rest.append(item)
        }
    }

    return (best, rest)
}

```