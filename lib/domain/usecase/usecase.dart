import "dart:async";

import "package:equatable/equatable.dart";
import "package:fpdart/fpdart.dart";
import "package:meta/meta.dart";

abstract class UseCase<Type extends Entity, UsecaseParams extends Params> {
  FutureOr<Either<Failure, Type>> call(UsecaseParams params);
}

@Immutable('Entities must be immutable')
abstract base class Entity extends Equatable {
  const Entity();

  @override
  List<Object?> get props;

  @override
  bool? get stringify => true;
}

@immutable
abstract class Params {
  const Params();
  bool validate();
  bool isNotValidate() => !validate();
}

class NoParams extends Params {
  const NoParams();
  @override
  bool validate() => true;
}

const NoParams noParams = NoParams();

abstract base class Failure {
  const Failure();
}
