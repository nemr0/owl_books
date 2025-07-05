import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/failures/failure.dart';
import '../../core/service_locator/service_locator.dart';
import '../../core/usecases/usecase_abst.dart';
import '../entities/books_page_entity.dart';
import '../repos/books_page_repo.dart';

@lazySingleton
class GetBooksPageUseCase extends UseCase<BooksPage?, int?> {
  static GetBooksPageUseCase get instance =>
      ServiceLocator.get<GetBooksPageUseCase>();
  final BooksPageRepository _repository;

  GetBooksPageUseCase(this._repository);

  @override
  Future<Either<Failure, BooksPage?>> call(int? page) async {
    return await _repository.getBooksPage(page: page, cancelOnly: false);
  }
}
