import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/typedef/typedefs.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../books_card/book_card.dart';

/// A widget that displays a grid view of books.
/// shared between the home page, saved page and search page.
/// used for loading, paginating and displaying books.
///
class BooksPageGridViewSliver extends StatelessWidget {
  const BooksPageGridViewSliver({
    super.key,
     this.booksPage = BooksPage.empty,
    required this.loading,
    required this.paginating,
    this.onBookTap,
  }) : assert(
         !loading || !paginating,
         'Cannot be both loading and paginating at the same time.',
       );

  final BooksPage booksPage;
  final bool loading;
  final bool paginating;
  final OnBookTap? onBookTap;

  static const double _tabletBreakpoint = 600;


  /// Returns a SliverGridDelegateWithFixedCrossAxisCount configured to:
  ///  • 2 columns on phones in portrait
  ///  • 3 columns on phones in landscape
  ///  • 4 columns on tablets in portrait
  ///  • 5 columns on tablets in landscape
  SliverGridDelegateWithFixedCrossAxisCount getResponsiveGridDelegate({
    required double deviceWidth,
    required Orientation orientation,
    double childAspectRatio = 0.7,
    double crossAxisSpacing = 12.0,
    double mainAxisSpacing = 12.0,
    int phonePortraitCount = 2,
    int phoneLandscapeCount = 3,
    int tabletPortraitCount = 4,
    int tabletLandscapeCount = 5,
  }) {
    final bool isTablet = deviceWidth >= _tabletBreakpoint;

    final int crossAxisCount = isTablet
        ? (orientation == Orientation.portrait
              ? tabletPortraitCount
              : tabletLandscapeCount)
        : (orientation == Orientation.portrait
              ? phonePortraitCount
              : phoneLandscapeCount);

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
    );
  }

  /// Returns the current column count based on the device width and orientation.
 int getCurrentColumnCount({
    required double deviceWidth,
    required Orientation orientation,
    int phonePortraitCount = 2,
    int phoneLandscapeCount = 3,
    int tabletPortraitCount = 4,
    int tabletLandscapeCount = 5,
  }) {
    return deviceWidth >= _tabletBreakpoint
        ? (orientation == Orientation.portrait
              ? tabletPortraitCount
              : tabletLandscapeCount)
        : (orientation == Orientation.portrait
              ? phonePortraitCount
              : phoneLandscapeCount);
  }
 /// Returns the current child count based on the book length and whether pagination is enabled.
 int getCurrentChildCount(int bookLength, bool paginating){
    if (paginating) return bookLength + 1;
    return bookLength;
  }
  @override
  Widget build(BuildContext context) {
    final books =booksPage == BooksPage.empty?  List.generate(39, (_)=>Book.empty): booksPage.books;
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20.0,left:12,right:12,bottom: 20.0),
      sliver: SliverGrid(
        gridDelegate: getResponsiveGridDelegate(
          deviceWidth: context.width,
          orientation: context.orientation,
        ),
        delegate: SliverChildBuilderDelegate(
          (_, int index) {
            if (index >= books.length) {
              return BookCard(coverImageUrl: Book.empty.coverUrl,
                loading: paginating || loading,
              );
            }
            return BookCard(coverImageUrl: books[index].coverUrl,loading: loading,);
          },
          childCount: getCurrentChildCount(books.length, paginating),
        ),
      ),
    );
  }
}
