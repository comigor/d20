/// Dart library for RPG dice rolling.
///
/// Import this library as follows:
///
/// ```
/// import 'package:d20/d20.dart';
/// ```

import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

/// An expression-capable dice roller.
/// 
/// Simple usage:
/// ```
///   final D20 d20 = D20();
///   d20.roll('2d6+3');
/// ```
class D20 {
  final Parser _parser = Parser();
  final ContextModel _context = ContextModel();

  /// A [Random] instance that can be customized for seeding.
  Random _random;

  /// Creates a dice roller.
  /// 
  /// Optionally receives a [Random].
  D20({Random random}) {
    _random = random == null ? Random() : random;
  }

  String _rollSingleDie(Match match) {
    final Iterable<int> parts =
        match.group(0).toString().split('d').map((String part) =>
            part.trim().isEmpty ? 1 : int.parse(part)
    );

    return List<int>.filled(parts.elementAt(0), parts.elementAt(1))
        .fold(0, (int sum, int die) => sum + _random.nextInt(die) + 1)
        .toString();
  }

  /// Compute an arithmetic expression, computing rolls defined on standard
  /// notation format.
  /// 
  /// Example:
  /// ```
  ///   d20.roll('2d6+3');
  ///   d20.roll('d% * 8');
  ///   d20.roll('cos(2 * 5d20)');
  /// ```
  int roll(String roll) {
    final String newRoll = roll
        .replaceAll(RegExp(r'\s'), '')
        .replaceAll(RegExp(r'd%'), 'd100')
        .toLowerCase()
        .replaceAllMapped(RegExp(r'(\d+)?d\d+'), _rollSingleDie);

    final double exactResult = _parser
        .parse(newRoll)
        .evaluate(EvaluationType.REAL, _context);
    
    return exactResult.round();
  }
}
