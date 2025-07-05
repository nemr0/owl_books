
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../failures/failure.dart';
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
  )..interceptors.add(PrettyDioLogger(requestBody: true, responseBody: false));
  final Map<String, CancelToken> _cancelTokens = {};

  _addCancelKey(String? key) {
    if (key == null) return;
    if (_cancelTokens.containsKey(key)) {
      _cancelTokens[key]?.cancel();
    }
    _cancelTokens[key] = CancelToken();
  }

  _removeCancelKey(String? key) {
    if (key == null) return;
    if (_cancelTokens.containsKey(key)) {
      _cancelTokens.remove(key);
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? cancelKey,
  }) async {
    try {
      _addCancelKey(cancelKey);
      final res = await _dio.get(path,
          queryParameters: queryParameters,
          cancelToken: _cancelTokens[cancelKey]);
      _removeCancelKey(cancelKey);
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
      _removeCancelKey(cancelKey);
      if (e is DioException) {
       return Left(Failure.fromDioException(e));
      } else {
        return Left(ServerFailure(stackTrace: s));
      }
    }
  }

  @override
  cancelRequest(String key) {
    final cancelToken = _cancelTokens[key];
    if (cancelToken == null || cancelToken.isCancelled) return;
    cancelToken.cancel();
  }
}
