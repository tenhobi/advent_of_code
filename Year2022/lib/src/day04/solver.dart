import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day04Solver extends Solver {
  @override
  int get day => 4;

  bool isFullyCoveredByOther(String line) {
    final elves = line.split(',');
    final firstElf = elves[0].split('-');
    final secondElf = elves[1].split('-');
    final first = ElfPair(int.parse(firstElf[0]), int.parse(firstElf[1]));
    final second = ElfPair(int.parse(secondElf[0]), int.parse(secondElf[1]));
    return first.fullyContainOrTheOtherWay(second);
  }

  bool doesOverlap(String line) {
    final elves = line.split(',');
    final firstElf = elves[0].split('-');
    final secondElf = elves[1].split('-');
    final first = ElfPair(int.parse(firstElf[0]), int.parse(firstElf[1]));
    final second = ElfPair(int.parse(secondElf[0]), int.parse(secondElf[1]));
    return first.doesOverlapOrTheOtherWay(second);
  }

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final fullyContainsOtherSum = lines.fold(
      0,
      (sum, line) => sum + (isFullyCoveredByOther(line) ? 1 : 0),
    );
    return '$fullyContainsOtherSum';
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final fullyContainsOtherSum = lines.fold(
      0,
      (sum, line) => sum + (doesOverlap(line) ? 1 : 0),
    );
    return '$fullyContainsOtherSum';
  }
}

class ElfPair {
  final int start;
  final int end;

  const ElfPair(this.start, this.end);

  bool fullyContainOrTheOtherWay(ElfPair other) {
    return _contains(other) || other._contains(this);
  }

  bool _contains(ElfPair other) {
    return start <= other.start && end >= other.end;
  }

  bool _partiallyOverlap(ElfPair other) {
    return start <= other.start && end >= other.start && end <= other.end;
  }

  bool doesOverlapOrTheOtherWay(ElfPair other) {
    return fullyContainOrTheOtherWay(other) ||
        _partiallyOverlap(other) ||
        other._partiallyOverlap(this);
  }
}
