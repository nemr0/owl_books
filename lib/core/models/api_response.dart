import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable{
  final dynamic data;
  final String? error;
  final int? statusCode;

  const ApiResponse({this.data, this.error, this.statusCode});

  factory ApiResponse.fromDio(Response response) {
    return ApiResponse(
      data: response.data,
      error: response.statusMessage,
      statusCode: response.statusCode,
    );
  }
  @override
  List<Object?> get props => [
    data,
    error,
    statusCode,
  ];



}