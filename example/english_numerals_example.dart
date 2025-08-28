// ignore_for_file: avoid_print because this is just an example

import 'package:english_numerals/english_numerals.dart';

void main() {
  final one = Cardinal(1);
  print(one.enUk); // "one"
  print(one.enUs); // "one"
  print(one); // "one"

  final other = Cardinal(999);
  print(other.enUk); // "nine hundred and ninety-nine"
  print(other.enUs); // "nine hundred ninety-nine"
  print(other); // "nine hundred ninety-nine"

  final uk = Cardinal('nine hundred and ninety-nine');
  print(uk.toInt()); // "999"
  final us = Cardinal('nine hundred ninety-nine');
  print(us.toInt()); // "999"
}
