func firstNonConsecutive (_ arr: [Int]) -> Int? {
    guard arr.count > 2 else {
        return nil
    }

    for i in 0..<arr.count - 1 {
        if arr[i] + 1 != arr[i+1] {
            return arr[i+1]
        }
    }
    
    return nil
}