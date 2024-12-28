import '../../../domain/entities/coordinates.dart';
import '../../../domain/usecase/move_around_usecase.dart';
import '../../../domain/usecase/terrain_generator.dart';
import '../setup_data.dart';
import '../../../utils/safe_bloc.dart';
import 'package:meta/meta.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends SafeBloc<SetupEvent, SetupState> {
  SetupBloc() : super(const SetupInitialState()) {
    on<SetupChangeFieldType>((event, emit) {
      final fieldType = event.field;
      final terrain = TerrainGenerator(
        fieldType: fieldType,
        dimension: state.data.mapSize.size,
      ).generator();

      emit(
        SetupTerrainGenerateState(
          stateData: state.data.copyWith(
            fieldType: fieldType,
            terrain: terrain,
          ),
        ),
      );
    });

    on<SetupChangeMapSizeType>(
      (event, emit) {
        emit(
          SetupUpdaterState(
            stateData: state.data.copyWith(mapSize: event.mapSize),
          ),
        );

        add(const SetupRefreshField());
      },
    );

    on<SetupChangeLookAtType>(
      (event, emit) {
        final lookAt = event.lookAt;

        emit(
          SetupTerrainGenerateState(
            stateData: state.data.copyWith(lookAt: lookAt),
          ),
        );
      },
    );

    on<SetupSaveEvents>(
      (event, emit) {
        final stateData = state.data;
        final coordinate =
            stateData.coordinates ?? const Coordinates(x: 0, y: 0);
        final newStateData = switch (event) {
          SetupSaveXCoordinate() => stateData.copyWith(
              coordinates: coordinate.copyWith(
                x: event.value,
              ),
            ),
          SetupSaveYCoordinate() => stateData.copyWith(
              coordinates: coordinate.copyWith(
                y: event.value,
              ),
            ),
          SetupSavePath() => stateData.copyWith(path: event.value),
        };

        emit(SetupUpdaterState(stateData: newStateData));
      },
    );

    on<SetupRefreshField>(
      (event, emit) {
        add(SetupChangeFieldType(field: state.data.fieldType));
      },
    );

    on<SetupLaunchRobertTravel>(
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
          return emit(SetupCoordinateOutsideRangeState(stateData: state.data));
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

        final SetupState navigationState = data.fold(
          (failure) {
            return switch (failure) {
              NoValidFailure() => SetupValidationError(stateData: state.data),
              ObstacleFindFailure() => SetupMapObstacleState(
                  stateData: state.data,
                  currentCoordinate: failure.currentCoordinate,
                  inaccessibleCoordinate: failure.inaccessibleCoordinate,
                ),
              MapEndFailure() => SetupMapOutsideErrorState(
                  stateData: state.data,
                  currentCoordinate: failure.currentCoordinate,
                  inaccessibleCoordinate: failure.inaccessibleCoordinate,
                ),
              UnControlFailure() => SetupValidationError(stateData: state.data),
            };
          },
          (newRobertCoordinates) {
            return SetupSuccessfulLaunchState(
              stateData: state.data.copyWith(coordinates: newRobertCoordinates),
            );
          },
        );

        emit(navigationState);
      },
    );

    add(SetupChangeFieldType(field: state.data.fieldType));
  }
}
