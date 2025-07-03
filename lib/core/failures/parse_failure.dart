
import 'failure.dart';

class ParseFailure implements Failure{

  @override
  final StackTrace? stackTrace;
  const ParseFailure({
    this.stackTrace,
  });
  @override
  List<Object?> get props => [stackTrace];



  @override
  bool? get stringify => true;

}