import 'package:english_numerals/src/english_numerals_base.dart';

/// Converts a number to its cardinal string representation.
///
/// Example:
/// ```dart
/// convertToCardinal(10); // 'ten'
/// convertToCardinal('12'); // 'twelve'
/// ```
String convertToCardinal(Object number) => Cardinal(number).toString();

/// Converts a cardinal string to its numeric representation as a BigInt.
///
/// Example:
/// ```dart
/// parseCardinal('ten'); // BigInt.from(10)
/// parseCardinal('eleven'); // BigInt.from(11)
/// parseCardinal('twelve'); // BigInt.from(12)
/// ```
BigInt parseCardinal(Object cardinal) => Cardinal(cardinal).toBigInt();
