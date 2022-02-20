func find_missing(l:[Int]) -> Int {
    // Hard assumption that we will have at least 3 elements
    let c = (l.last! - l.first!) / (l.count)
  
    for i in 0..<l.count - 1 {
        let diff = l[i+1] - l[i]
        if diff != c {
            return l[i] + c
        }
    }
  
  return c // this will never happen
}