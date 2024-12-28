import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/setup_bloc.dart';
import '../../setup_data.dart';

class LandDifficultConfiguration extends StatelessWidget {
  const LandDifficultConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocSelector<SetupBloc, SetupState, FieldType>(
          selector: (state) {
            return state.data.fieldType;
          },
          builder: (context, fieldType) {
            return DropdownMenu<FieldType>(
              textStyle: const TextStyle(color: Colors.black),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              requestFocusOnTap: true,
              onSelected: (value) {
                if (value case final field? when field != fieldType) {
                  BlocProvider.of<SetupBloc>(context)
                      .add(SetupChangeFieldType(field: value));
                }
              },
              initialSelection: fieldType,
              dropdownMenuEntries: fieldType.allToDropDownMenu,
            );
          },
        ),
        const SizedBox(width: 8),
        ColoredBox(
          color: Colors.white,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<SetupBloc>(context)
                  .add(const SetupRefreshField());
            },
            icon: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }
}

extension FieldTypeExtension on FieldType {
  List<DropdownMenuEntry<FieldType>> get allToDropDownMenu => [
        DropdownMenuEntry<FieldType>(
          value: FieldType.land,
          label: FieldType.land.name,
        ),
        DropdownMenuEntry<FieldType>(
          value: FieldType.hills,
          label: FieldType.hills.name,
        ),
        DropdownMenuEntry<FieldType>(
          value: FieldType.mountain,
          label: FieldType.mountain.name,
        ),
      ];
}
