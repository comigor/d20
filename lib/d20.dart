import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class D20 {
  final Parser _parser = Parser();
  final ContextModel _context = new ContextModel();
  Random _random;

  D20({random}) {
    this._random = random == null ? Random() : random;
  }

  String _rollSingleDie(Match match) {
    Iterable<int> parts =
        match.group(0).toString().split('d').map((String part) {
      return part.trim().isEmpty ? 1 : int.parse(part);
    });

    return List<int>.filled(parts.elementAt(0), parts.elementAt(1))
        .fold(0, (sum, die) => sum + _random.nextInt(die) + 1)
        .toString();
  }

  int roll(String roll) {
    String newRoll = roll
        .replaceAll(RegExp(r'\s'), '')
        .toLowerCase()
        .replaceAllMapped(RegExp(r'(\d+)?d\d+'), _rollSingleDie);

    return _parser
        .parse(newRoll)
        .evaluate(EvaluationType.REAL, _context)
        .round();
  }
}
