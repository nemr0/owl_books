import '../models/api_response.dart';
import 'failure.dart';

class ServerFailure implements Failure {

  @override
  final StackTrace? stackTrace;
  final int? statusCode;
  final ApiResponse? response;

  ServerFailure({
    this.stackTrace,
    this.statusCode,
    this.response,
  });

  @override
  List<Object?> get props => [stackTrace, statusCode];

  @override
  bool? get stringify => true;
}
