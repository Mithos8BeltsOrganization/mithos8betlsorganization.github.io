import 'package:fpdart/fpdart.dart';

enum FieldType {
  land,
  mountain,
  hills;

  T resolve<T>(
          {required IO<T> onLand,
          required IO<T> onMountain,
          required IO<T> onHills}) =>
      switch (this) {
        FieldType.land => onLand,
        FieldType.mountain => onMountain,
        FieldType.hills => onHills,
      }
          .run();
}
