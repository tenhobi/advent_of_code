import 'dart:io';

import 'package:aoc_2022/src/day01/solver.dart';
import 'package:aoc_2022/src/day02/solver.dart';
import 'package:aoc_2022/src/day03/solver.dart';
import 'package:aoc_2022/src/day04/solver.dart';
import 'package:aoc_2022/src/day05/solver.dart';
import 'package:aoc_2022/src/day06/solver.dart';
import 'package:aoc_2022/src/day07/solver.dart';
import 'package:aoc_2022/src/day08/solver.dart';
import 'package:aoc_2022/src/day09/solver.dart';
import 'package:aoc_2022/src/day10/solver.dart';
import 'package:aoc_2022/src/day11/solver.dart';
import 'package:aoc_2022/src/day12/solver.dart';
import 'package:aoc_2022/src/day13/solver.dart';

final daySolvers = [
  Day01Solver(),
  Day02Solver(),
  Day03Solver(),
  Day04Solver(),
  Day05Solver(),
  Day06Solver(),
  Day07Solver(),
  Day08Solver(),
  Day09Solver(),
  Day10Solver(),
  Day11Solver(),
  Day12Solver(),
  Day13Solver(),
];

Future<void> main() async {
  await runOnlyDay(daySolvers.last.day);
}

Future<void> runOnlyDay(int day) async {
  stdout.writeln(await daySolvers[day - 1].getSolutions());
}

Future<void> runAll() async {
  for (var i = 1; i <= daySolvers.length; i++) {
    await runOnlyDay(i);
  }
}
