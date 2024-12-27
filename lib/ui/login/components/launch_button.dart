import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchButton extends StatelessWidget {
  const LaunchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        WidgetsBinding.instance
            .addPostFrameCallback(
          (timeStamp) {
            if (Form.of(context).validate()
                case final validate when validate) {
              Form.of(context).save();
              BlocProvider.of<LoginBloc>(context)
                  .add(
                const LoginLaunchRobertTravel(),
              );
            }
          },
        );
      },
      child: const Text('Launch'),
    );
  }
}
