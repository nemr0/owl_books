import '../models/api_response.dart';
import 'failure.dart';

class ServerFailure implements Failure {

  @override
  final StackTrace? stackTrace;
  final int? statusCode;
  final ApiResponse? response;

  const ServerFailure({
    this.stackTrace,
    this.statusCode,
    this.response,
  });

  @override
  @override
  List<Object?> get props => [stackTrace, statusCode, response];

  @override
  bool? get stringify => true;
}
