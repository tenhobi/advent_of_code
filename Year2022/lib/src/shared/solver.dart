import 'dart:convert';
import 'dart:io';

abstract class Solver {
  String get inputFile => 'lib/src/day${day.toString().padLeft(2, '0')}/input.txt';

  int get day;

  Future<List<String>> getFileLines() async =>
      File(inputFile).openRead().map(utf8.decode).transform(const LineSplitter()).toList();

  Future<String> solveFirst();

  Future<String> solveSecond();

  Future<String> getSolutions() async {
    return '''
Day ${day.toString().padLeft(2, '0')}:
First task: ${await solveFirst()}
Second task: ${await solveSecond()}
''';
  }
}
