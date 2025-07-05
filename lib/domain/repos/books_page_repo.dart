import 'package:dartz/dartz.dart';

import '../../core/failures/failure.dart';
import '../entities/books_page_entity.dart';

/// Repository contract for fetching paginated books data.
///
/// Implementations should provide logic to fetch a [BooksPage] from a data source,
/// supporting optional search and cancellation.
abstract class BooksPageRepository{
  /// Fetches a page of books, optionally filtered by [searchQuery].
  ///
  /// [page]: The page number to fetch.
  /// [searchQuery]: Optional search string to filter books.
  /// [cancelOnly]: If true, only cancels ongoing requests without fetching.
  ///
  /// Returns either a [Failure] or a [BooksPage] (nullable).
  Future<Either<Failure,BooksPage?>> getBooksPage({
    required int? page,
    String? searchQuery,
    required bool cancelOnly,
  });
}