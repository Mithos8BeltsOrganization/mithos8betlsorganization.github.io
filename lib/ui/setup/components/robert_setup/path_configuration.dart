import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_bloc.dart';

class PathConfiguration extends StatelessWidget {
  const PathConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          hintText: 'Enter F, B, L, R only',
          labelText: 'Travel',
        ),
        onSaved: (value) {
          final travel = value;
          if (travel == null || travel.isEmpty) {
            return;
          }
          BlocProvider.of<SetupBloc>(context).add(SetupSavePath(value: travel));
        },
        validator: (value) {
          final travel = value;
          if (travel == null || travel.isEmpty) {
            return "No travel set";
          }

          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[FBLRfblr]')),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
