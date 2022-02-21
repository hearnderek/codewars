func matrixMultiplication(_ a:[[Int]], _ b:[[Int]]) -> [[Int]] {
    let aRows = a.count
    let aCols = a[0].count
    // let bRows = b.count
    let bCols = b[0].count
    var result = [[Int]]()

    for i in 0..<aRows {
        result.append([Int]())
        for j in 0..<bCols {
            result[i].append(0)
            for k in 0..<aCols {
                result[i][j] += a[i][k] * b[k][j]
            }
        }
    }
    return result
}