import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/look_at.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/login_bloc.dart';

class RobertMars extends StatelessWidget {
  const RobertMars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
      child: BlocSelector<LoginBloc, LoginState, LookAt>(
        selector: (state) {
          return state.data.lookAt;
        },
        builder: (context, lookAt) {
          return RotatedBox(
            quarterTurns: lookAt.quarterTurns,
            child: Assets.animations.roverOnMars.rive(),
          );
        },
      ),
    );
  }
}
