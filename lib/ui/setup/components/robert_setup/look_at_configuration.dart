import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_bloc.dart';
import '../../setup_data.dart';

class LookAtConfiguration extends StatelessWidget {
  const LookAtConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SetupBloc, SetupState, LookAt>(
      selector: (state) {
        return state.data.lookAt;
      },
      builder: (context, blocLookAt) {
        return DropdownMenu<LookAt>(
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          textStyle: const TextStyle(color: Colors.black),
          requestFocusOnTap: true,
          onSelected: (value) {
            if (value case final lookAt? when lookAt != blocLookAt) {
              BlocProvider.of<SetupBloc>(context)
                  .add(SetupChangeLookAtType(lookAt: lookAt));
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
    );
  }
}
