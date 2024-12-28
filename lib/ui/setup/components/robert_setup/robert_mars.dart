import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import '../../../../domain/entities/look_at.dart';
import '../../../../gen/assets.gen.dart';
import '../../bloc/setup_bloc.dart';

class RobertMars extends StatelessWidget {
  const RobertMars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SMIBool? runTrigger;
    bool isRunning = false;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
      child: BlocSelector<SetupBloc, SetupState, LookAt>(
        selector: (state) {
          return state.data.lookAt;
        },
        builder: (context, lookAt) {
          return StatefulBuilder(
            builder: (context, setState) {
              return InkWell(
                onTap: () {
                  runTrigger?.change(isRunning = !isRunning);
                },
                child: RotatedBox(
                  quarterTurns: lookAt.quarterTurns,
                  child: Assets.animations.roverOnMars.rive(
                    onInit: (Artboard art) {
                      final ctrl = StateMachineController.fromArtboard(
                        art,
                        'rover states',
                      ) as StateMachineController;
                      art.addController(ctrl);
                      setState(
                        () {
                          runTrigger = ctrl.getBoolInput("run");
                        },
                      );
                    },
                    // animations: [animationState],
                    stateMachines: ['rover states'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
