import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enums/netwrok_status.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../../../domain/usecases/search_books_page_usecase.dart';
/// A Cubit that manages the state of the books search functionality.
/// It interacts with a SearchBooksPageUseCase to retrieve books data,
/// supports search, pagination and cancellation of ongoing search requests.
@injectable
class SearchBooksCubit extends Cubit<DataStatus> {
  SearchBooksCubit(this._searchBooksPageUseCase) : super(DataStatus.initial);

  static SearchBooksCubit get factory => ServiceLocator.get<SearchBooksCubit>();

  final SearchBooksPageUseCase _searchBooksPageUseCase;
  /// Holds the current page of books retrieved by the search.
  BooksPage? currentBooksPage;
  /// Cancels the current search request by invoking the use case with
  /// cancelOnly set to true.
  Future<void> cancel() async {
    await _searchBooksPageUseCase(
    SearchBooksPageParameters(
        page: (currentBooksPage?.nextPage ?? 2) - 1,
        cancelOnly: true,
        searchQuery: currentBooksPage?.searchQuery),
    );
  }
  /// Clears the current search query and cancels any ongoing request,
  /// resetting the state to initial.
  void clear() async {
    await cancel();
    currentBooksPage = null;
    emit(DataStatus.initial);
  }
  /// Paginates the search results if available by requesting the next page.
  /// Does nothing if there is no current books page or next page.
  Future<void> paginate() async {
    if (currentBooksPage == null || currentBooksPage!.nextPage == null) return;
    if (currentBooksPage?.searchQuery != null) {
      await searchBooks(currentBooksPage!.searchQuery!, true);
    }
  }
  /// Searches for books based on the provided query.
  /// If paginate is true, appends results to current books page.
  /// Emits loading, paginating and success/error states accordingly.
  Future<void> searchBooks(String query, [bool paginate = false]) async {
    if (state == DataStatus.loading || state == DataStatus.paginating) return;
    emit(paginate ? DataStatus.paginating : DataStatus.loading);
    if (currentBooksPage != null && currentBooksPage!.searchQuery != query) {
      currentBooksPage = null;
    }
    final result = await _searchBooksPageUseCase(SearchBooksPageParameters(
      page: currentBooksPage?.nextPage,
      searchQuery: query,
      cancelOnly: false,
    ));
    result.fold(
      (failure) => emit(DataStatusExtension.fromFailure(failure, !paginate)),
      (booksPage) {
        currentBooksPage = booksPage?.copyWith(oldBooksPage: currentBooksPage);
        return emit(DataStatus.success);
      },
    );
  }
}
