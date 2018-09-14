import 'dart:math';
import 'package:d20/d20.dart';
import 'package:test/test.dart';

void main() {
  test('we can roll a single die', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('d20'), 16);
  });

  test('we can roll a die multiple times', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('2d20'), 26);
  });

  test('we can roll a die and sum an amount', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('1d20+4'), 20);
  });

  test('we can roll multiple dice', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('d6+d4'), 6);
  });

  test('whitespace between operations work', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('d6       +         d4'), 6);
  });

  test('we ignore casing', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('D4'), 4);
  });

  test('whitespace between "d" work as well, but who would do that?', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('d 20'), 16);
  });

  test('more complex math operations work', () {
    final D20 die = D20(random: Random(0));
    expect(die.roll('d20 * 2 + 8 * sin(0) - 10'), 22);
  });

  test('different seeds yield different rolls', () {
    final D20 die1 = D20(random: Random(0));
    final D20 die2 = D20(random: Random(1));
    expect(die1.roll('d20'), isNot(die2.roll('d20')));
  });

  test('L and H notation are currently not supported', () {
    final D20 die1 = D20(random: Random(0));
    expect(() => die1.roll('d20-l'), throwsA(isStateError));
    expect(() => die1.roll('d20-h'), throwsA(isStateError));
  });

  test('d% is an alias for d100', () {
    final D20 die1 = D20(random: Random(0));
    final D20 die2 = D20(random: Random(0));
    expect(die1.roll('d%'), die2.roll('d100'));
  });
}
