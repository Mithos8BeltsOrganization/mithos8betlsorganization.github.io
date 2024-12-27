import 'package:fpdart/fpdart.dart';

import '../../domain/entities/coordinates.dart';

final class ErrorStateParams {
  const ErrorStateParams({
    required this.lastUpdatedCoordinates,
    required this.reachCoordinates,
    required this.errorReason,
  });

  const ErrorStateParams.empty()
      : lastUpdatedCoordinates = null,
        reachCoordinates = null,
        errorReason = ErrorReason.unknown;

  final Coordinates? lastUpdatedCoordinates;
  final Coordinates? reachCoordinates;
  final ErrorReason errorReason;
}

enum ErrorReason {
  obstacle,
  endOfWorld,
  unknown,
  ;

  T resolve<T>({
    required IO<T> onObstacle,
    required IO<T> onEndOfTheWorld,
    required IO<T> onUnknown,
  }) =>
      switch (this) {
        ErrorReason.obstacle => onObstacle,
        ErrorReason.endOfWorld => onEndOfTheWorld,
        ErrorReason.unknown => onUnknown,
      }
          .run();
}
