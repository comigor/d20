# D20

D20 is a Dart library for RPG dice rolling. Supports standard notation (like "2d12", "d20+5" and "4d6*5").

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
  D20 d20 = D20();
  print(d20.roll('2d8+5+5d6'));
}
```

## Supported notation
The [standard dice notation](https://en.wikipedia.org/wiki/Dice_notation) will be parsed, such as 2d8+4. L and H notation are not supported yet.

### Operators
You can also use mathematical operators, such as `1d6*3` or `10d4/d6`; or even `10 * sin(d20)`, though I'm not sure why you'd need that.
