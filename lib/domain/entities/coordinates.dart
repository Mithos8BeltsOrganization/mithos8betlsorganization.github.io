import '../usecase/usecase.dart';

final class Coordinates extends Entity {
  const Coordinates({
    required this.x,
    required this.y,
  });
  final int x;
  final int y;

  bool isOutsideMapSize({required int size}) =>
      (x > size || x < 0) || (y > size || y < 0);

  @override
  List<Object?> get props => [
        x,
        y,
      ];

  Coordinates copyWith({
    int? x,
    int? y,
  }) {
    return Coordinates(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
