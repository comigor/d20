<p align="center">
  <img src="https://camo.githubusercontent.com/ea37eaceae12eedced315029af7a335d34b4a018/68747470733a2f2f63646e2e706978616261792e636f6d2f70686f746f2f323031322f30342f31382f31352f30312f6879706572637562652d33373237385f3936305f3732302e706e67" width="150">
  <h1>D20</h1>
</p>

<!-- Badges -->
[![View at pub.dev][pub-badge]][pub-link]
[![Test][actions-badge]][actions-link]
[![PRs Welcome][prs-badge]][prs-link]
[![Star on GitHub][github-star-badge]][github-star-link]
[![Fork on GitHub][github-forks-badge]][github-forks-link]

[pub-badge]: https://img.shields.io/pub/v/d20?style=for-the-badge
[pub-link]: https://pub.dev/packages/d20

[actions-badge]: https://img.shields.io/github/workflow/status/comigor/d20/CI?style=for-the-badge
[actions-link]: https://github.com/comigor/d20/actions

[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge
[prs-link]: https://github.com/comigor/d20/issues

[github-star-badge]: https://img.shields.io/github/stars/comigor/d20.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-star-link]: https://github.com/comigor/d20/stargazers

[github-forks-badge]: https://img.shields.io/github/forks/comigor/d20.svg?style=for-the-badge&logo=github&logoColor=ffffff
[github-forks-link]: https://github.com/comigor/d20/network/members

D20 is a Dart library for RPG dice rolling. Supports standard notation (like "2d12", "d6+5" and "2d20-L").

## Installation

Add the following to your `pubspec.yaml` file:
```yaml
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
  final d20 = D20();
  print(d20.roll('2d8+5+5d6'));
}

```

One can also get (probably) useful information of roll results:
```dart
import 'package:d20/d20.dart';

void main() {
  final d20 = D20();
  final stats = d20.rollWithStatistics('2d8+5+5d6');
  print(stats.results[0].faces);
  print(stats.results[1].results);
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
