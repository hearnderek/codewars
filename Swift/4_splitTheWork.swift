func splitlist(_ list: [Int]) -> ([Int], [Int]) {
    // Makespan optimal optimization for 2-partition problem
    // Bruteforcing with combinatorics is generally not a good idea, but worst case is n = 40


    // a "good enough" greedy solution is to sort the list descending then always add to the smaller side
    // Annnd it has a name (Longest Process Time First(LPT))
    var xs: [Int] = []
    var ys: [Int] = []
    var sumx = 0
    var sumy = 0
    for z in list.sorted(by: >) {
        if sumx > sumy {
            ys.append(z)
            sumy += z
        } else {
            xs.append(z)
            sumx += z
        }
    }
    return (xs, ys)

    // what if we tried to make an algorithm that aims for sum(*)/2?


    // Bruteforce:
    // Try every combination of two lists



    // Doing some research on the topic...
    // https://en.wikipedia.org/wiki/Fair_division_among_groups
    // https://en.wikipedia.org/wiki/Job-shop_scheduling

    return (list, [])
}

