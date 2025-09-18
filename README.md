<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Simple package to transform numbers into English numerals without flutter dependency and with null safety, as opposed to other obsolete packages.


## Features

- Top-level functions `convertToCardinal` and `parseCardinal`
- `Cardinal` class that takes any integer, BigInt, Cardinal, etc... on its constructor and can output the English written form of that number.

## Usage
 
Simple usage with the top-level functions:
```dart
print(convertToCardinal(999)) // "nine hundred ninety-nine"

// reads both US and UK forms
print(parseCardinal("nine hundred ninety-nine")) // 999
print(parseCardinal("nine hundred and ninety-nine")) // 999
```
 
It can be used to create a `Cardinal` number from `int` or `BigInt`:

```dart
final other = Cardinal(999);
print(other.enUk); // "nine hundred and ninety-nine"
print(other.enUs); // "nine hundred ninety-nine"
print(other.toString()); // "nine hundred ninety-nine"
```

It can also be used the other way around to convert cardinal text to int and BigInt:

```dart
final uk = Cardinal("nine hundred and ninety-nine");
print(uk.toInt()); // "999"
final us = Cardinal("nine hundred ninety-nine");
print(us.toInt()); // "999"
```
<!-- https://pub.dev/packages/english_numerals/versions/0.2.0 -->