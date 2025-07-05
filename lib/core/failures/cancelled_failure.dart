import 'failure.dart';

class CancelledFailure implements Failure {
  const CancelledFailure({this.stackTrace});

  @override
  List<Object?> get props => [stackTrace];

  @override
  final StackTrace? stackTrace;

  @override
  bool? get stringify => true;
}
