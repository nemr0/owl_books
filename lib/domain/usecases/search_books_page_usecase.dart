import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../core/failures/failure.dart';
import '../../core/service_locator/service_locator.dart';
import '../../core/usecases/usecase_abst.dart';
import '../entities/books_page_entity.dart';
import '../repos/books_page_repo.dart';
@lazySingleton
class SearchBooksPageUseCase
    extends UseCase<BooksPage, SearchBooksPageParameters> {
  final BooksPageRepository _repository;
  static SearchBooksPageUseCase get instance =>
      ServiceLocator.get<SearchBooksPageUseCase>();
  SearchBooksPageUseCase(this._repository);

  @override
  Future<Either<Failure, BooksPage>> call(
    SearchBooksPageParameters params,
  ) async {
    return await _repository.getBooksPage(
      page: params.page,
      searchQuery: params.searchQuery,
    );
  }
}

class SearchBooksPageParameters extends Equatable {
  final int page;
  final String? searchQuery;

  const SearchBooksPageParameters({required this.page, this.searchQuery});

  @override
  List<Object?> get props => [page, searchQuery];
}
