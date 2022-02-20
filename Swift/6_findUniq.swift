func findUniq(_ arr: [Int]) -> Int {
    let singles = [Int]()
    let multi:Set<Int> = Set()

    for x in arr {
        if multi.contains(x) {
            // nth time we see this number
            continue
        } 
        
        if let index = singles.firstIndex(of: x) {
            // second time we've seen this number
            singles.remove(at: index)
            multi.insert(x)
        } else {
            // first time we've seen this number
            singles.append(x)
        }
    }

    // Hard assumption that there will always be a single unique number
    return singles.first!
}