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
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return DropdownMenu<LookAt>(
            requestFocusOnTap: true,
            onSelected: (value) {
              if (value case final lookAt? when lookAt != state.data.lookAt) {
                BlocProvider.of<LoginBloc>(context)
                    .add(LoginChangeLookAtType(lookAt: lookAt));
              }
            },
            initialSelection: state.data.lookAt,
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
