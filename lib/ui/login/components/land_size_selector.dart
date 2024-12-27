import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_robert_coordinate/ui/login/bloc/login_bloc.dart';
import 'package:mars_robert_coordinate/ui/login/login_data.dart';

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
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return DropdownMenu<MapSize>(
                  requestFocusOnTap: true,
                  controller: TextEditingController(),
                  onSelected: (value) {
                    if (value case final fieldSize?
                        when fieldSize != state.data.mapSize) {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginChangeMapSizeType(mapSize: value));
                    }
                  },
                  initialSelection: state.data.mapSize,
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
                    )
                  ]);
            },
          ),
          const SizedBox(width: 8),
          IconButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(const LoginRefreshField());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }
}
