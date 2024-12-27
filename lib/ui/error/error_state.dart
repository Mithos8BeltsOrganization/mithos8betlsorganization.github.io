import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../gen/assets.gen.dart';
import '../common/background.dart';
import 'error_state_params.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.stateParams,
    super.key,
  });

  final ErrorStateParams stateParams;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'The Robert failed to reached its location.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 48),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 300, maxWidth: 300),
                    child: Assets.animations.error.rive(),
                  ),
                ),
                if (stateParams.lastUpdatedCoordinates
                    case final coordinates?) ...[
                  const Center(
                    child: Text(
                      'The current coordinates are:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  Center(
                    child: Text(
                      ' x:${coordinates.x} y:${coordinates.y}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ],
                if (stateParams.reachCoordinates case final coordinates?) ...[
                  const Center(
                    child: Text(
                      'And it try to be in:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  Center(
                    child: Text(
                      ' x:${coordinates.x} y:${coordinates.y}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Text(
                        stateParams.errorReason.resolve(
                          onObstacle: IO.of("Where there was an obstacle"),
                          onEndOfTheWorld:
                              IO.of("Beyond the limits of the world"),
                          onUnknown: IO.of(" "),
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: OutlinedButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final canPop = await navigator.maybePop();
                        if (canPop) {
                          return navigator.pop();
                        }
                        if (context.mounted) {
                          await navigator.pushReplacementNamed('index');
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Return'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
