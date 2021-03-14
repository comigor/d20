import 'roll_result.dart';

/// An aggregator of valuable information from a roll.
class RollStatistics {
  /// Instantiate the statistics of a roll.
  RollStatistics({
    required this.rollNotation,
    required this.results,
    required this.finalResult,
  });

  /// The sanitized string notation from the roll.
  String rollNotation;

  /// A list of [RollResult] from the roll.
  List<RollResult> results;

  /// The final result from the roll.
  int finalResult;
}
