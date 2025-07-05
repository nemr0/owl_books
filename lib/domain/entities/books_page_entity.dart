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
  /// An optional search query that may have been used to filter the books.
  final String? searchQuery;
  /// Creates a [BooksPage] instance with the given properties.
  const BooksPage( {
    required this.totalCount,
    required this.nextPage,
    required this.books,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [
    totalCount,
    nextPage,
    books,
    searchQuery,
  ];
  static const BooksPage empty = BooksPage(
    totalCount: 0,
    nextPage: null,
    books: [],
    searchQuery: null,
  );
  BooksPage copyWith({BooksPage? oldBooksPage,int? nextPage}) {

    return BooksPage(
      totalCount: totalCount,
        nextPage: nextPage ?? this.nextPage,
      books: [...oldBooksPage?.books ?? [], ...books],
      searchQuery: searchQuery
    );
  }
}
