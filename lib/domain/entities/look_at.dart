import 'package:fpdart/fpdart.dart';

enum LookAt {
  north,
  south,
  west,
  east;

  T resolve<T>(
          {required IO<T> onNorth,
          required IO<T> onSouth,
          required IO<T> onWest,
          required IO<T> onEast}) =>
      switch (this) {
        LookAt.north => onNorth,
        LookAt.south => onSouth,
        LookAt.west => onWest,
        LookAt.east => onEast,
      }
          .run();

  String normalizePath(String path) {
    if (path.isEmpty) {
      return path;
    }

    const Map<String, String> south = {'F': 'B', 'B': 'F', 'L': 'R', 'R': 'L'};
    const Map<String, String> east = {'F': 'L', 'B': 'R', 'L': 'B', 'R': 'F'};
    const Map<String, String> west = {'F': 'R', 'B': 'L', 'L': 'F', 'R': 'B'};

    final currentPath = path.toUpperCase();
    return resolve(onNorth: IO(
      () {
        return currentPath;
      },
    ), onSouth: IO(
      () {
        return currentPath.split('').map((char) => south[char] ?? char).join();
      },
    ), onWest: IO(
      () {
        return currentPath.split('').map((char) => west[char] ?? char).join();
      },
    ), onEast: IO(
      () {
        return currentPath.split('').map((char) => east[char] ?? char).join();
      },
    ));
  }

  int get quarterTurns => resolve(
      onNorth: IO(
        () => 0,
      ),
      onSouth: IO(
        () => 2,
      ),
      onWest: IO(
        () => 3,
      ),
      onEast: IO(
        () => 1,
      ));
}
