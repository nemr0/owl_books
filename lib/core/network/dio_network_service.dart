import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../failures/failure.dart';
import '../failures/network_failure.dart';
import '../failures/server_failure.dart';
import '../models/api_response.dart';
import 'endpoints.dart';
import 'network_service.dart';

@LazySingleton(as: NetworkService)
class DioNetworkService implements NetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl, // Replace with your API base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  @override
  Future<Either<Failure, ApiResponse>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParameters);
      if (res.statusCode == 200) {
        return Right(ApiResponse.fromDio(res));
      } else {
        return Left(
          ServerFailure(
            statusCode: res.statusCode,
            response: ApiResponse.fromDio(res),
          ),
        );
      }
    } catch (e, s) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return Left(NetworkFailure(stackTrace: e.stackTrace));
        } else {
          return Left(
            ServerFailure(
              statusCode: e.response?.statusCode,
              response: ApiResponse.fromDio(e.response!),
              stackTrace: e.stackTrace,
            ),
          );
        }
      } else {
        return Left(ServerFailure(stackTrace: s));
      }
    }
  }
}
