/// A result from a single roll with a particular die.
class RollResult {
  /// Instantiate the result of a single roll.
  RollResult({
    this.rollNotation,
    this.faces,
    this.numberOfRolls,
    this.results,
    this.finalResult,
  });

  /// The string notation from this particular roll.
  String rollNotation;

  /// How many faces the die on the roll has.
  int faces;

  /// The number of times the die has been rolled.
  int numberOfRolls;

  /// A list of dice results from this roll.
  List<int> results;

  /// The final result from this roll (considering multiple throws and L/H notation).
  int finalResult;
}
