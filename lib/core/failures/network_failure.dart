import 'failure.dart';

class NetworkFailure implements Failure{

  @override
  final StackTrace? stackTrace;

  const NetworkFailure({this.stackTrace});
  @override
  List<Object?> get props =>[stackTrace];

  @override
  bool? get stringify =>true;
}