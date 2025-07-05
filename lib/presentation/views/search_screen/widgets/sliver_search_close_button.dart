import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
/// A sliver widget that provides a close button for the search screen.
class SliverSearchCloseButton extends StatelessWidget {
  const SliverSearchCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  PinnedHeaderSliver(
      child: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton.filled(
                padding: const EdgeInsets.all(12),
                child: const Icon(CupertinoIcons.clear),
                onPressed: () => context.pop()),
          ),
        ),
      ),
    );
  }
}
