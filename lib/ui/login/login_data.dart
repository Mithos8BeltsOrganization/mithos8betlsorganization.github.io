import 'package:equatable/equatable.dart';
import 'package:mars_robert_coordinate/domain/entities/coordinates.dart';

import 'package:mars_robert_coordinate/domain/entities/field_type.dart';
import 'package:mars_robert_coordinate/domain/entities/look_at.dart';
import 'package:mars_robert_coordinate/domain/entities/map_size.dart';

export 'package:mars_robert_coordinate/domain/entities/field_type.dart';
export 'package:mars_robert_coordinate/domain/entities/look_at.dart';
export 'package:mars_robert_coordinate/domain/entities/map_size.dart';

final class LoginData extends Equatable {
  final FieldType fieldType;
  final LookAt lookAt;
  final String? terrain;
  final MapSize mapSize;
  final Coordinates? coordinates;
  final String? path;

  const LoginData({
    this.fieldType = FieldType.land,
    this.lookAt = LookAt.north,
    this.mapSize = MapSize.small,
    this.terrain,
    this.coordinates,
    this.path,
  });

  @override
  List<Object?> get props => [
        fieldType,
        lookAt,
        terrain,
        mapSize,
        coordinates,
        path,
      ];

  LoginData copyWith({
    FieldType? fieldType,
    LookAt? lookAt,
    String? terrain,
    MapSize? mapSize,
    Coordinates? coordinates,
    String? path,
  }) {
    return LoginData(
      fieldType: fieldType ?? this.fieldType,
      lookAt: lookAt ?? this.lookAt,
      terrain: terrain ?? this.terrain,
      mapSize: mapSize ?? this.mapSize,
      coordinates: coordinates ?? this.coordinates,
      path: path ?? this.path,
    );
  }
}
