import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enums/netwrok_status.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../../../domain/usecases/get_books_page_usecase.dart';
/// This Cubit is responsible for managing the state of the books page.
@injectable
class GetBooksCubit extends Cubit<DataStatus> {
  GetBooksCubit(this._getBooksPageUseCase) : super(DataStatus.initial);
  final GetBooksPageUseCase _getBooksPageUseCase;
  static GetBooksCubit get factory => ServiceLocator.get<GetBooksCubit>();
  BooksPage? currentBooksPage;
  /// This method is used to get the initial books page and refresh states.
  Future<void> getBooksPageInitial([bool force = false]) async{
    if(currentBooksPage != null && !force)return;
    await getBooksPagePaginated(false);
  }

  /// called on pagination, it will get the next page of books.
  /// If [isFirst] is true, it will emit loading state, otherwise it will emit paginating state.
  /// It will also update the currentBooksPage with the new page.
  /// called from [getBooksPageInitial] on First load and on Refresh.
 Future<void> getBooksPagePaginated([bool paginate = false]) async {
    if(state == DataStatus.loading || state == DataStatus.paginating) return;
    emit(paginate?DataStatus.paginating:DataStatus.loading);
    final result = await _getBooksPageUseCase(currentBooksPage?.nextPage);
    result.fold(
      (failure) => emit(DataStatusExtension.fromFailure(failure,!paginate)),
      (booksPage) {
        // add the new books to the current page
        currentBooksPage = booksPage?.copyWith(oldBooksPage: currentBooksPage);
        emit(DataStatus.success);
      },
    );
  }
}