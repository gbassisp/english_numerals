import 'package:english_numerals/english_numerals.dart';
import 'package:test/test.dart';

/// all tests use hard-coded numbers extracted from wikipedia:
/// https://en.wikipedia.org/wiki/English_numerals
void main() {
  group('Cardinal numbers', () {
    /// Cardinal numbers refer to the size of a group. In English, these words are numerals
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

// If a number is in the range 21 to 99, and the second digit is not zero, the number is typically written as two words separated by a hyphen.
    test('21 to 99', () {
      final someNumbers = <int, String>{
        21: "twenty-one",
        25: "twenty-five",
        32: "thirty-two",
        58: "fifty-eight",
        64: "sixty-four",
        79: "seventy-nine",
        83: "eighty-three",
        99: "ninety-nine",
      };
      for (var k in someNumbers.keys) {
        expect(Cardinal(k).toString(), someNumbers[k]);
      }
    });
  });
}
