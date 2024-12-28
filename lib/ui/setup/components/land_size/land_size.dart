import '../../../../utils/layout_scope.dart';
import 'land_preview.dart';
import 'land_size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class LandSize extends StatelessWidget {
  const LandSize({
    required this.maxTerrainWidthSize,
    super.key,
  });

  final double maxTerrainWidthSize;

  @override
  Widget build(BuildContext context) {
    final breakpoint = LayoutScope.of(context).breakpoint;

    return breakpoint.resolve(
      onL: IO(
        () {
          return Padding(
            padding: const EdgeInsets.only(top: 98),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LandSizeConfiguration(),
                if (breakpoint.isL)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxTerrainWidthSize / 2,
                    ),
                    child: const LandPreview(),
                  ),
              ],
            ),
          );
        },
      ),
      onM: IO(
        () {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LandSizeConfiguration(),
                  LandPreview(),
                ],
              ),
            ),
          );
        },
      ),
      onS: IO(
        () {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LandSizeConfiguration(),
                  LandPreview(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
