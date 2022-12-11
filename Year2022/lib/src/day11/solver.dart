import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day11Solver extends Solver {
  @override
  int get day => 11;

  @override
  Future<String> solveFirst() async {
    final result = await solve(rounds: 20, divide: true);
    return '$result';
  }

  @override
  Future<String> solveSecond() async {
    final result = await solve(rounds: 10000);
    return '$result';
  }

  Future<int> solve({required int rounds, bool divide = false}) async {
    final lines = await getFileLines();
    final monkeys = <Monkey>[];

    // Parse
    for (final monkeyLines in lines.splitAfter((element) => element.isEmpty)) {
      final startingItems = <int>[];
      int? operationValue;
      late final String operation;
      late final int testValue;
      late final int testTrueMonkey;
      late final int testFalseMonkey;

      for (final line in monkeyLines.map((line) => line.trimLeft())) {
        if (line.startsWith('Starting items:')) {
          startingItems.addAll(line.split(':').last.split(',').map(int.parse));
        } else if (line.startsWith('Operation:')) {
          final parts = line.split(' ');
          final tmpValue = parts.removeLast();
          operation = parts.last;
          if (tmpValue != 'old') {
            operationValue = int.parse(tmpValue);
          }
        } else if (line.startsWith('Test:')) {
          testValue = int.parse(line.split(' ').last);
        } else if (line.startsWith('If true:')) {
          testTrueMonkey = int.parse(line.split(' ').last);
        } else if (line.startsWith('If false:')) {
          testFalseMonkey = int.parse(line.split(' ').last);
        }
      }

      monkeys.add(
        Monkey(
          items: startingItems,
          operation: operation,
          testValue: testValue,
          testTrueMonkey: testTrueMonkey,
          testFalseMonkey: testFalseMonkey,
          operationValue: operationValue,
        ),
      );
    }

    // Compute gcd
    final lcm = monkeys.map((monkey) => monkey.testValue).reduce(_lcm);

    // Play
    for (var i = 0; i < rounds; i++) {
      for (final monkey in monkeys) {
        for (var j = 0; j < monkey.items.length; j++) {
          // inspect
          monkey.inspections++;
          if (monkey.operation == '+') {
            monkey.items[j] += monkey.operationValue ?? monkey.items[j];
          } else if (monkey.operation == '*') {
            monkey.items[j] *= monkey.operationValue ?? monkey.items[j];
          }

          if (divide) {
            // relief
            monkey.items[j] ~/= 3;
          }

          monkey.items[j] %= lcm;

          // throw item
          final nextMonkeyIndex = (monkey.items[j] % monkey.testValue == 0) ? monkey.testTrueMonkey : monkey.testFalseMonkey;
          monkeys[nextMonkeyIndex]
              .items
              .add(monkey.items[j]);
        }

        monkey.items.removeWhere((_) => true);
      }
    }

    final sorted = monkeys.sorted((a, b) => a.inspections.compareTo(b.inspections)).reversed.toList();
    final result = sorted[0].inspections * sorted[1].inspections;
    return result;
  }

  int _lcm(int a, int b) {
    if ((a == 0) || (b == 0)) {
      return 0;
    }

    return ((a ~/ a.gcd(b)) * b).abs();
  }
}

class Monkey {
  final List<int> items;
  final int? operationValue;
  final String operation;

  final int testValue;
  final int testTrueMonkey;
  final int testFalseMonkey;

  int inspections = 0;

  Monkey({
    required this.items,
    required this.operation,
    required this.testValue,
    required this.testTrueMonkey,
    required this.testFalseMonkey,
    this.operationValue,
  });
}
