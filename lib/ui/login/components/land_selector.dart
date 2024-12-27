import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../login_data.dart';

class LandSelector extends StatelessWidget {
  const LandSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocSelector<LoginBloc, LoginState, FieldType>(
            selector: (state) {
              return state.data.fieldType;
            },
            builder: (context, fieldType) {
              return DropdownMenu<FieldType>(
                requestFocusOnTap: true,
                controller: TextEditingController(),
                onSelected: (value) {
                  if (value case final field? when field != fieldType) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginChangeFieldType(field: value));
                  }
                },
                initialSelection: fieldType,
                dropdownMenuEntries: fieldType.allToDropDownMenu,
              );
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context)
                  .add(const LoginRefreshField());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
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
