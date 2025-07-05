import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/router/routes.dart';
import 'tabs/home_tab/home_tab.dart';
import 'tabs/saved_tab/saved_tab.dart';

/// The main layout screen for the app, providing navigation between tabs.
///
/// Displays a custom bottom navigation bar and manages tab switching
/// between [HomeTab] and [SavedTab] using an [IndexedStack].
class LayoutScreen extends StatelessWidget {
  /// Creates a [LayoutScreen] with the given tab [index] selected.
  const LayoutScreen({super.key, required this.index});

  /// The currently selected tab index.
  final int index;

  /// Maps route locations to their corresponding tab indices.
  static const locationToIndex = {
    Routes.home: 0,
    Routes.saved: 1
  };

  /// Builds the custom bottom navigation bar.
  ///
  /// Highlights the selected tab and navigates to the appropriate route
  /// when a tab is pressed.
  Widget _buildNavigationBar(BuildContext context, int index) {
    final isFirstSelected = index == 0;
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withAlpha(250),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isFirstSelected
                        ? CupertinoIcons.house_fill
                        : CupertinoIcons.house,
                    color: isFirstSelected
                        ? context.colorScheme.secondary
                        : context.colorScheme.tertiary,
                    size: 27,
                  ),
                  onPressed: () {
                    context.go(Routes.home);
                  },
                ),
                VerticalDivider(
                  indent: 8,
                  endIndent: 8,
                  color: context.colorScheme.secondary.withAlpha(150),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isFirstSelected
                        ? CupertinoIcons.bookmark
                        : CupertinoIcons.bookmark_fill,
                    color: isFirstSelected
                        ? context.colorScheme.tertiary
                        : context.colorScheme.secondary,
                    size: 27,
                  ),
                  onPressed: () {
                    context.go(Routes.saved);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: IndexedStack(
        index: index,
        children: [
          const HomeTab(),
          const SavedTab(),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(context,index),
    );
  }
}
