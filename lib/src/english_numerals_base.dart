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
  final int number;

  Cardinal(this.number); //: number = BigInt.from(number);

  int get _zero => 0;
  int get _ten => 10;
  int get _twenty => 20;
  int get _hundred => 100;
  int get _thousand => 1000;
  int get _million => 1000000;

  String get enUs {
    // negatives
    if (number < _zero) {
      return "negative ${Cardinal(-number)}";
    }

    // basic numbers
    if (_baseNumbers.containsKey(number)) {
      return _baseNumbers[number]!;
    }

    // 20 to 99
    if (number >= _twenty && number < _hundred) {
      final tens = (number ~/ _ten) * _ten;
      return "${Cardinal(tens)}-${Cardinal(number - tens)}";
    }

    // perfect hundreds
    else if (number < _thousand) {
      final hundreds = number ~/ _hundred;
      final remainder = number % _hundred;
      if (remainder == _zero) {
        return "${Cardinal(hundreds)} hundred";
      } else {
        return "${Cardinal(hundreds * _hundred)} ${Cardinal(remainder)}";
      }
    }

    // perfect thousands
    if (number >= _thousand &&
        number < _million &&
        number % _thousand == _zero) {
      return "${Cardinal(number ~/ _thousand)} thousand";
    }

    throw UnimplementedError('number not implemented $number');
  }

  @override
  String toString() {
    return enUs;
  }
}
