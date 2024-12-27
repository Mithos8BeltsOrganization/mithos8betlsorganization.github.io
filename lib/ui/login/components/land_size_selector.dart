import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../login_data.dart';

class LandSizeSelector extends StatelessWidget {
  const LandSizeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocSelector<LoginBloc, LoginState, MapSize>(
            selector: (state) {
              return state.data.mapSize;
            },
            builder: (context, mapSize) {
              return DropdownMenu<MapSize>(
                textStyle: const TextStyle(color: Colors.black),
                requestFocusOnTap: true,
                onSelected: (value) {
                  if (value case final fieldSize? when fieldSize != mapSize) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginChangeMapSizeType(mapSize: value));
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
