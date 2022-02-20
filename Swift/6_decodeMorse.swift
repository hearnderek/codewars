func decodeMorse(_ morseCode: String) -> String {
    // create dictionary filled with all morse code entries
    var morseCodeDict: [String: String] = [
        ".-": "A",
        "-...": "B",
        "-.-.": "C",
        "-..": "D",
        ".": "E",
        "..-.": "F",
        "--.": "G",
        "....": "H",
        "..": "I",
        ".---": "J",
        "-.-": "K",
        ".-..": "L",
        "--": "M",
        "-.": "N",
        "---": "O",
        ".--.": "P",
        "--.-": "Q",
        ".-.": "R",
        "...": "S",
        "-": "T",
        "..-": "U",
        "...-": "V",
        ".--": "W",
        "-..-": "X",
        "-.--": "Y",
        "--..": "Z",
        "-----": "0",
        ".----": "1",
        "..---": "2",
        "...--": "3",
        "....-": "4",
        ".....": "5",
        "-....": "6",
        "--...": "7",
        "---..": "8",
        "----.": "9",
        "-.-.--": "!",
        ".-.-.-": ".",
        "--..--": ",",
        "..--..": "?",
        "-...-": "=",
        "-..-.": ";",
        ".--.-.": "@"]

    morseCodeDict["...---..."] = "SOS"


    return morseCode
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: "   ")
        .map { $0.components(separatedBy: " ")
                .map { morseCodeDict[$0] ?? "" }
                .joined()
        }
        .joined(separator: " ")
        
}