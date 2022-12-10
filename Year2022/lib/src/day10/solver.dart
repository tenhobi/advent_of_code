import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day10Solver extends Solver {
  @override
  int get day => 10;

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final cycles = <int>[1];

    for (final line in lines) {
      final parts = line.split(' ');

      if (parts[0] == 'noop') {
        cycles.add(cycles.last);
      } else if (parts[0] == 'addx') {
        cycles
          ..add(cycles.last)
          ..add(cycles.last + int.parse(parts[1]));
      }
    }

    return '${calcScore(cycles, [20, 60, 100, 140, 180, 220])}';
  }

  int calcScore(List<int> cycles, List<int> days) {
    var sum = 0;
    for (final day in days) {
      sum += day * cycles[day - 1];
    }
    return sum;
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    var register = 1;
    final buffer = StringBuffer();

    final orders = lines
        .map((line) => line.split(' ').last)
        .map(
          (possiblyNumber) => int.tryParse(possiblyNumber) == null
              ? [0]
              : [0, int.parse(possiblyNumber)],
        )
        .flattened
        .toList();

    for (var i = 0; i < orders.length; i++) {
      final spritePosition = register;
      final drawingIndex = i % 40;
      final condition = spritePosition - 1 <= drawingIndex &&
          drawingIndex <= spritePosition + 1;

      if (i % 40 == 0) {
        buffer.writeln();
      }

      buffer.write(condition ? '#' : '.');
      register += orders[i];
    }

    return buffer.toString();
  }
}
