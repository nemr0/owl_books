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

  static DataStatus fromFailure(Failure failure,bool isNotPaginating) {

    switch(failure){
      case NetworkFailure():
        return isNotPaginating ? DataStatus.noInternet : DataStatus.paginatingNoInternet;
      default:
        return isNotPaginating ? DataStatus.serverError : DataStatus.paginatingServerError;
     // fallback status
    }
  }
}