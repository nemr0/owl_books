import 'package:dartz/dartz.dart';

import '../failures/failure.dart';
import '../models/api_response.dart';

/// Abstract contract for making network requests.
///
/// Implementations should provide logic for HTTP GET requests and request cancellation.
abstract class NetworkService{
  /// Sends an HTTP GET request to the specified [path].
  ///
  /// [queryParameters]: Optional query parameters for the request.
  /// [cancelKey]: Optional key to identify and cancel this request.
  ///
  /// Returns either a [Failure] or an [ApiResponse].
  Future<Either<Failure,ApiResponse>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? cancelKey,
  });

  /// Cancels an ongoing request identified by [key].
  void cancelRequest(String key);
}