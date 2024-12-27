import 'dart:math';

import 'package:fpdart/fpdart.dart';
import '../entities/field_type.dart';

final class TerrainGenerator {
  const TerrainGenerator({required this.fieldType, this.dimension = 200});

  final FieldType fieldType;

  final int dimension;

  String generator() {
    List<String> matrix = [];
    for (var i = 0; i < dimension; i++) {
      final List<String> list = [];

      for (var j = 0; j < dimension; j++) {
        list.add(_isObstacle() ? 'X' : 'O');
      }

      matrix.add([...list, '\n'].join());
    }

    return matrix.join();
  }

  bool _isObstacle() {
    final int data = Random().nextInt(10);
    final bool isObstacle = fieldType.resolve(
      onLand: IO(
        () => data < 1,
      ),
      onMountain: IO(
        () => data < 3,
      ),
      onHills: IO(
        () => data <= 2,
      ),
    );
    return isObstacle;
  }
}
