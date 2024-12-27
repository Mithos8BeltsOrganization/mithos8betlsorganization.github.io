import 'package:mars_robert_coordinate/domain/usecase/usecase.dart';


final class Coordinates extends Entity {
  final int x;
  final int y;

  const Coordinates({
    required this.x,
    required this.y,
  });

  

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
