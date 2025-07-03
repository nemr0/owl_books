import '../failures/failure.dart';
import '../failures/network_failure.dart';

enum DataStatus {
  initial,
  loading,
  paginating,
  success,
  noInternet,
  serverError,

}

extension DataStatusExtension on DataStatus {
  bool get isInitial => this == DataStatus.initial;
  bool get isLoading => this == DataStatus.loading;
  bool get isSuccess => this == DataStatus.success;
  bool get isNoInternet => this == DataStatus.noInternet;
  bool get isServerError => this == DataStatus.serverError;

  static DataStatus fromFailure(Failure failure){
    switch(failure){
      case NetworkFailure():
        return DataStatus.noInternet;
      default:
        return DataStatus.serverError;
     // fallback status
    }
  }
}