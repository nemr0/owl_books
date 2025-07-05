import '../../domain/entities/books_page_entity.dart';
import 'book_model.dart';

extension BooksPageModel on BooksPage {
  static int? _extractPageNumber(String? url) {
    final page = Uri.tryParse(url??'')?.queryParameters['page'];
    return page != null ? int.tryParse(page) : null;
  }
  static BooksPage? fromJson(Map<String, dynamic>? json,{String? searchQuery}) {
    if (json == null) return null;
    return BooksPage(
      totalCount: json['count'],
      nextPage: _extractPageNumber(json['next']),
      searchQuery: searchQuery,
      books: (json['results'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
