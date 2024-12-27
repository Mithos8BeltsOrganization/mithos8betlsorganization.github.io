import 'package:equatable/equatable.dart';
import '../../domain/entities/coordinates.dart';

import '../../domain/entities/field_type.dart';
import '../../domain/entities/look_at.dart';
import '../../domain/entities/map_size.dart';

export 'package:mars_robert_coordinate/domain/entities/field_type.dart';
export 'package:mars_robert_coordinate/domain/entities/look_at.dart';
export 'package:mars_robert_coordinate/domain/entities/map_size.dart';

final class LoginData extends Equatable {
  const LoginData({
    this.fieldType = FieldType.land,
    this.lookAt = LookAt.north,
    this.mapSize = MapSize.small,
    this.terrain,
    this.coordinates,
    this.path,
  });
  final FieldType fieldType;
  final LookAt lookAt;
  final String? terrain;
  final MapSize mapSize;
  final Coordinates? coordinates;
  final String? path;

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
