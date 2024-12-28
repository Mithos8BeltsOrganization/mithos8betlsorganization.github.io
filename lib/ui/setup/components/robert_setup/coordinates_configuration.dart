import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_bloc.dart';

class CoordinatesConfiguration extends StatelessWidget {
  const CoordinatesConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Select your start X point',
                  labelText: 'X',
                ),
                validator: (value) {
                  final x = int.tryParse(value ?? '');
                  if (x == null) {
                    return 'You must select a X coordinate';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onSaved: (value) {
                  final x = int.tryParse(value ?? '');

                  if (x == null) {
                    return;
                  }

                  BlocProvider.of<SetupBloc>(context)
                      .add(SetupSaveXCoordinate(value: x));
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Select your start Y point',
                  labelText: 'Y',
                ),
                validator: (value) {
                  final y = int.tryParse(value ?? '');
                  if (y == null) {
                    return 'You must select a Y coordinate';
                  }
                  return null;
                },
                onSaved: (value) {
                  final y = int.tryParse(value ?? '');

                  if (y == null) {
                    return;
                  }

                  BlocProvider.of<SetupBloc>(context)
                      .add(SetupSaveYCoordinate(value: y));
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
