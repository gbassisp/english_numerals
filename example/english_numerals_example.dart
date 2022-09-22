import 'package:english_numerals/english_numerals.dart';

void main() {
  final one = Cardinal(1);
  print(one.enUk); // "one"
  print(one.enUs); // "one"
  print(one.toString()); // "one"

  final other = Cardinal(999);
  print(other.enUk); // "nine hundred and ninety-nine"
  print(other.enUs); // "nine hundred ninety-nine"
  print(other.toString()); // "nine hundred ninety-nine"
}
