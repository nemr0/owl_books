
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.sectionTitle,
  });

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('$sectionTitle:',
          style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onPrimary,
              fontSize: 19
          ),

        ),
      ),
    );
  }
}
