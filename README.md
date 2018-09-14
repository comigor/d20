<p align="center">
  <img src="https://camo.githubusercontent.com/ea37eaceae12eedced315029af7a335d34b4a018/68747470733a2f2f63646e2e706978616261792e636f6d2f70686f746f2f323031322f30342f31382f31352f30312f6879706572637562652d33373237385f3936305f3732302e706e67" width="150">
  <h1>D20</h1>
</p>

<!-- Badges -->

[![Pub Package](https://img.shields.io/pub/v/d20.svg)](https://pub.dartlang.org/packages/d20)
[![CircleCI](https://circleci.com/gh/Igor1201/d20/tree/master.svg?style=svg&circle-token=376c1d43be17c8602903dfc02368f711ea1a4ed6)](https://circleci.com/gh/Igor1201/d20/tree/master)

D20 is a Dart library for RPG dice rolling. Supports standard notation (like "2d12", "d6+5" and "2d20-L").

## Installation
add the following to your `pubspec.yaml` file:
```shell
dependencies:
  d20: <1.0.0
```
then run:
```shell
pub get
```
or with flutter:
```shell
flutter packages get
```

## Usage

```dart
import 'package:d20/d20.dart';

void main() {
  final D20 d20 = D20();
  print(d20.roll('2d8+5+5d6'));
}

```

## Supported notation
The [standard dice notation](https://en.wikipedia.org/wiki/Dice_notation) will be parsed, such as 2d8+4.

### L and H subtraction
When a `-L` or `-H` follows a roll, as in `2d20-L`, the lowest (or highest) roll of the sequence will be subtracted from the result.

### Operators
You can also use mathematical operators, such as `1d6*3` or `10d4/d6`; or even `10 * sin(d20)`, though I'm not sure why you'd need that.

### Percentile dice (d%)
You can also use use the `d%` notation instead of `d100`.
