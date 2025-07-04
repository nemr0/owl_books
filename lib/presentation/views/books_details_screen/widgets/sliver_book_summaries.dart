import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import 'section_title.dart';

class SliverBookSummaries extends StatelessWidget {
  const SliverBookSummaries({super.key, required this.summaries});

  final List<String> summaries;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodyLarge?.copyWith(
      color: context.colorScheme.onPrimary,
    );
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Builder(
          builder: (context) {
            if (summaries.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(sectionTitle: 'Summary'),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: summaries
                        .map(
                          (summary) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: AnimatedReadMoreText(
                              summary,
                              maxLines: 4,
                              readMoreText: 'Read more...',
                              readLessText: '...Collapse',
                              textStyle: style,
                              buttonTextStyle: style?.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
