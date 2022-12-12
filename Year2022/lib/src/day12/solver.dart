import 'package:aoc_2022/src/shared/solver.dart';

class Day12Solver extends Solver {
  @override
  int get day => 12;

  @override
  Future<String> solveFirst() async {
    return solve(isFirst: true);
  }

  @override
  Future<String> solveSecond() async {
    return solve();
  }

  Future<String> solve({bool isFirst = false}) async {
    final lines = await getFileLines();
    final map = lines.map((line) => line.split('')).toList();

    Vector? ePosition;

    final stack = <Step>[];

    for (var row = 0; row < map.length; row++) {
      for (var column = 0; column < map.first.length; column++) {
        if (map[row][column] == 'S') {
          stack.insert(0, Step(vector: Vector(row: row, column: column), step: 0, lastHeight: 0));
        }
        if (!isFirst && map[row][column] == 'a') {
          stack.insert(0, Step(vector: Vector(row: row, column: column), step: 0, lastHeight: 0));
        }

        if (map[row][column] == 'E') {
          ePosition = Vector(row: row, column: column);
        }
      }
    }

    final end = ePosition!;

    while (true) {
      if (stack.isEmpty) {
        break;
      }

      final item = stack.removeLast();

      if (item.vector.row < 0 ||
          item.vector.row >= map.length ||
          item.vector.column < 0 ||
          item.vector.column >= map.first.length) {
        continue;
      }

      final current = map[item.vector.row][item.vector.column];

      late final int height;
      if (regexp.hasMatch(current)) {
        height = current.codeUnitAt(0) - 'a'.codeUnitAt(0);
        if (!(height <= item.lastHeight + 1)) {
          continue;
        }
      } else if( current == 'S') {
        height = 'a'.codeUnitAt(0) - 'a'.codeUnitAt(0);
      } else if (current == 'E') {
        height = 'z'.codeUnitAt(0) - 'a'.codeUnitAt(0);
      } else {
        continue;
      }

      if (item.vector.row == end.row && item.vector.column == end.column) {
        if (height <= item.lastHeight + 1) {
          return '${item.step}';
        }

        continue;
      }

      map[item.vector.row][item.vector.column] = '.';

      for (final direction in directions) {
        stack.insert(0, Step(vector: item.vector.move(direction), lastHeight: height, step: item.step + 1));
      }
    }

    return 'dunno';
  }

  static final regexp = RegExp('[a-z]');
}

class Step {
  final Vector vector;
  final int step;
  final int lastHeight;

  const Step({
    required this.vector,
    required this.step,
    required this.lastHeight,
  });
}

const directions = [
  Vector(row: 0, column: 1),
  Vector(row: 1, column: 0),
  Vector(row: 0, column: -1),
  Vector(row: -1, column: 0),
];

class Vector {
  final int row;
  final int column;

  const Vector({
    required this.row,
    required this.column,
  });

  Vector move(Vector direction) {
    return Vector(row: row + direction.row, column: column + direction.column);
  }

  @override
  String toString() {
    return 'Vector{row: $row, column: $column}';
  }
}
