import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_bloc.dart';
import '../../setup_data.dart';

class LandSizeConfiguration extends StatelessWidget {
  const LandSizeConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BlocSelector<SetupBloc, SetupState, MapSize>(
        selector: (state) {
          return state.data.mapSize;
        },
        builder: (context, mapSize) {
          return DropdownMenu<MapSize>(
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
              if (value case final fieldSize? when fieldSize != mapSize) {
                BlocProvider.of<SetupBloc>(context)
                    .add(SetupChangeMapSizeType(mapSize: value));
              }
            },
            initialSelection: mapSize,
            dropdownMenuEntries: [
              DropdownMenuEntry<MapSize>(
                value: MapSize.small,
                label: MapSize.small.name,
              ),
              DropdownMenuEntry<MapSize>(
                value: MapSize.medium,
                label: MapSize.medium.name,
              ),
              DropdownMenuEntry<MapSize>(
                value: MapSize.big,
                label: MapSize.big.name,
              ),
            ],
          );
        },
      ),
    );
  }
}
