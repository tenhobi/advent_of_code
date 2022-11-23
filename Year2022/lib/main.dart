import 'dart:io';

import 'package:aoc_2022/src/day01/solver.dart';

final daySolvers = [
  Day01Solver(),
];

void main() {
  runOnlyDay(1);
}

void runOnlyDay(int day) {
  stdout.writeln(daySolvers[day - 1].getSolutions());
}

void runAll() {
  for (var i = 1; i <= daySolvers.length; i++) {
    runOnlyDay(i);
  }
}
