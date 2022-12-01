import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day01Solver extends Solver {
  @override
  int get day => 1;

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final caloriesPerElfReversed = lines
        .splitAfter((line) => line.isEmpty)
        .map<int>((lineList) => lineList.fold<int>(0, (sum, calories) => sum + (int.tryParse(calories) ?? 0)))
        .sorted((a, b) => a.compareTo(b))
        .reversed;
    final caloriesTop1 = caloriesPerElfReversed.first;

    return caloriesTop1.toString();
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final caloriesPerElfReversed = lines
        .splitAfter((line) => line.isEmpty)
        .map<int>((lineList) => lineList.fold<int>(0, (sum, calories) => sum + (int.tryParse(calories) ?? 0)))
        .sorted((a, b) => a.compareTo(b))
        .reversed;

    final caloriesTop3 = caloriesPerElfReversed.take(3).sum;

    return caloriesTop3.toString();
  }
}

class Elf implements Comparable<Elf> {
  final List<int> calories = [];

  int get caloriesSum => calories.reduce((value, element) => value + element);

  Elf();

  @override
  int compareTo(Elf other) {
    return caloriesSum.compareTo(other.caloriesSum);
  }
}
