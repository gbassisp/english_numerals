import 'package:english_numerals/english_numerals.dart';

extension NumeralOnInt on int {
  String toNumeral() => Cardinal(this).toString();
}

extension NumeralOnBigInt on BigInt {
  String toNumeral() => Cardinal(this).toString();
}
