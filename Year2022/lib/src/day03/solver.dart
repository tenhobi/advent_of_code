import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day03Solver extends Solver {
  @override
  int get day => 3;

  Set<String> getBackpackHalvesIntersection(String line) {
    final backpack = line.split('');
    final halfLength = backpack.length ~/ 2;
    final firstHalf = backpack.sublist(0, halfLength).toSet();
    final secondHalf = backpack.sublist(halfLength).toSet();

    return firstHalf.intersection(secondHalf);
  }

  Set<String> getGroupBackpackIntersection(List<String> group) {
    final first = group[0].split('').toSet();
    final second = group[1].split('').toSet();
    final third = group[2].split('').toSet();

    return first.intersection(second).intersection(third);
  }

  int letterToIntValue(String letter) {
    if (letter.codeUnitAt(0) >= 'a'.codeUnitAt(0)) {
      return letter.codeUnitAt(0) - 'a'.codeUnitAt(0) + 1;
    }

    return letter.codeUnitAt(0) - 'A'.codeUnitAt(0) + 27;
  }

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final sum = lines.fold(0, (sum, line) => sum + getBackpackHalvesIntersection(line).fold(0, (sum, element) => sum + letterToIntValue(element)));

    return '$sum';
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final groups = lines.slices(3);
    final sum = groups.fold(0, (sum, group) => sum + getGroupBackpackIntersection(group).fold(0, (sum, element) => sum + letterToIntValue(element)));

    return '$sum';
  }
}
