import 'package:meta/meta.dart';

const _baseNumbers = <int, String>{
  10: 'ten',
  0: 'zero',
  1: 'one',
  11: 'eleven',
  2: 'two',
  12: 'twelve',
  20: 'twenty',
  3: 'three',
  13: 'thirteen',
  30: 'thirty',
  4: 'four',
  14: 'fourteen',
  40: 'forty',
  5: 'five',
  15: 'fifteen',
  50: 'fifty',
  6: 'six',
  16: 'sixteen',
  60: 'sixty',
  7: 'seven',
  17: 'seventeen',
  70: 'seventy',
  8: 'eight',
  18: 'eighteen',
  80: 'eighty',
  9: 'nine',
  19: 'nineteen',
  90: 'ninety',
};

final Map<String, int> _reverseMappedNumbers = {
  for (final e in _baseNumbers.entries) e.value: e.key,
};

const _suffixes = [
  'thousand',
  'million',
  'billion',
  'trillion',
  'quadrillion',
  'quintillion',
  'sextillion',
  'septillion',
  'octillion',
  'nonillion',
  'decillion',
  'undecillion',
  'duodecillion',
  'tredecillion',
  'quattuordecillion',
  'quindecillion',
  'sexdecillion',
  'septendecillion',
  'octodecillion',
  'novemdecillion',
  'vigintillion',
  // TODO(gbassisp): check validity and enable greater range:
  // 'unvigintillion',
  // 'duovigintillion',
  // 'trigintillion',
  // 'quadragintillion',
  // 'quinquagintillion',
  // 'sesquagintillion',
  // 'septuagintillion',
  // 'octogintillion',
  // 'nonagintillion',
];

final _knownKeywords = <String>{
  ..._suffixes,
  ..._baseNumbers.values,
  'hundred',
  'negative',
};

BigInt get _thousand => BigInt.from(1000);

/// A class that takes an integer number on its constructor and represents its
/// cardinal form on toString() method. Defaults to US notation, but enUs and
/// enUk getters can be used to specify locale.
@immutable
class Cardinal {
  /// default constructor for Cardinal, taking any type and converting to
  /// BigInt internally
  Cardinal(Object? number)
      : _n = number is BigInt
            ? number
            : number is int
                ? BigInt.from(number)
                : number is num
                    ? BigInt.from(number)
                    : BigInt.tryParse(number.toString()) ??
                        _cardinalToBigInt(number.toString());

  final BigInt _n;

  BigInt get _zero => BigInt.zero;
  BigInt get _ten => BigInt.from(10);
  BigInt get _twenty => BigInt.from(20);
  BigInt get _hundred => BigInt.from(100);
  int _toInt() => _n.toInt();
  bool get _isInt => _n.isValidInt;

  /// returns the BigInt value of this
  BigInt toBigInt() => _n;

  /// returns the integer value of this. Throws if number is too big for integer
  int toInt() {
    if (_n.isValidInt) {
      return _toInt();
    }

    throw RangeError('$_n cannot be cast to integer. Use toBigInt() instead');
  }

  /// returns the American notation of a cardinal integer
  String get enUs {
    return enUk.replaceAll(' and ', ' ');
  }

  /// returns the British notation of a cardinal integer
  String get enUk {
    // negatives
    if (_n < _zero) {
      return 'negative ${Cardinal(-_n).enUk}';
    }

    // basic numbers
    if (_isInt && _baseNumbers.containsKey(_toInt())) {
      return _baseNumbers[_toInt()]!;
    }

    // 20 to 99
    if (_n >= _twenty && _n < _hundred) {
      final tens = (_n ~/ _ten) * _ten;
      return '${Cardinal(tens).enUk}-${Cardinal(_n - tens).enUk}';
    }

    // perfect hundreds
    else if (_n < _thousand) {
      final hundreds = _n ~/ _hundred;
      final remainder = _n % _hundred;
      if (remainder == _zero) {
        return '${Cardinal(hundreds).enUk} hundred';
      } else {
        return '${Cardinal(hundreds * _hundred).enUk} and '
            '${Cardinal(remainder).enUk}';
      }
    }

    // perfect thousands
    if (_n >= _thousand) {
      var magnitude = _thousand;
      var remainder = _thousand;
      for (final s in _suffixes) {
        remainder = _n % magnitude;
        if (_n < magnitude * _thousand) {
          var text = '${Cardinal(_n ~/ magnitude).enUk} $s';
          if (remainder != _zero) {
            text += ' ${Cardinal(remainder).enUk}';
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cardinal && runtimeType == other.runtimeType && _n == other._n;

  @override
  int get hashCode => _n.hashCode;
}

BigInt _cardinalToBigInt(String text) {
  var t = text
      .toLowerCase()
      .replaceAll(' and ', ' ')
      .replaceAll('-', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  // var res = BigInt.zero;
  final negative = t.contains('negative');
  t = t.replaceAll('negative', '').replaceAll(RegExp(r'\s+'), ' ').trim();

  var keywords = t.split(' ');
  for (final kw in keywords) {
    if (!_knownKeywords.contains(kw)) {
      throw StateError('Unknown word $kw. Perhaps not yet supported?');
    }
  }

  if (_reverseMappedNumbers.containsKey(t)) {
    return BigInt.from(
      negative ? -_reverseMappedNumbers[t]! : _reverseMappedNumbers[t]!,
    );
  }

  BigInt getUpToThousand(List<String> keywords) {
    var runningSum = 0;
    if (keywords.contains('hundred')) {
      runningSum += _reverseMappedNumbers[keywords.first]! * 100;
      keywords.removeAt(0);
    }

    for (final kw in keywords) {
      if (_reverseMappedNumbers.containsKey(kw)) {
        runningSum += _reverseMappedNumbers[kw]!;
      }
    }

    return BigInt.from(runningSum);
  }

  var res = BigInt.zero;
  for (var i = _suffixes.length - 1; i >= 0; i--) {
    final suf = _suffixes[i];
    if (keywords.contains(suf)) {
      final idx = keywords.indexOf(suf);
      final kws = keywords.sublist(0, idx);
      keywords = keywords.sublist(idx)..removeAt(0);
      // if (keywords.contains('thousand')) {
      //   print('$keywords $res');
      // }
      final magnitude = _thousand.pow(i + 1);
      final value = getUpToThousand(kws);
      res += value * magnitude;
    }
  }

  res += getUpToThousand(keywords);
  res = res.abs();
  res = negative ? -res : res;

  return res;
}
