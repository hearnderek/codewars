func primesUntil(_ x: Int) -> [Int] {
    // Sieve of Eratosthenes
    var primes: [Bool] = [Bool](repeating: true, count: x+1)

    for i in 2..<x {
        if primes[i] {
            for j in stride(from: i*i, to: x+1, by: i) {
                primes[j] = false
            }
        }
    }

    primes[0] = false
    primes[1] = false
    return primes.enumerated().filter { $0.element }.map { $0.offset }
}

func sumOfDivided(_ l: [Int]) -> [(Int, Int)] {
    if l.isEmpty {
        return []
    }
    
    let xs = l.sorted()
    let largest = xs.map { abs($0) }.max()!
    let primes = primesUntil(largest)
    print(primes)
    var results = [(Int, Int)]()
    for p in primes {
        let hasFactor = xs.filter { $0 % p == 0 }
        if hasFactor.count > 0 {
            results.append((p, hasFactor.reduce(0, +)))
        }
    }

    print(results)
    return results
}