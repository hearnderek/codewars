
/*
accum("abcd") -> "A-Bb-Ccc-Dddd"
accum("RqaEzty") -> "R-Qq-Aaa-Eeee-Zzzzz-Tttttt-Yyyyyyy"
accum("cwAt") -> "C-Ww-Aaa-Tttt"
The parameter of accum is a string which includes only letters from a..z and A..Z.
*/

func accum(_ s: String) -> String {
  var toJoin = [String]()
  for (i, c) in s.lowercased().enumerated() {
    toJoin.append(
      String(c).uppercased() + 
      String(repeating: String(c), count: i)
      )
  }

  return toJoin.joined(separator: "-")

}