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

    /// In English, the hundreds are perfectly regular, except that the word hundred remains in its singular form regardless of the number preceding it.
    test('perfect hundreds', () {
      final hundreds = {
        100: "one hundred",
        200: "two hundred",
        900: "nine hundred",
      };
      for (var k in hundreds.keys) {
        expect(Cardinal(k).toString(), hundreds[k]);
      }
    });

    /// So too are the thousands, with the number of thousands followed by the word "thousand"
    test('perfect thousands', () {
      final thousands = {
        1000: "one thousand",
        2000: "two thousand",
        10000: "ten thousand",
        11000: "eleven thousand",
        20000: "twenty thousand",
        21000: "twenty-one thousand",
        30000: "thirty thousand",
        85000: "eighty-five thousand",
        100000: "one hundred thousand",
      };
      for (var k in thousands.keys) {
        expect(Cardinal(k).toString(), thousands[k]);
      }
    });

    /// simple negative
    test('negative', () {
      final negative = {
        -1: "negative one",
      };
      for (var k in negative.keys) {
        expect(Cardinal(k).toString(), negative[k]);
      }
    });

    ///
    test('intermediate numbers', () {
      final intermediate = {
        999000: "nine hundred ninety-nine thousand",
        78624365:
            "seventy-eight million six hundred twenty-four thousand three hundred sixty-five",
        91921242319:
            "ninety-one billion nine hundred twenty-one million two hundred forty-two thousand three hundred nineteen",
        139706537:
            "one hundred thirty-nine million seven hundred six thousand five hundred thirty-seven",
        34533372:
            "thirty-four million five hundred thirty-three thousand three hundred seventy-two",
      };
      for (var k in intermediate.keys) {
        expect(Cardinal(k).toString(), intermediate[k]);
      }
    });

    ///
    test('millions', () {
      final intermediate = {
        3000000: 'three million',
        250000000: 'two hundred fifty million',
      };
      for (var k in intermediate.keys) {
        expect(Cardinal(k).toString(), intermediate[k]);
      }
    });

    /// non-deterministic
    test('all up to 1 million', () {
      String previous = '';
      String current = '';
      for (int i = 0; i < 1000000; i++) {
        previous = current;
        current = Cardinal(i).toString();
        expect(current.isNotEmpty, true);
        expect(current, isNot(equals(previous)));
      }
    });

    /// limit
    test('acceptable extremes', () {
      String upper = '9' * 66;
      String lower = '-$upper';

      final u = Cardinal(upper);
      final l = Cardinal(lower);

      expect(() => u.toString(), isNot(throwsUnimplementedError));
      expect(() => l.toString(), isNot(throwsUnimplementedError));

      print(u.enUk);
      print(l.enUk);
      print(Cardinal(999).enUk);
    });

    /// unimplemeted limit
    test('unimplemented extremes', () {
      String upper = '1${'0' * 66}';
      String lower = '-$upper';

      final u = Cardinal(upper);
      final l = Cardinal(lower);

      expect(() => u.toString(), throwsUnimplementedError);
      expect(() => l.toString(), throwsUnimplementedError);
    });
  });

  group('project euler test', () {
    const numbers = {
      342: 'three hundred and forty-two',
      115: 'one hundred and fifteen',
    };

    int count(String number) {
      number = number.replaceAll(' ', '').replaceAll('-', '');
      return number.length;
    }

    test('british hundreds', () {
      for (var k in numbers.keys) {
        expect(Cardinal(k).enUk, numbers[k]);
      }
    });

    test('british non-deterministic letter counting', () {
      expect(count(Cardinal(115).enUk), 20);
      expect(count(Cardinal(342).enUk), 23);

      int c = 0;
      for (var i = 1; i <= 5; i++) {
        c += count(Cardinal(i).enUk);
      }
      expect(c, 19);

      c = 0;
      for (var i = 1; i <= 1000; i++) {
        c += count(Cardinal(i).enUk);
      }
      expect(c, 21124);
    });
  });
}
