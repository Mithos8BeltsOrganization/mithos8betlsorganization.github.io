part of 'setup_bloc.dart';

@immutable
sealed class SetupState {
  const SetupState({
    required SetupData? stateData,
  }) : data = stateData ?? const SetupData();
  final SetupData data;
  SetupState copyWith({
    SetupData? stateData,
  });
}

final class SetupInitialState extends SetupState {
  const SetupInitialState({super.stateData});

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupInitialState(stateData: stateData);
  }
}

final class SetupTerrainGenerateState extends SetupState {
  const SetupTerrainGenerateState({required super.stateData});

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupTerrainGenerateState(stateData: stateData);
  }
}

final class SetupUpdaterState extends SetupState {
  const SetupUpdaterState({required super.stateData});

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupUpdaterState(stateData: stateData);
  }
}

final class SetupCoordinateOutsideRangeState extends SetupState {
  const SetupCoordinateOutsideRangeState({required super.stateData});

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupCoordinateOutsideRangeState(stateData: stateData);
  }
}

final class SetupValidationError extends SetupLaunchState {
  const SetupValidationError({required super.stateData});

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupValidationError(stateData: stateData);
  }
}

sealed class SetupLaunchState extends SetupState {
  const SetupLaunchState({
    required super.stateData,
    this.inaccessibleCoordinate,
    this.currentCoordinate,
  });

  final Coordinates? currentCoordinate;
  final Coordinates? inaccessibleCoordinate;
}

final class SetupSuccessfulLaunchState extends SetupLaunchState {
  const SetupSuccessfulLaunchState({
    required super.stateData,
  });

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupSuccessfulLaunchState(
      stateData: stateData,
    );
  }
}

final class SetupMapOutsideErrorState extends SetupLaunchState {
  const SetupMapOutsideErrorState({
    required super.stateData,
    required super.currentCoordinate,
    required super.inaccessibleCoordinate,
  });

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupMapOutsideErrorState(
      stateData: stateData,
      inaccessibleCoordinate: inaccessibleCoordinate,
      currentCoordinate: currentCoordinate,
    );
  }
}

final class SetupMapObstacleState extends SetupLaunchState {
  const SetupMapObstacleState({
    required super.stateData,
    required super.currentCoordinate,
    required super.inaccessibleCoordinate,
  });

  @override
  SetupState copyWith({SetupData? stateData}) {
    return SetupMapObstacleState(
      stateData: stateData,
      inaccessibleCoordinate: inaccessibleCoordinate,
      currentCoordinate: currentCoordinate,
    );
  }
}
