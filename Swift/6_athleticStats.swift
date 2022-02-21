func stat(_ strg: String) -> String {
    // Let's over engineer this a little to better explore the language
    let timesInSeconds: [Int] = parse(strg).map { toSeconds($0) }
    let vrange: Time = fromSeconds(range(timesInSeconds))
    let vaverage: Time = fromSeconds(avg(timesInSeconds))
    let vmedian: Time = fromSeconds(median(timesInSeconds))
  
    return "Range: \(serialize(vrange)) Average: \(serialize(vaverage)) Median: \(serialize(vmedian))"
}

struct Time {
    var hour: Int
    var minute: Int
    var second: Int
}

func parse(_ str: String) -> [Time] {
    return str.split(separator: ",").map {
        let parts = $0.split(separator: "|")
        return Time(hour: Int(parts[0])!, minute: Int(parts[1])!, second: Int(parts[2])!)
    }
}

func serialize(_ time: Time) -> String {
    return "\(twoDigit(time.hour))|\(twoDigit(time.minute))|\(twoDigit(time.second))"
}

func twoDigit(_ num: Int) -> String {
    return String(format: "%02d", num)
}

func toSeconds (_ time: Time) -> Int {
    return time.hour * 3600 + time.minute * 60 + time.second
}

func fromSeconds(_ seconds: Int) -> Time {
    return Time(hour:seconds / 3600, minute: (seconds % 3600) / 60, second: seconds % 60)
}

func range(_ xs: [Int]) -> Int {
    return xs.max()! - xs.min()!
}

func avg(_ xs: [Int]) -> Int {
    return xs.reduce(0, +) / xs.count
}

func median(_ xs: [Int]) -> Int {
    let sorted = xs.sorted()
    let mid = sorted.count / 2
    if sorted.count % 2 == 0 {
        return (sorted[mid-1] + sorted[mid]) / 2
    } else {
        return sorted[mid]
    }
}