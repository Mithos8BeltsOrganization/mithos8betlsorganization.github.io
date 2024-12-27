import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/background.dart';

import '../error/error_state_params.dart';
import 'bloc/login_bloc.dart';
import 'components/land_selector.dart';
import 'components/land_size_selector.dart';
import 'components/launch_button.dart';
import 'components/look_at_selector.dart';
import 'components/out_of_range_coordinates.dart';
import 'components/robert_mars.dart';
import 'components/robert_start_coordinates.dart';
import 'components/robert_travel.dart';
import 'components/terrain.dart';

import '../../utils/layout_scope.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoint = LayoutScope.of(context).breakpoint;
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLaunchState) {
            final navigator = Navigator.of(context);
            switch (state) {
              case LoginSuccessfulLaunchState():
                navigator.pushNamed(
                  'successful',
                  arguments: state.data.coordinates,
                );
                break;
              case LoginMapOutsideErrorState():
                navigator.pushNamed(
                  'error',
                  arguments: ErrorStateParams(
                    lastUpdatedCoordinates: state.currentCoordinate,
                    reachCoordinates: state.inaccessibleCoordinate,
                    errorReason: ErrorReason.endOfWorld,
                  ),
                );
                break;
              case LoginMapObstacleState():
                navigator.pushNamed(
                  'error',
                  arguments: ErrorStateParams(
                    lastUpdatedCoordinates: state.currentCoordinate,
                    reachCoordinates: state.inaccessibleCoordinate,
                    errorReason: ErrorReason.obstacle,
                  ),
                );
                break;
              case LoginValidationError():
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
              child: Form(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(top: 32, left: 8, right: 8),
                          child: Column(
                            children: [
                              Text(
                                "Welcome to Mars Robert Experience",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LandSelector(),
                                    SizedBox(width: 20),
                                    LookAtSelector(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: RobertStartCoordinates(),
                              ),
                              RobertTravel(),
                              OutOfRangeCoordinates(),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: LaunchButton(),
                              ),
                              RobertMars(),
                            ],
                          ),
                        ),
                      ),
                      if (breakpoint.isL) const Terrain(),
                      const Center(child: LandSizeSelector()),
                    ],
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
