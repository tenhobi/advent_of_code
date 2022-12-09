import 'package:aoc_2022/src/shared/solver.dart';
import 'package:equatable/equatable.dart';

class Day09Solver extends Solver {
  @override
  int get day => 9;

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final orders = lines.map((e) {
      final parts = e.split(' ');
      return Order(
        direction: Vector.fromCode(parts[0]),
        count: int.parse(parts[1]),
      );
    }).toList();

    return doStuff(orders, 1);
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final orders = lines.map((e) {
      final parts = e.split(' ');
      return Order(
        direction: Vector.fromCode(parts[0]),
        count: int.parse(parts[1]),
      );
    }).toList();

    return doStuff(orders, 9);
  }

  String doStuff(List<Order> orders, int ropePartsCount) {
    final tailVisitedStats = <Coords, int>{}..update(
        const Coords(y: 0, x: 0),
        (value) => value + 1,
        ifAbsent: () => 1,
      );

    final head = Vector(y: 0, x: 0);
    final rope = <RopePart>[RopePart(y: 0, x: 0, previous: head)];
    // rope.addAll(
    //   List.generate(
    //     ropePartsCount - 1,
    //     (index) => RopePart(y: 0, x: 0, previous: rope[index]),
    //   ),
    // );
    for (var i = 1; i < ropePartsCount; i++) {
      rope.add(RopePart(y: 0, x: 0, previous: rope.last));
    }

    for (final order in orders) {
      for (var i = 0; i < order.count; i++) {
        head.move(order.direction);

        for (final part in rope) {
          part.moveToPrevious();
        }

        tailVisitedStats.update(
          rope.last.coords,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }

    var sum = 0;
    tailVisitedStats.forEach((key, value) => sum += 1);
    return '$sum';
  }
}

class Order {
  final Vector direction;
  final int count;

  const Order({
    required this.direction,
    required this.count,
  });
}

class Coords extends Equatable {
  final int y;
  final int x;

  const Coords({
    required this.y,
    required this.x,
  });

  @override
  List<Object?> get props => [y, x];
}

class Vector {
  int y;
  int x;

  Vector({
    required this.y,
    required this.x,
  });

  void move(Vector other) {
    y += other.y;
    x += other.x;
  }

  @override
  String toString() {
    return '{y: $y, x: $x}';
  }

  factory Vector.fromCode(String code) {
    switch (code) {
      case 'U':
        return up;
      case 'D':
        return down;
      case 'L':
        return left;
      case 'R':
        return right;
    }
    throw UnimplementedError();
  }

  Coords get coords => Coords(y: y, x: x);

  static final up = Vector(y: -1, x: 0);
  static final down = Vector(y: 1, x: 0);
  static final left = Vector(y: 0, x: -1);
  static final right = Vector(y: 0, x: 1);
}

class RopePart extends Vector {
  final Vector previous;

  RopePart({
    required super.y,
    required super.x,
    required this.previous,
  });

  void moveToPrevious() {
    final yDiff = (previous.y - y).abs();
    final xDiff = (previous.x - x).abs();

    if (yDiff == 2 || xDiff == 2) {
      final dir = Vector(y: (previous.y - y).sign, x: (previous.x - x).sign);
      move(dir);
    }
  }
}
