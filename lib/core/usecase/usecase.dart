// ignore_for_file: avoid_types_as_parameter_names

import 'package:dartz/dartz.dart';
import 'package:test3/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class Params {}
