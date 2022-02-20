func sumOfTwoSmallestIntegersIn(_ array: [Int]) -> Int {
    var fstSmallest: Int = Int.max
    var sndSmallest: Int = Int.max

    for i in array {
        if i < fstSmallest {
            sndSmallest = fstSmallest
            fstSmallest = i
        } else if i < sndSmallest {
            sndSmallest = i
        }
    }

    return fstSmallest + sndSmallest
}