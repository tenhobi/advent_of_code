import 'dart:io';

import 'package:aoc_2022/src/day01/solver.dart';
import 'package:aoc_2022/src/day02/solver.dart';

final daySolvers = [
  Day01Solver(),
  Day02Solver(),
];

Future<void> main() async {
  await runOnlyDay(2);
}

Future<void> runOnlyDay(int day) async {
  stdout.writeln(await daySolvers[day - 1].getSolutions());
}

Future<void> runAll() async {
  for (var i = 1; i <= daySolvers.length; i++) {
    await runOnlyDay(i);
  }
}
