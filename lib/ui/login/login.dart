import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'components/land_selector.dart';
import 'components/look_at_selector.dart';
import 'components/robert_mars.dart';
import 'components/robert_start_coordinates.dart';
import 'components/robert_travel.dart';
import 'components/terrain.dart';

import '../../utils/layout_scope.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutScope.of(context).breakpoint;
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(55, 26, 117, 1),
        ),
        child: Form(
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
                  child: Column(
                    children: [
                      const Text(
                        "Welcome to Mars Robert Experience",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LandSelector(),
                            SizedBox(width: 20),
                            LookAtSelector(),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: RobertStartCoordinates(),
                      ),
                      const RobertTravel(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Builder(
                          builder: (context) {
                            return OutlinedButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                WidgetsBinding.instance.addPostFrameCallback(
                                  (timeStamp) {
                                    if (Form.of(context).validate()
                                        case final validate when validate) {
                                      Form.of(context).save();
                                      BlocProvider.of<LoginBloc>(context)
                                          .add(const LoginLaunchRobertTravel());
                                    }
                                  },
                                );
                              },
                              child: const Text('Launch'),
                            );
                          },
                        ),
                      ),
                      const RobertMars(),
                    ],
                  ),
                ),
              ),
              const Terrain(),
            ],
          ),
        ),
      ),
    );
  }
}
