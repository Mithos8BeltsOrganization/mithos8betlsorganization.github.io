import 'package:flutter/material.dart';

import '../../domain/entities/coordinates.dart';
import '../../gen/assets.gen.dart';
import '../common/background.dart';

class SuccessfulState extends StatelessWidget {
  const SuccessfulState({required this.coordinates, super.key});

  final Coordinates coordinates;

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
                    'The Robert successfully reached its location.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 48),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 300, maxWidth: 300),
                    child: Assets.animations.success.rive(),
                  ),
                ),
                const Center(
                  child: Text(
                    'The current coordinates are:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Center(
                  child: Text(
                    ' x:${coordinates.x} y:${coordinates.y}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
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
                          await navigator.pushNamed('index');
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
