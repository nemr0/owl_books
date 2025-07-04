import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../domain/entities/book_entity.dart';
import 'widgets/sliver_book_details_header.dart';
import 'widgets/sliver_book_summaries.dart';
import 'widgets/sliver_list_contributors.dart';

class BooksDetailsScreen extends StatelessWidget {
  const BooksDetailsScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverBookDetailsHeader(book: book),

          SliverListContributors(
            contributors: book.authors,
            sectionTitle: 'Author(s)',
          ),
          SliverListContributors(
            contributors: book.translators,
            sectionTitle: 'Translators(s)',
          ),
          SliverBookSummaries(summaries: book.summaries,),
          const SliverToBoxAdapter(
            child: SizedBox(height: 50,),
          ),
        ],
      ),
    );
  }
}
