import '../../../domain/entities/coordinates.dart';
import '../../../domain/usecase/move_around_usecase.dart';
import '../../../domain/usecase/terrain_generator.dart';
import '../login_data.dart';
import '../../../utils/safe_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends SafeBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitialState()) {
    on<LoginChangeFieldType>((event, emit) {
      final fieldType = event.field;
      final terrain = TerrainGenerator(
        fieldType: fieldType,
        dimension: state.data.mapSize.size,
      ).generator();

      emit(
        LoginTerrainGenerateState(
          stateData: state.data.copyWith(
            fieldType: fieldType,
            terrain: terrain,
          ),
        ),
      );
    });

    on<LoginChangeLookAtType>(
      (event, emit) {
        final lookAt = event.lookAt;

        emit(
          LoginTerrainGenerateState(
            stateData: state.data.copyWith(lookAt: lookAt),
          ),
        );
      },
    );

    on<LoginSaveEvents>(
      (event, emit) {
        final stateData = state.data;
        final coordinate =
            stateData.coordinates ?? const Coordinates(x: 0, y: 0);
        final newStateData = switch (event) {
          LoginSaveXCoordinate() => stateData.copyWith(
              coordinates: coordinate.copyWith(
                x: event.value,
              ),
            ),
          LoginSaveYCoordinate() => stateData.copyWith(
              coordinates: coordinate.copyWith(
                y: event.value,
              ),
            ),
          LoginSavePath() => stateData.copyWith(path: event.value),
        };

        emit(LoginUpdaterState(stateData: newStateData));
      },
    );

    on<LoginRefreshField>(
      (event, emit) {
        add(LoginChangeFieldType(field: state.data.fieldType));
      },
    );

    on<LoginLaunchRobertTravel>(
      (event, emit) {
        final terrain = state.data.terrain;
        if (terrain == null) {
          return;
        }
        final coordinates = state.data.coordinates;
        if (coordinates == null) {
          return;
        }
        if (coordinates.isOutsideMapSize(size: state.data.mapSize.size)
            case final outside when outside) {
          return emit(LoginCoordinateOutsideRangeState(stateData: state.data));
        }

        final pathToFollow = state.data.path;
        if (pathToFollow == null) {
          return;
        }

        final data = MoveAroundUsecase().call(
          MoveAroundParams(
            initialCoordinate: coordinates,
            pathToFollow: pathToFollow,
            currentMap: terrain,
            lookAt: state.data.lookAt,
          ),
        );

        final LoginState navigationState = data.fold(
          (failure) {
            return switch (failure) {
              NoValidFailure() => LoginValidationError(stateData: state.data),
              ObstacleFindFailure() => LoginMapObstacleState(
                  stateData: state.data,
                  currentCoordinate: failure.currentCoordinate,
                  inaccessibleCoordinate: failure.inaccessibleCoordinate,
                ),
              MapEndFailure() => LoginMapOutsideErrorState(
                  stateData: state.data,
                  currentCoordinate: failure.currentCoordinate,
                  inaccessibleCoordinate: failure.inaccessibleCoordinate,
                ),
              UnControlFailure() => LoginValidationError(stateData: state.data),
            };
          },
          (newRobertCoordinates) {
            return LoginSuccessfulLaunchState(
              stateData: state.data.copyWith(coordinates: newRobertCoordinates),
            );
          },
        );

        emit(navigationState);
      },
    );

    add(LoginChangeFieldType(field: state.data.fieldType));
  }
}
