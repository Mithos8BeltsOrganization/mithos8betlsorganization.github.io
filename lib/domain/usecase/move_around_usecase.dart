import 'package:fpdart/fpdart.dart';

import '../entities/coordinates.dart';
import '../entities/look_at.dart';
import 'usecase.dart';

final class MoveAroundUsecase extends UseCase<Coordinates, MoveAroundParams> {
  @override
  Either<MoveAroundFailure, Coordinates> call(MoveAroundParams params) {
    return IOEither<MoveAroundFailure, Coordinates>.Do(
      ($) {
        return $(
          IOEither.tryCatch(
            () {
              if (params.isNotValidate()) {
                throw const UsecaseException(value: NoValidFailure());
              }
              final currentMap = params._mapInMatrix;

              return coordinatesAfterPath(
                params.pathToFollow,
                mapMatrix: currentMap,
                coordinates: params.initialCoordinate,
              );
            },
            (error, stackTrace) {
              if (error is UsecaseException<MoveAroundFailure>) {
                return error.value;
              }
              return const UnControlFailure();
            },
          ),
        );
      },
    ).run();
  }

  Coordinates coordinatesAfterPath(
    String path, {
    required List<List<String>> mapMatrix,
    required Coordinates coordinates,
  }) {
    final List<String> splitPath = path.split('');
    Coordinates currentCoordinates = coordinates;
    for (String currentAction in splitPath) {
      int moveInY = currentCoordinates.y;
      int moveInX = currentCoordinates.x;
      if (currentAction == 'F') {
        moveInY = moveInY - 1;
      }
      if (currentAction == 'B') {
        moveInY = moveInY + 1;
      }
      if (currentAction == 'L') {
        moveInX = moveInX + 1;
      }
      if (currentAction == 'R') {
        moveInX = moveInX - 1;
      }
      final coordinatesAfterMove =
          currentCoordinates.copyWith(x: moveInX, y: moveInY);

      final position = _obtainPosition(
        mapMatrix,
        currentCoordinates: coordinatesAfterMove,
        previousCoordinates: currentCoordinates,
      );

      if (position == 'X') {
        throw UsecaseException(
          value: ObstacleFindFailure(
            obstacleCoordinateFind: coordinatesAfterMove,
          ),
        );
      }
      currentCoordinates = currentCoordinates.copyWith(x: moveInX, y: moveInY);
    }

    return currentCoordinates;
  }

  String _obtainPosition(
    List<List<String>> mapMatrix, {
    required Coordinates currentCoordinates,
    required Coordinates previousCoordinates,
  }) {
    try {
      final List<String> line = mapMatrix[currentCoordinates.y];
      return line[currentCoordinates.x];
    } catch (_) {
      throw UsecaseException(
        value: MapEndFailure(
          currentCoordinate: previousCoordinates,
          inaccessibleCoordinate: currentCoordinates,
        ),
      );
    }
  }
}

final class UsecaseException<T extends Failure> implements Exception {
  const UsecaseException({required this.value});
  final T value;
}

final class MoveAroundParams extends Params {
  MoveAroundParams({
    required this.initialCoordinate,
    required String pathToFollow,
    required this.currentMap,
    required LookAt lookAt,
  }) : pathToFollow = lookAt.normalizePath(pathToFollow);
  final Coordinates initialCoordinate;
  final String pathToFollow;
  final String currentMap;

  List<List<String>> get _mapInMatrix => currentMap.split('\n').map(
        (row) {
          return row.split('');
        },
      ).toList();

  @override
  bool validate() {
    return pathToFollow.isNotEmpty && currentMap.isNotEmpty;
  }
}

sealed class MoveAroundFailure extends Failure {
  const MoveAroundFailure();
}

final class NoValidFailure extends MoveAroundFailure {
  const NoValidFailure();
}

final class ObstacleFindFailure extends MoveAroundFailure {
  const ObstacleFindFailure({required this.obstacleCoordinateFind});

  final Coordinates obstacleCoordinateFind;
}

final class MapEndFailure extends MoveAroundFailure {
  const MapEndFailure({
    required this.currentCoordinate,
    required this.inaccessibleCoordinate,
  });
  final Coordinates currentCoordinate;
  final Coordinates inaccessibleCoordinate;
}

final class UnControlFailure extends MoveAroundFailure {
  const UnControlFailure();
}
