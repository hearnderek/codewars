class RomanNumerals(object):
    _lookup = {
        'M': 1000,
        'CM': 900,
        'D': 500,
        'CD': 400,
        'C': 100,
        'XC': 90,
        'L': 50,
        'XL': 40,
        'X': 10,
        'IX': 9,
        'V': 5,
        'IV': 4,
        'I': 1
    }

    @staticmethod
    def to_roman(x):
        l = RomanNumerals._lookup.items()
        ret = ''
        for c, v in l:
            while x >= v:
                x -= v
                ret += c
        return ret

    @staticmethod
    def from_roman(s):
        x, i = 0, 0
        while i < len(s):
            td = s[i:i + 2]
            if td in RomanNumerals._lookup:
                x += RomanNumerals._lookup[td]
                i += 2
            else:
                x += RomanNumerals._lookup[s[i]]
                i += 1

        return x