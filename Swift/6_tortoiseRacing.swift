func race(_ v1: Int, _ v2: Int, _ g: Int) -> [Int]? {
    // Wow this one seems badly explained...

    // v1 = velocity per hour of object 1
    // v2 = velocity per hour of object 2
    // g = gap between object 1 and 2 (where object 1 is in front of object 2)

    // result is an overly complicated array of [Hour, Minute, Second]
    // this is how long it will take for the two objects to collide

    guard v1 < v2 else {
        return nil
    }
    guard g > 0 else {
        return [0, 0, 0]
    }


    // 60 * 60 = 3600
    let relativeVelocityPerSecond = Double(v2 - v1)/3600.0 

    let secondsUntilMeet = Double(g) / relativeVelocityPerSecond

    let hours = Int(secondsUntilMeet / 3600.0)
    let minutes = Int(secondsUntilMeet / 60.0) % 60
    let seconds = Int(secondsUntilMeet) % 60

    return [hours, minutes, seconds]

}