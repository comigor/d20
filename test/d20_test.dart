import 'dart:math';
import 'package:d20/d20.dart';
import 'package:d20/roll_statistics.dart';
import 'package:test/test.dart';

void main() {
  group('on D20.roll', () {
    test('we can roll a single dice', () {
      final D20 die = D20(random: Random(0));
      expect(die.roll('d20'), 16);
    });

    test('we can roll a dice multiple times', () {
      final D20 die = D20(random: Random(0));
      expect(die.roll('2d20'), 26);
    });

    test('we can roll a dice and sum an amount', () {
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

    test('d% is an alias for d100', () {
      final D20 die1 = D20(random: Random(0));
      final D20 die2 = D20(random: Random(0));
      expect(die1.roll('d%'), die2.roll('d100'));
    });

    test('"-L" notation subtracts lowest roll from result', () {
      final D20 die = D20(random: Random(0));
      expect(die.roll('2d20-L'), 16);
    });

    test('"-H" notation subtracts highest roll from result', () {
      final D20 die = D20(random: Random(0));
      expect(die.roll('2d20-H'), 10);
    });

    test(
        '''subtracting the lowest or highest roll from any single die will always return 0''',
        () {
      final D20 die = D20();
      expect(die.roll('d999-L'), 0);
      expect(die.roll('d999-H'), 0);
    });
  });

  group('on D20.rollWithStatistics', () {
    test('it sanitizes roll notation', () {
      final D20 die = D20();
      final RollStatistics statistics =
          die.rollWithStatistics('3 d 20 + 8D    6 +  10 *2 - d% + 2  D20- L');
      expect(statistics.rollNotation, '3d20+8d6+10*2-d100+2d20-l');
    });

    test('rolls are computed from last to first (for optimization)', () {
      final D20 die = D20();
      final RollStatistics statistics = die.rollWithStatistics('d8 + d100');
      expect(statistics.results[0].faces, 100);
      expect(statistics.results[1].faces, 8);
    });

    test('it has the correct amount of rolls and rolls within', () {
      final D20 die = D20();
      final RollStatistics statistics = die.rollWithStatistics('2d20-L + 6d6');
      expect(statistics.results.length, 2);
      expect(statistics.results[0].results.length, 6);
      expect(statistics.results[1].results.length, 2);
    });

    test('it correctly parses a single result', () {
      final D20 die = D20(random: Random(0));
      final RollStatistics statistics =
          die.rollWithStatistics('1d1 + 7d6-L + 1d1');
      expect(statistics.results[1].faces, 6);
      expect(statistics.results[1].numberOfRolls, 7);
      expect(statistics.results[1].rollNotation, '7d6-l');
      expect(statistics.results[1].results, <int>[6, 5, 2, 1, 4, 3, 2]);
      expect(statistics.results[1].finalResult, 22);
    });
  });
}
