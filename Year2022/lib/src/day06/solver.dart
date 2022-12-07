import 'package:aoc_2022/src/shared/solver.dart';

class Day06Solver extends Solver {
  @override
  int get day => 6;

  @override
  Future<String> solveFirst() async {
    final line = (await getFileLines()).first;

    for (var i = 3; i < line.length; i++) {
      final lastFour = [line[i - 3], line[i - 2], line[i - 1], line[i]];

      if (lastFour.toSet().length == 4) {
        return '${i + 1}';
      }
    }

    return 'dunno';
  }

  @override
  Future<String> solveSecond() async {
    const numberOfLetters = 14;
    final line = (await getFileLines()).first;

    for (var i = numberOfLetters - 1; i < line.length; i++) {
      final lastFour = <String>[];
      for (var j = 0; j < numberOfLetters; j++) {
        lastFour.add(line[i - j]);
      }

      if (lastFour.toSet().length == numberOfLetters) {
        return '${i + 1}';
      }
    }

    return 'dunno';
  }
}
