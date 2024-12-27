part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  const LoginState({
    required LoginData? stateData,
  }) : data = stateData ?? const LoginData();
  final LoginData data;
  LoginState copyWith({
    LoginData? stateData,
  });
}

final class LoginInitialState extends LoginState {
  const LoginInitialState({super.stateData});

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginInitialState(stateData: stateData);
  }
}

final class LoginTerrainGenerateState extends LoginState {
  const LoginTerrainGenerateState({required super.stateData});

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginTerrainGenerateState(stateData: stateData);
  }
}

final class LoginUpdaterState extends LoginState {
  const LoginUpdaterState({required super.stateData});

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginUpdaterState(stateData: stateData);
  }
}

final class LoginCoordinateOutsideRangeState extends LoginState {
  const LoginCoordinateOutsideRangeState({required super.stateData});

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginCoordinateOutsideRangeState(stateData: stateData);
  }
}

final class LoginValidationError extends LoginLaunchState {
  const LoginValidationError({required super.stateData});

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginValidationError(stateData: stateData);
  }
}

sealed class LoginLaunchState extends LoginState {
  const LoginLaunchState({
    required super.stateData,
    this.inaccessibleCoordinate,
    this.currentCoordinate,
  });

  final Coordinates? currentCoordinate;
  final Coordinates? inaccessibleCoordinate;
}

final class LoginSuccessfulLaunchState extends LoginLaunchState {
  const LoginSuccessfulLaunchState({
    required super.stateData,
  });

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginSuccessfulLaunchState(
      stateData: stateData,
    );
  }
}

final class LoginMapOutsideErrorState extends LoginLaunchState {
  const LoginMapOutsideErrorState({
    required super.stateData,
    required super.currentCoordinate,
    required super.inaccessibleCoordinate,
  });

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginMapOutsideErrorState(
      stateData: stateData,
      inaccessibleCoordinate: inaccessibleCoordinate,
      currentCoordinate: currentCoordinate,
    );
  }
}

final class LoginMapObstacleState extends LoginLaunchState {
  const LoginMapObstacleState({
    required super.stateData,
    required super.currentCoordinate,
    required super.inaccessibleCoordinate,
  });

  @override
  LoginState copyWith({LoginData? stateData}) {
    return LoginMapObstacleState(
      stateData: stateData,
      inaccessibleCoordinate: inaccessibleCoordinate,
      currentCoordinate: currentCoordinate,
    );
  }
}
