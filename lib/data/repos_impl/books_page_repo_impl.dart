import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/extensions/either_extension.dart';
import '../../core/failures/cancelled_failure.dart';
import '../../core/failures/failure.dart';
import '../../core/failures/server_failure.dart';
import '../../core/network/endpoints.dart';
import '../../core/network/network_service.dart';
import '../../domain/entities/books_page_entity.dart';
import '../../domain/repos/books_page_repo.dart';
import '../models/books_page_model.dart';

@LazySingleton(as: BooksPageRepository)
class BooksPageRepoImpl implements BooksPageRepository {
  final NetworkService _networkService;

  BooksPageRepoImpl(this._networkService);

  @override
  Future<Either<Failure, BooksPage?>> getBooksPage({
    required int? page,
    String? searchQuery,
    required bool cancelOnly,
  }) async {
    if(searchQuery != null)_networkService.cancelRequest('search');
    if(cancelOnly) return const Left(CancelledFailure());
    final res = await _networkService.get(
      path: EndPoints.books,
      queryParameters: {
        if(page!=null) 'page': page,
        if (searchQuery != null && searchQuery.isNotEmpty)'search': searchQuery,
      },
      cancelKey: searchQuery == null? null : 'search',
    );
    if (res.isLeft()) {
      if(res.asLeft is ServerFailure && (res.asLeft as ServerFailure).statusCode == 404){
        return const Right(null);
      }
      return Left(res.asLeft);
    }else{
      return Right(BooksPageModel.fromJson(res.asRight.data,searchQuery: searchQuery));
    }
  }
}
