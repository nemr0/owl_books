import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../models/api_response.dart';
import 'cancelled_failure.dart';
import 'network_failure.dart';
import 'server_failure.dart';

class Failure extends Equatable {
  final StackTrace? stackTrace;

  const Failure(this.stackTrace);
/// Factory constructor to create a Failure from a DioException.
  factory Failure.fromDioException(DioException e) {
    if (e.error is SocketException) {
      return NetworkFailure(stackTrace: e.stackTrace);
    } else if (e.type == DioExceptionType.cancel) {
      return const CancelledFailure();
    } else {
      return ServerFailure(
        statusCode: e.response?.statusCode,
        response: ApiResponse.fromDio(e.response),
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  List<Object?> get props => [
        stackTrace,
      ];
}
