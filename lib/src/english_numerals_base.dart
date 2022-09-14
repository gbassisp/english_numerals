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
  BigInt get _million => BigInt.from(1000000);
  int toInt() => n.toInt();
  bool get isInt => n.isValidInt;

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
    if (n >= _thousand && n < _million && n % _thousand == _zero) {
      return "${Cardinal(n ~/ _thousand)} thousand";
    }

    throw UnimplementedError('n not implemented $n');
  }

  @override
  String toString() {
    return enUs;
  }
}
