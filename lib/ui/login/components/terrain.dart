import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';

class Terrain extends StatelessWidget {
  const Terrain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
