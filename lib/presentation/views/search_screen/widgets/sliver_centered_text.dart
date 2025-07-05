import 'package:flutter/cupertino.dart';

import '../../../../core/extensions/context_extension.dart';
/// A sliver widget that displays a centered text message.
class SliverCenteredText extends StatelessWidget {
  const SliverCenteredText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
   return SliverToBoxAdapter(
      child: SizedBox(
        height: context.height / 1.5,
        child: Center(
          child: Text(
            text,
            style: context.textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
