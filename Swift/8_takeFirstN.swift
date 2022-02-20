func take(_ arr: [Int], _ n: Int) -> [Int] {
    
    var rets:[Int] = []
    
    var i = 0
    while i < arr.count && i < n {
        rets.append(arr[i])
        i+=1
    }
    
    return rets
}

/*
Things learned from my for loop:

1. Haskell style array declarations
2. Arrays have .count and .append()
3. empty collections need to have their type specified


Cool idea from other submissions:
1. Array(arr.prefix(n))
2. for i in 0..<n {
3. Array(arr[0..<n])
4. guard n > 0 else { return [] }
5. arr.dropLast(arr.count - n)
6. arr.isEmpty
7. for (i, o) in arr.enumerated() {

New questions:
1. What is the difference between var and let?

*/