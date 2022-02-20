// codewars requires this function name to be misspelled... 
func great(_ name: String, _ owner: String) -> String {
  guard name != owner else {
      return greet_boss()
  }

  return "Hello guest"
}

func greet_boss() -> String {
    return "Hello boss"
}

print(great("Daniel", "Daniel"))
print(great("Greg", "Daniel"))
print(great("Bill", "Daniel"))
print(great("Mary", "Mary") )
print(great("Kate", "Bob"))