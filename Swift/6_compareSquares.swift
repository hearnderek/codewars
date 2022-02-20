func comp(_ a: [Int], _ b: [Int]) -> Bool {
    guard a.count == b.count else {
        return false
    }

    // NOTE swift doesn't support the pow operator ^ 
    let sortedA = a.map { $0 * $0 }.sorted()
    let sortedB = b.sorted()
    for i in 0..<a.count {
        if sortedA[i] != sortedB[i] {
            return false
        }
    }

    return true
}