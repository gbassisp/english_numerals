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

  Cardinal(this.number);

  String get enUs {
    // negatives
    if (number < 0) {
      return "negative ${Cardinal(-number)}";
    }

    // basic numbers
    if (_baseNumbers.containsKey(number)) {
      return _baseNumbers[number]!;
    }

    // 20 to 99
    if (number >= 20 && number < 100) {
      final tens = (number ~/ 10) * 10;
      return "${Cardinal(tens)}-${Cardinal(number - tens)}";
    }

    // perfect hundreds
    else if (number < 1000) {
      final hundreds = number ~/ 100;
      final remainder = number % 100;
      if (remainder == 0) {
        return "${Cardinal(hundreds)} hundred";
      } else {
        return "${Cardinal(hundreds * 100)} ${Cardinal(remainder)}";
      }
    }

    // perfect thousands
    if (number >= 1000 && number < 1000000 && number % 1000 == 0) {
      return "${Cardinal(number ~/ 1000)} thousand";
    }

    throw UnimplementedError('number not implemented $number');
  }

  @override
  String toString() {
    return enUs;
  }
}
