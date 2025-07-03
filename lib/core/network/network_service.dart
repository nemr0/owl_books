import 'package:dartz/dartz.dart';

import '../failures/failure.dart';
import '../models/api_response.dart';

abstract class NetworkService{
  Future<Either<Failure,ApiResponse>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  });
}