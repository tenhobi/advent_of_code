import 'package:aoc_2022/src/shared/solver.dart';

class Day08Solver extends Solver {
  @override
  int get day => 8;

  bool isEdge(List<List<int>> trees, Vector coords) {
    final width = trees.first.length;
    final height = trees.length;
    return coords.y == 0 ||
        coords.x == 0 ||
        coords.y == height - 1 ||
        coords.x == width - 1;
  }

  int greatestNumberInDirection(
    List<List<int>> trees,
    Vector coords,
    Vector direction,
  ) {
    if (isEdge(trees, coords)) {
      return trees[coords.y][coords.x];
    }

    final nextBigger =
        greatestNumberInDirection(trees, coords.add(direction), direction);

    if (trees[coords.y][coords.x] > nextBigger) {
      return trees[coords.y][coords.x];
    }

    return nextBigger;
  }

  bool isVisible(List<List<int>> trees, Vector coords) {
    if (isEdge(trees, coords)) {
      return true;
    }

    const directions = [
      Vector(y: 1, x: 0),
      Vector(y: -1, x: 0),
      Vector(y: 0, x: 1),
      Vector(y: 0, x: -1)
    ];

    for (final direction in directions) {
      final biggestInDirection =
          greatestNumberInDirection(trees, coords.add(direction), direction);
      if (trees[coords.y][coords.x] > biggestInDirection) {
        return true;
      }
    }

    return false;
  }

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();

    // rows, columns
    final trees = <List<int>>[];
    for (final line in lines) {
      trees.add(line.split('').map(int.parse).toList());
    }

    var sum = 0;
    for (var y = 0; y < lines.length; y++) {
      for (var x = 0; x < lines.first.length; x++) {
        sum += isVisible(trees, Vector(y: y, x: x)) ? 1 : 0;
      }
    }

    return '$sum';
  }

  int countOfVisibleTrees(
    List<List<int>> trees,
    Vector coords,
    Vector direction,
    int valueToCompare,
  ) {
    if (trees[coords.y][coords.x] >= valueToCompare) {
      return 1;
    }

    if (isEdge(trees, coords)) {
      return 1;
    }

    final nextCoord = coords.add(direction);
    return 1 + countOfVisibleTrees(trees, nextCoord, direction, valueToCompare);
  }

  int scenicScore(List<List<int>> trees, Vector coords) {
    if (isEdge(trees, coords)) {
      return 1;
    }

    const directions = [
      Vector(y: -1, x: 0),
      Vector(y: 0, x: -1),
      Vector(y: 0, x: 1),
      Vector(y: 1, x: 0),
    ];

    final scores = [1, 1, 1, 1];

    for (var i = 0; i < directions.length; i++) {
      final count = countOfVisibleTrees(
        trees,
        coords.add(directions[i]),
        directions[i],
        trees[coords.y][coords.x],
      );
      scores[i] = count;
    }

    final product = scores.reduce((value, element) => value * element);
    return product;
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();

    final numberOfColumns = lines.first.length;

    // rows, columns
    final trees = <List<int>>[];
    for (final line in lines) {
      trees.add(line.split('').map(int.parse).toList());
    }

    var biggest = 0;
    for (var y = 0; y < lines.length; y++) {
      for (var x = 0; x < lines.first.length; x++) {
        final currentTreeScore = scenicScore(trees, Vector(y: y, x: x));
        if (currentTreeScore > biggest) {
          biggest = currentTreeScore;
        }
      }
    }

    return '$biggest';
  }
}

class Vector {
  final int y;
  final int x;

  const Vector({
    required this.y,
    required this.x,
  });

  Vector add(Vector other) {
    return Vector(y: y + other.y, x: x + other.x);
  }

  @override
  String toString() {
    return 'Vector{y: $y, x: $x}';
  }
}
