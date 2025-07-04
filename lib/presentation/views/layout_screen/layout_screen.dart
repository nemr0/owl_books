import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/router/routes.dart';
import 'tabs/home_tab/home_tab.dart';
import 'tabs/saved_tab/saved_tab.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key, required this.index});
  final int index;
  static const locationToIndex = {
    Routes.home: 0,
    Routes.saved: 1
  };
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
