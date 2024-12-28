import 'launch_button.dart';
import 'look_at_configuration.dart';
import 'land_difficult_configuration.dart';

import 'out_of_range_coordinates.dart';
import 'package:flutter/material.dart';

import 'coordinates_configuration.dart';
import 'path_configuration.dart';
import 'robert_mars.dart';

class RobertSetup extends StatelessWidget {
  const RobertSetup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome to Mars Robert Experience",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Wrap(
            children: [
              LandDifficultConfiguration(),
              SizedBox(width: 20),
              LookAtConfiguration(),
            ],
          ),
        ),
        CoordinatesConfiguration(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: PathConfiguration(),
        ),
        OutOfRangeCoordinates(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: LaunchButton(),
        ),
        RobertMars(),
      ],
    );
  }
}
