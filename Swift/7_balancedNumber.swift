func balancedNumber(_ number: Int) -> String {
    let str = String(number)

    guard str.count > 2 else {
        return "Balanced"
    }
    
    let middle = str.count & 1 == 1 ? str.count / 2 : str.count / 2 - 1 
    let fst = str.prefix(middle).map { Int(String($0))! }.reduce(0,+)
    let snd = str.suffix(middle).map { Int(String($0))! }.reduce(0,+)
    
    return fst == snd ? "Balanced" : "Not Balanced"
}