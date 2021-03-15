import 'package:d20/d20.dart';

void main() {
  final d20 = D20();
  final stats = d20.rollWithStatistics('2d8+5+5d6');
  print(stats.results[0].faces);
  print(stats.results[1].results);
}
