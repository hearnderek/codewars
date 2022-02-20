/*
Given a non-empty array of integers, return the result of multiplying the values together in order. Example:
[1, 2, 3, 4] => 1 * 2 * 3 * 4 = 24
*/
func grow(_ arr: [Int]) -> Int {
    var i:Int = 1
    for x in arr {
        i*=x
    }
    return i
}

/*
Ideas from other submissions:
1. arr.reduce(1,*)
2. arr.forEach { int *= $0 }
3. return arr.reduce(1, { x, y in return x*y })
4. for i in 0..<arr.count{
*/