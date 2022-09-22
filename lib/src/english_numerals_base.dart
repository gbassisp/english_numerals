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
  final BigInt _n;

  Cardinal(dynamic number)
      : _n = number is BigInt
            ? number
            : number is int
                ? BigInt.from(number)
                : number is String
                    ? BigInt.parse(number)
                    : BigInt.from(number);

  BigInt get _zero => BigInt.zero;
  BigInt get _ten => BigInt.from(10);
  BigInt get _twenty => BigInt.from(20);
  BigInt get _hundred => BigInt.from(100);
  BigInt get _thousand => BigInt.from(1000);
  int _toInt() => _n.toInt();
  bool get _isInt => _n.isValidInt;

  /// returns the British notation of a cardinal integer
  String get enUk {
    if (_n > _hundred && _n < _thousand) {
      final hundreds = _n ~/ _hundred;
      final remainder = _n % _hundred;
      if (remainder != _zero) {
        return "${Cardinal(hundreds * _hundred)} and ${Cardinal(remainder)}";
      }
    }

    return enUs;
  }

  /// returns the American notation of a cardinal integer
  String get enUs {
    // negatives
    if (_n < _zero) {
      return "negative ${Cardinal(-_n)}";
    }

    // basic numbers
    if (_isInt && _baseNumbers.containsKey(_toInt())) {
      return _baseNumbers[_toInt()]!;
    }

    // 20 to 99
    if (_n >= _twenty && _n < _hundred) {
      final tens = (_n ~/ _ten) * _ten;
      return "${Cardinal(tens)}-${Cardinal(_n - tens)}";
    }

    // perfect hundreds
    else if (_n < _thousand) {
      final hundreds = _n ~/ _hundred;
      final remainder = _n % _hundred;
      if (remainder == _zero) {
        return "${Cardinal(hundreds)} hundred";
      } else {
        return "${Cardinal(hundreds * _hundred)} ${Cardinal(remainder)}";
      }
    }

    // perfect thousands
    if (_n >= _thousand) {
      BigInt magnitude = _thousand;
      BigInt remainder = _thousand;
      for (String s in _suffixes) {
        remainder = _n % magnitude;
        if (_n < magnitude * _thousand) {
          String text = "${Cardinal(_n ~/ magnitude)} $s";
          if (remainder != _zero) {
            text += " ${Cardinal(remainder)}";
          }
          return text;
        }
        magnitude *= _thousand;
      }
    }

    throw UnimplementedError('n not implemented $_n');
  }

  @override
  String toString() {
    return enUs;
  }
}
