func quarter(of month: Int) -> Int {
  // Honestly I play some clever golf here, but honestly this is simple and fast for a decent compiler.
  // Worth noting that I'm not sure how far the swift compiler goes with optimization.
  if month <= 3 {
    return 1
  } else if month <= 6 {
    return 2
  } else if month <= 9 {
    return 3
  } else {
    return 4
  }
}
