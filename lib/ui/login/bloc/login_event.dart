part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

final class LoginChangeFieldType extends LoginEvent {
  const LoginChangeFieldType({required this.field});

  final FieldType field;
}

final class LoginRefreshField extends LoginEvent {
  const LoginRefreshField();
}

final class LoginChangeLookAtType extends LoginEvent {
  const LoginChangeLookAtType({required this.lookAt});

  final LookAt lookAt;
}

final class LoginChangeMapSizeType extends LoginEvent {
  const LoginChangeMapSizeType({required this.mapSize});

  final MapSize mapSize;
}

final class LoginLaunchRobertTravel extends LoginEvent {
  const LoginLaunchRobertTravel();
}

sealed class LoginSaveEvents<T> extends LoginEvent {
  final T value;

  const LoginSaveEvents({required this.value});
}

final class LoginSaveXCoordinate extends LoginSaveEvents<int> {
  const LoginSaveXCoordinate({required super.value});
}

final class LoginSaveYCoordinate extends LoginSaveEvents<int> {
  const LoginSaveYCoordinate({required super.value});
}

final class LoginSavePath extends LoginSaveEvents<String> {
  const LoginSavePath({required super.value});
}
