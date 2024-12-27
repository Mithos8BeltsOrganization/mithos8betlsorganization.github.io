import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutOfRangeCoordinates extends StatelessWidget {
  const OutOfRangeCoordinates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) {
        return state is LoginCoordinateOutsideRangeState;
      },
      builder: (context, mustShowError) {
        if (mustShowError) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'The coordinate are outside range',
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
