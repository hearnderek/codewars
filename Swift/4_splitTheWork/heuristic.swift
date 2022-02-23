
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
}