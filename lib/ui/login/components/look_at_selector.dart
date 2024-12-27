import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../login_data.dart';

class LookAtSelector extends StatelessWidget {
  const LookAtSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocSelector<LoginBloc, LoginState, LookAt>(
        selector: (state) {
          return state.data.lookAt;
        },
        builder: (context, blocLookAt) {
          return DropdownMenu<LookAt>(
            textStyle: const TextStyle(color: Colors.black),
            requestFocusOnTap: true,
            onSelected: (value) {
              if (value case final lookAt? when lookAt != blocLookAt) {
                BlocProvider.of<LoginBloc>(context)
                    .add(LoginChangeLookAtType(lookAt: lookAt));
              }
            },
            initialSelection: blocLookAt,
            dropdownMenuEntries: [
              DropdownMenuEntry<LookAt>(
                value: LookAt.west,
                label: LookAt.west.name,
              ),
              DropdownMenuEntry<LookAt>(
                value: LookAt.north,
                label: LookAt.north.name,
              ),
              DropdownMenuEntry<LookAt>(
                value: LookAt.east,
                label: LookAt.east.name,
              ),
              DropdownMenuEntry<LookAt>(
                value: LookAt.south,
                label: LookAt.south.name,
              ),
            ],
          );
        },
      ),
    );
  }
}
