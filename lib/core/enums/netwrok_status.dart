import '../failures/cancelled_failure.dart';
import '../failures/failure.dart';
import '../failures/network_failure.dart';

enum DataStatus {
  initial,
  loading,
  paginating,
  paginatingServerError,
  paginatingNoInternet,
  success,
  noInternet,
  serverError,

}

extension DataStatusExtension on DataStatus {
  bool get isInitial => this == DataStatus.initial;
  bool get isLoading => this == DataStatus.loading;
  bool get isSuccess => this == DataStatus.success || this == DataStatus.paginating;
  bool get isPaginating => this == DataStatus.paginating;
  bool get isNoInternet => this == DataStatus.noInternet;
  bool get isServerError => this == DataStatus.serverError;
  bool get isPaginatingNoInternet => this == DataStatus.paginatingNoInternet;
  bool get isPaginatingServerError => this == DataStatus.paginatingServerError;

  static DataStatus fromFailure(Failure failure,bool hasNoData) {
    switch(failure){
      case NetworkFailure():
        return hasNoData ? DataStatus.noInternet : DataStatus.paginatingNoInternet;
      case CancelledFailure():
        return hasNoData ? DataStatus.initial : DataStatus.success;
      default:
        return hasNoData ? DataStatus.serverError : DataStatus.paginatingServerError;
     // fallback status
    }
  }
}