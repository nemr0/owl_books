import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enums/netwrok_status.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../../../domain/usecases/search_books_page_usecase.dart';

@injectable
class SearchBooksCubit extends Cubit<DataStatus> {
  SearchBooksCubit(this._searchBooksPageUseCase) : super(DataStatus.initial);

  static SearchBooksCubit get factory => ServiceLocator.get<SearchBooksCubit>();

  final SearchBooksPageUseCase _searchBooksPageUseCase;
  BooksPage? currentBooksPage;

  clear() async {
   await _searchBooksPageUseCase(
      SearchBooksPageParameters(
          page: (currentBooksPage?.nextPage ?? 2) - 1,
          cancelOnly: true,
          searchQuery: currentBooksPage?.searchQuery),
    );
    currentBooksPage = null;
    emit(DataStatus.initial);
  }

  paginate() async {
    if (currentBooksPage == null || currentBooksPage!.nextPage == null) return;
    if (currentBooksPage?.searchQuery != null) {
      await searchBooks(currentBooksPage!.searchQuery!, true);
    }
  }

  searchBooks(String query, [bool paginate = false]) async {
    if (state == DataStatus.loading || state == DataStatus.paginating) return;
    emit(paginate ? DataStatus.paginating : DataStatus.loading);
    if (currentBooksPage != null && currentBooksPage!.searchQuery != query) {
      currentBooksPage = null;
    }
    final result = await _searchBooksPageUseCase(SearchBooksPageParameters(
      page: currentBooksPage?.nextPage ?? 1,
      searchQuery: query,
      cancelOnly: false,
    ));
    result.fold(
      (failure) => emit(DataStatusExtension.fromFailure(failure, !paginate)),
      (booksPage) {
        print('booksPage: $booksPage');
        currentBooksPage = booksPage?.copyWith(oldBooksPage: currentBooksPage);
        return emit(DataStatus.success);
      },
    );
  }
}
