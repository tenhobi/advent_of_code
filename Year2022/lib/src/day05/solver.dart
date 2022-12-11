import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day05Solver extends Solver {
  @override
  int get day => 5;

  List<String> parseLine(String line) {
    final lineModified = line.replaceAll(RegExp(r'[\[\]]'), ' ');
    return lineModified
        .split('')
        .slices(4)
        .map((e) => e.join().trim())
        .toList();
  }

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final parts = lines.splitBefore((element) => element.isEmpty).toList();
    final crates = parts[0].take(parts[0].length - 1).map(parseLine);

    final cratesStack = <List<String>>[];
    for (final _ in crates.first) {
      cratesStack.add([]);
    }

    for (final line in crates) {
      for (var i = 0; i < line.length; i++) {
        if (line[i].isEmpty) {
          continue;
        }

        cratesStack[i].insert(0, line[i]);
      }
    }

    final moves = parts[1].skip(1).map((e) => e.split(' '));

    for (final move in moves) {
      final count = int.parse(move[1]);
      final from = int.parse(move[3]) - 1;
      final to = int.parse(move[5]) - 1;

      for (var i = 0; i < count; i++) {
        final last = cratesStack[from].removeLast();
        cratesStack[to].add(last);
      }
    }

    return cratesStack.map((e) => e.last).join();
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final parts = lines.splitBefore((element) => element.isEmpty).toList();
    final crates = parts[0].take(parts[0].length - 1).map(parseLine);

    final cratesStack = <List<String>>[];
    for (final _ in crates.first) {
      cratesStack.add([]);
    }

    for (final line in crates) {
      for (var i = 0; i < line.length; i++) {
        if (line[i].isEmpty) {
          continue;
        }

        cratesStack[i].insert(0, line[i]);
      }
    }

    final moves = parts[1].skip(1).map((e) => e.split(' '));

    for (final move in moves) {
      final count = int.parse(move[1]);
      final from = int.parse(move[3]) - 1;
      final to = int.parse(move[5]) - 1;

      final placeIndex = cratesStack[to].length;
      for (var i = 0; i < count; i++) {
        final last = cratesStack[from].removeLast();

        cratesStack[to].insert(placeIndex, last);
      }
    }

    return cratesStack.map((e) => e.last).join();
  }
}
