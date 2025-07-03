import 'package:dartz/dartz.dart';

import '../failures/parse_failure.dart';

extension EitherExtension<T, E> on Either<T, E> {
  /// Returns the left value if it exists, otherwise throws a [ParseFailure].
  T get asLeft => fold((l) => l, (r) => throw const ParseFailure());
  /// Returns the right value if it exists, otherwise throws a [ParseFailure].
  E get asRight => fold((l) => throw const ParseFailure(), (r) => r);
}