import 'package:d20/d20.dart';
import 'package:d20/roll_statistics.dart';

void main() {
  final D20 d20 = D20();
  final RollStatistics stats = d20.rollWithStatistics('2d8+5+5d6');
  print(stats.results[0].faces);
  print(stats.results[1].results);
}
