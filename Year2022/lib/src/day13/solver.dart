import 'dart:convert';

import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day13Solver extends Solver {
  @override
  int get day => 13;

  int comparePacketsOne(dynamic left, dynamic right) {
    if (left is int && right is int) {
      return left.compareTo(right);
    }
    else if (left is List && right is List) {
      late final int minLength;

      if (left.length < right.length) {
        minLength = left.length;
      } else {
        minLength = right.length;
      }

      for (var i = 0; i < minLength; i++) {
        final result = comparePacketsOne(left[i], right[i]);
        if (result == -1) {
          return -1;
        }
        if (result == 1) {
          return 1;
        }
      }

      if (left.length == right.length) {
        return 0;
      } else if (left.length < right.length) {
        return -1;
      }

      return 1;
    }
    else if (left is int && right is List) {
      return comparePacketsOne([left], right);
    }
    else if (left is List && right is int) {
      return comparePacketsOne(left, [right]);
    }

    return 1;
  }

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final pairs = lines.splitAfter((line) => line.isEmpty).toList();

    var sum = 0;
    for (var i = 0; i < pairs.length; i++) {
      final left = json.decode(pairs[i][0]);
      final right = json.decode(pairs[i][1]);

      if (comparePacketsOne(left, right) == -1) {
        sum += i + 1;
      }
    }

    return '$sum';
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final dividerPackets = [[[2]], [[6]]];
    final packets = lines.whereNot((element) => element.isEmpty).map((line) => json.decode(line)).toList()
      ..addAll(dividerPackets);
    final sorted = packets.sorted(comparePacketsOne);

    var product = 1;
    for (var i = 0; i < sorted.length; i++) {
      if (comparePacketsOne(sorted[i], [[2]]) == 0 || comparePacketsOne(sorted[i], [[6]]) == 0) {
        product *= i + 1;
      }
    }

    return '$product';
  }
}
