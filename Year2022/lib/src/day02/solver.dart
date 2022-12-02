import 'package:aoc_2022/src/shared/solver.dart';

class Day02Solver extends Solver {
  @override
  int get day => 2;

  int getScoreFromLine(String line, {bool first = true}) {
    final split = line.split(' ');
    final opponentHand = Hand.fromCode(split.first);
    final myHand = Hand.fromCode(split.last);

    if (first) {
      return myHand.getCompareScore(opponentHand);
    }

    return myHand.getCompareScoreSecond(opponentHand);
  }

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();
    final score = lines.fold<int>(0, (sum, line) => sum + getScoreFromLine(line));

    return score.toString();
  }

  @override
  Future<String> solveSecond() async {
    final lines = await getFileLines();
    final score = lines.fold<int>(0, (sum, line) => sum + getScoreFromLine(line, first: false));

    return score.toString();
  }
}

enum Hand {
  rock(1),
  paper(2),
  scissors(3);

  final int value;

  const Hand(this.value);

  factory Hand.fromCode(String code) {
    if (code == 'A' || code == 'X') {
      return Hand.rock;
    } else if (code == 'B' || code == 'Y') {
      return Hand.paper;
    }

    return Hand.scissors;
  }

  int getCompareScore(Hand other) {
    var score = 0;

    // draw
    if (this == other) {
      score += 3;
    }

    // win
    if ((this == Hand.rock && other == Hand.scissors) ||
        (this == Hand.paper && other == Hand.rock) ||
        (this == Hand.scissors && other == Hand.paper)) {
      score += 6;
    }

    return score + value;
  }

  int getCompareScoreSecond(Hand other) {
    final scoreTable = [
      [3, 1, 2], // loose
      [1 + 3, 2 + 3, 3 + 3], // draw
      [2 + 6, 3 + 6, 1 + 6], // win
    ];

    return scoreTable[value - 1][other.value - 1];
  }
}
