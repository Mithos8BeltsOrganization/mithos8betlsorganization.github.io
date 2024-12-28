import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_bloc.dart';

class LandPreview extends StatelessWidget {
  const LandPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        if (state.data.terrain case final terrain? when terrain.isNotEmpty) {
          return Text(
            terrain,
            style: const TextStyle(fontSize: 40),
          );
        }

        return const SizedBox();
      },
    );
  }
}
