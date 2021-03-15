/// Dart library for RPG dice rolling.
///
/// Import this library as follows:
///
/// ```
/// import 'package:d20/d20.dart';
/// ```

import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'roll_result.dart';
import 'roll_statistics.dart';

final RegExp _singleDiceRegExp = RegExp(r'(\d+)?d(\d+)(-[l|h])?');

/// An expression-capable dice roller.
///
/// Simple usage:
/// ```
///   final D20 d20 = D20();
///   d20.roll('2d6+3');
/// ```
///
/// See also [rollWithStatistics], [RollStatistics] and [RollResult].
class D20 {
  /// Creates a dice roller.
  ///
  /// Optionally receives a [Random].
  D20({Random? random}) {
    _random = random ?? Random();
  }

  final Parser _parser = Parser();
  final ContextModel _context = ContextModel();

  /// A [Random] instance that can be customized for seeding.
  late Random _random;

  RollResult _rollSingleDie(Match match) {
    final notation = match[0]!;
    final numberOfRolls = match[1] == null ? 1 : int.parse(match[1]!);
    final faces = int.parse(match[2]!);
    final results = List<int>.filled(numberOfRolls, faces)
        .map((int die) => _random.nextInt(die) + 1)
        .toList();
    final lowestHighest = match[3];

    var sum = results.fold(0, (int sum, int roll) => sum + roll);

    if (lowestHighest == '-l') {
      sum -= results.fold<int>(faces, min);
    } else if (lowestHighest == '-h') {
      sum -= results.fold<int>(0, max);
    }

    return RollResult(
      rollNotation: notation,
      faces: faces,
      numberOfRolls: numberOfRolls,
      results: results,
      finalResult: sum,
    );
  }

  String _sanitizeStringNotation(String dirty) => dirty
      .toLowerCase()
      .replaceAll(RegExp(r'\s'), '')
      .replaceAll(RegExp(r'd%'), 'd100');

  /// Compute and return a [RollStatistics] with all information from a roll,
  /// including the result from each individual dice roll within.
  ///
  /// See [RollStatistics] and [RollResult] for more info.
  RollStatistics rollWithStatistics(String roll) {
    final sanitizedRoll = _sanitizeStringNotation(roll);

    final Iterable<Match> matches = _singleDiceRegExp.allMatches(sanitizedRoll);

    var newRoll = sanitizedRoll;
    final results = <RollResult>[];

    for (var i = matches.length - 1; i >= 0; i--) {
      final result = _rollSingleDie(matches.elementAt(i));
      results.add(result);
      newRoll = newRoll.replaceRange(
        matches.elementAt(i).start,
        matches.elementAt(i).end,
        result.finalResult.toString(),
      );
    }

    final exactResult = _parser
        .parse(newRoll)
        // ignore: avoid_as
        .evaluate(EvaluationType.REAL, _context) as double;

    return RollStatistics(
      rollNotation: sanitizedRoll,
      results: results,
      finalResult: exactResult.round(),
    );
  }

  /// Compute an arithmetic expression from a roll defined on standard notation
  /// format.
  ///
  /// Example:
  /// ```
  ///   d20.roll('2d6+3');
  ///   d20.roll('2d20-L');
  ///   d20.roll('d% * 8');
  ///   d20.roll('cos(2 * 5d20)');
  /// ```
  int roll(String roll) {
    final newRoll = _sanitizeStringNotation(roll).replaceAllMapped(
      _singleDiceRegExp,
      (Match m) => _rollSingleDie(m).finalResult.toString(),
    );

    final exactResult = _parser
        .parse(newRoll)
        // ignore: avoid_as
        .evaluate(EvaluationType.REAL, _context) as double;

    return exactResult.round();
  }
}
