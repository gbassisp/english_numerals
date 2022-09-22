// TODO: Put public facing types in this file.

const _baseNumbers = <int, String>{
  10: "ten",
  0: "zero",
  1: "one",
  11: "eleven",
  2: "two",
  12: "twelve",
  20: "twenty",
  3: "three",
  13: "thirteen",
  30: "thirty",
  4: "four",
  14: "fourteen",
  40: "forty",
  5: "five",
  15: "fifteen",
  50: "fifty",
  6: "six",
  16: "sixteen",
  60: "sixty",
  7: "seven",
  17: "seventeen",
  70: "seventy",
  8: "eight",
  18: "eighteen",
  80: "eighty",
  9: "nine",
  19: "nineteen",
  90: "ninety",
};

const _suffixes = [
  "thousand",
  "million",
  "billion",
  "trillion",
  "quadrillion",
  "quintillion",
  "sextillion",
  "septillion",
  "octillion",
  "nonillion",
  "decillion",
  "undecillion",
  "duodecillion",
  "tredecillion",
  "quattuordecillion",
  "quindecillion",
  "sexdecillion",
  "septendecillion",
  "octodecillion",
  "novemdecillion",
  "vigintillion",
];

/// A class that takes an integer number on its constructor and represents its
/// cardinal form on toString() method. Defaults to US notation, but enUs and
/// enUk getters can be used to specify locale.
class Cardinal {
  final BigInt n;

  Cardinal(dynamic number)
      : n = number is BigInt
            ? number
            : number is int
                ? BigInt.from(number)
                : number is String
                    ? BigInt.from(int.parse(number))
                    : BigInt.from(number);

  BigInt get _zero => BigInt.zero;
  BigInt get _ten => BigInt.from(10);
  BigInt get _twenty => BigInt.from(20);
  BigInt get _hundred => BigInt.from(100);
  BigInt get _thousand => BigInt.from(1000);
  int toInt() => n.toInt();
  bool get isInt => n.isValidInt;

  /// returns the British notation of a cardinal integer
  String get enUk {
    if (n > _hundred && n < _thousand) {
      final hundreds = n ~/ _hundred;
      final remainder = n % _hundred;
      if (remainder != _zero) {
        return "${Cardinal(hundreds * _hundred)} and ${Cardinal(remainder)}";
      }
    }

    return enUs;
  }

  /// returns the American notation of a cardinal integer
  String get enUs {
    // negatives
    if (n < _zero) {
      return "negative ${Cardinal(-n)}";
    }

    // basic numbers
    if (isInt && _baseNumbers.containsKey(toInt())) {
      return _baseNumbers[toInt()]!;
    }

    // 20 to 99
    if (n >= _twenty && n < _hundred) {
      final tens = (n ~/ _ten) * _ten;
      return "${Cardinal(tens)}-${Cardinal(n - tens)}";
    }

    // perfect hundreds
    else if (n < _thousand) {
      final hundreds = n ~/ _hundred;
      final remainder = n % _hundred;
      if (remainder == _zero) {
        return "${Cardinal(hundreds)} hundred";
      } else {
        return "${Cardinal(hundreds * _hundred)} ${Cardinal(remainder)}";
      }
    }

    // perfect thousands
    if (n >= _thousand) {
      BigInt magnitude = _thousand;
      BigInt remainder = _thousand;
      for (String s in _suffixes) {
        remainder = n % magnitude;
        if (n < magnitude * _thousand) {
          String text = "${Cardinal(n ~/ magnitude)} $s";
          if (remainder != _zero) {
            text += " ${Cardinal(remainder)}";
          }
          return text;
        }
        magnitude *= _thousand;
      }
      return "${Cardinal(n ~/ _thousand)} thousand";
    }

    throw UnimplementedError('n not implemented $n');
  }

  @override
  String toString() {
    return enUs;
  }
}
