import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/background.dart';

import '../error/error_state_params.dart';

import 'bloc/setup_bloc.dart';
import 'components/land_size/land_size.dart';

import 'components/robert_setup/robert_setup.dart';

class Setup extends StatelessWidget {
  const Setup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SetupBloc>(
      create: (context) => SetupBloc(),
      child: BlocListener<SetupBloc, SetupState>(
        listener: (context, state) {
          if (state is SetupLaunchState) {
            final navigator = Navigator.of(context);
            switch (state) {
              case SetupSuccessfulLaunchState():
                navigator.pushNamed(
                  'successful',
                  arguments: state.data.coordinates,
                );
                break;
              case SetupMapOutsideErrorState():
                navigator.pushNamed(
                  'error',
                  arguments: ErrorStateParams(
                    lastUpdatedCoordinates: state.currentCoordinate,
                    reachCoordinates: state.inaccessibleCoordinate,
                    errorReason: ErrorReason.endOfWorld,
                  ),
                );
                break;
              case SetupMapObstacleState():
                navigator.pushNamed(
                  'error',
                  arguments: ErrorStateParams(
                    lastUpdatedCoordinates: state.currentCoordinate,
                    reachCoordinates: state.inaccessibleCoordinate,
                    errorReason: ErrorReason.obstacle,
                  ),
                );
                break;
              case SetupValidationError():
                navigator.pushNamed(
                  'error',
                  arguments: ErrorStateParams(
                    lastUpdatedCoordinates: state.currentCoordinate,
                    reachCoordinates: state.inaccessibleCoordinate,
                    errorReason: ErrorReason.unknown,
                  ),
                );
                break;
            }
            return;
          }
        },
        child: Background(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Form(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          const SafeArea(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 32, left: 8, right: 8),
                              child: RobertSetup(),
                            ),
                          ),
                          LandSize(
                            maxTerrainWidthSize: constraints.maxWidth,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
