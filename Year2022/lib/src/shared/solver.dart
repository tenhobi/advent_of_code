abstract class Solver {
  String get inputFile => 'input.txt';
  int get day;

  String solveFirst();

  String solveSecond();

  String getSolutions() {
    return '''
Day ${day.toString().padLeft(2, '0')}:
First task: ${solveFirst()}
Second task: ${solveSecond()}
''';
  }
}
