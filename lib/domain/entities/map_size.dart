import 'package:fpdart/fpdart.dart';

enum MapSize {
  small(4),
  medium(20),
  big(200);

  const MapSize(this.size);
  final int size;

  T resolve<T>({
    required IO<T> onSmall,
    required IO<T> onMedium,
    required IO<T> onBig,
  }) =>
      switch (this) {
        MapSize.small => onSmall,
        MapSize.medium => onMedium,
        MapSize.big => onBig,
      }
          .run();
}
