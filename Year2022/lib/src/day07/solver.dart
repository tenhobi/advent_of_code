import 'package:aoc_2022/src/shared/solver.dart';
import 'package:collection/collection.dart';

class Day07Solver extends Solver {
  @override
  int get day => 7;

  @override
  Future<String> solveFirst() async {
    final lines = await getFileLines();

    final root = Directory(name: '/');
    var current = root;

    for (final line in lines) {
      final parts = line.split(' ');

      // COMMAND
      if (parts[0] == r'$') {
        // CD
        if (parts[1] == 'cd') {
          if (parts[2] == '/') {
            current = root;
            continue;
          } else if (parts[2] == '..') {
            current = current.parent!;
            continue;
          }

          final maybeDirectory = current.subdirectories
              .firstWhereOrNull((directory) => directory.name == parts[2]);
          if (maybeDirectory != null) {
            current = maybeDirectory;
            continue;
          }

          current.addDirectory(Directory(name: parts[2], parent: current));
          if (current.parent == null) {
            print(current.name);
          }
          current = current.parent!;
        }
        // LS
        else if (parts[1] == 'ls') {
          //
        }
      }
      // DIRECTORY
      else if (parts[0] == 'dir') {
        current.addDirectory(Directory(name: parts[1], parent: current));
      }
      // FILE
      else {
        current.addFile(File(size: int.parse(parts[0]), name: parts[1]));
      }
    }

    var sum = 0;
    root.recursiveTask(
      (directory) {
        final size = directory.size;
        if (size <= 100000) {
          sum += size;
        }
      },
    );

    return '$sum';
  }

  @override
  Future<String> solveSecond() async {
    const totalDiskSpace = 70000000;
    const atLeastSpace = 30000000;

    final lines = await getFileLines();

    final root = Directory(name: '/');
    var current = root;

    for (final line in lines) {
      final parts = line.split(' ');

      // COMMAND
      if (parts[0] == r'$') {
        // CD
        if (parts[1] == 'cd') {
          if (parts[2] == '/') {
            current = root;
            continue;
          } else if (parts[2] == '..') {
            current = current.parent!;
            continue;
          }

          final maybeDirectory = current.subdirectories
              .firstWhereOrNull((directory) => directory.name == parts[2]);
          if (maybeDirectory != null) {
            current = maybeDirectory;
            continue;
          }

          current.addDirectory(Directory(name: parts[2], parent: current));
          if (current.parent == null) {
            print(current.name);
          }
          current = current.parent!;
        }
        // LS
        else if (parts[1] == 'ls') {
          //
        }
      }
      // DIRECTORY
      else if (parts[0] == 'dir') {
        current.addDirectory(Directory(name: parts[1], parent: current));
      }
      // FILE
      else {
        current.addFile(File(size: int.parse(parts[0]), name: parts[1]));
      }
    }

    final currentFreeCapacity = totalDiskSpace - root.size;
    final requiredToClean = atLeastSpace - currentFreeCapacity;

    var smallestDeletedDirectorySize = totalDiskSpace;
    root.recursiveTask(
      (directory) {
        final size = directory.size;
        if (size >= requiredToClean) {
          if (size < smallestDeletedDirectorySize) {
            smallestDeletedDirectorySize = size;
          }
        }
      },
    );

    return '$smallestDeletedDirectorySize';
  }
}

class File {
  final String name;
  final int size;

  const File({
    required this.name,
    required this.size,
  });
}

class Directory {
  final Directory? parent;
  final List<Directory> subdirectories = [];
  final List<File> files = [];
  final String name;

  int get size =>
      files.fold(0, (sum, file) => sum + file.size) +
      subdirectories.fold(0, (sum, directory) => sum + directory.size);

  Directory({
    required this.name,
    this.parent,
  });

  void addDirectory(Directory directory) {
    subdirectories.add(directory);
  }

  void addFile(File file) {
    files.add(file);
  }

  void recursiveTask(void Function(Directory directory) task) {
    task(this);
    for (final subdir in subdirectories) {
      subdir.recursiveTask(task);
    }
  }
}
