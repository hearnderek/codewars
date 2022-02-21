func persistence(for num: Int) -> Int {
    guard num >= 10 else {
        return 0
    }
    
    return countedPersistence(num)
}

func countedPersistence(_ num: Int, _ count: Int = 1) -> Int {
    // standard functional recursive approach
    let product = split(num).reduce(1, *)
    print(count, product)
    
    guard product >= 10 else {
        return count
    }
    
    return countedPersistence(product, count + 1)
}

func split(_ num: Int) -> [Int] {
    // compactMap let's us skip writing the !
    // But personally I think the ! is much more readable
    return String(num).map { Int(String($0))! }
}