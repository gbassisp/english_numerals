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

Only integer cardinals are currently available, in the non-inclusive range ]-10^66, 10^66[


## Usage
 

```dart
final other = Cardinal(999);
print(other.enUk); // "nine hundred and ninety-nine"
print(other.enUs); // "nine hundred ninety-nine"
print(other.toString()); // "nine hundred ninety-nine"
```
