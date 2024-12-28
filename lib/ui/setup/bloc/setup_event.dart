part of 'setup_bloc.dart';

@immutable
sealed class SetupEvent {
  const SetupEvent();
}

final class SetupChangeFieldType extends SetupEvent {
  const SetupChangeFieldType({required this.field});

  final FieldType field;
}

final class SetupRefreshField extends SetupEvent {
  const SetupRefreshField();
}

final class SetupChangeLookAtType extends SetupEvent {
  const SetupChangeLookAtType({required this.lookAt});

  final LookAt lookAt;
}

final class SetupChangeMapSizeType extends SetupEvent {
  const SetupChangeMapSizeType({required this.mapSize});

  final MapSize mapSize;
}

final class SetupLaunchRobertTravel extends SetupEvent {
  const SetupLaunchRobertTravel();
}

sealed class SetupSaveEvents<T> extends SetupEvent {
  const SetupSaveEvents({required this.value});
  final T value;
}

final class SetupSaveXCoordinate extends SetupSaveEvents<int> {
  const SetupSaveXCoordinate({required super.value});
}

final class SetupSaveYCoordinate extends SetupSaveEvents<int> {
  const SetupSaveYCoordinate({required super.value});
}

final class SetupSavePath extends SetupSaveEvents<String> {
  const SetupSavePath({required super.value});
}
