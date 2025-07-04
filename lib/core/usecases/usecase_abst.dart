import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../failures/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  static const NoParams _singleton = NoParams._internal();

  factory NoParams() {
    return _singleton;
  }

  const NoParams._internal();

  @override
  List<Object?> get props => [];
}