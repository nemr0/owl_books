import 'package:equatable/equatable.dart';

import 'book_entity.dart';

/// Represents a paginated collection of books, including pagination metadata.
class BooksPage extends Equatable{
  /// The total number of books available.
  final int totalCount;

  /// The next page number, if available.
  final int? nextPage;

  /// The list of books on the current page.
  final List<Book> books;

  /// Creates a [BooksPage] instance with the given properties.
  const BooksPage({
    required this.totalCount,
    required this.nextPage,
    required this.books,
  });

  @override
  List<Object?> get props => [
    totalCount,
    nextPage,
    books,
  ];
}
