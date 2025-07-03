import 'package:flutter/material.dart';

import '../../../core/typedef/typedefs.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../books_card/book_card.dart';

/// A widget that displays a grid view of books.
/// shared between the home page, saved page and search page.
class BooksPageGridView extends StatelessWidget {
  const BooksPageGridView({
    super.key,
    required this.booksPage,
    this.isLoading = false, this.isPaginating = false,  this.onBookTap,
  });

  final BooksPage booksPage;
  final bool isLoading;
  final bool isPaginating;
  final OnBookTap? onBookTap;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: booksPage.books.length,
      itemBuilder: (context, index) => BookCard(coverImageUrl:booksPage.books[index].coverUrl),
    );
  }
}