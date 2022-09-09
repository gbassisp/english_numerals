import 'package:english_numerals/english_numerals.dart';
import 'package:test/test.dart';

/// all tests use hard-coded numbers extracted from wikipedia:
/// https://en.wikipedia.org/wiki/English_numerals
void main() {
  group('Cardinal numbers', () {
    test('base groups', () {
      // yes, this is basically a copy of the implementation
      final baseNumbers = <int, String>{
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
      for (var k in baseNumbers.keys) {
        expect(Cardinal(k).toString(), baseNumbers[k]);
      }
    });
  });
}
