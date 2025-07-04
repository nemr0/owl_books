import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/typedef/typedefs.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../books_page_gridview/books_page_gridview.dart';
import '../custom_sliver_app_bar/custom_sliver_app_bar.dart';
/// A widget that displays a paginated grid view of books.
/// This widget is used in the home tab, saved tab, and search tab.
/// It handles loading, pagination, refresh, and book selection.
class BooksPageScrollView extends StatelessWidget {
  const BooksPageScrollView({
    super.key,
    required this.loading,
    required this.paginating,
    this.onBookTap,
    this.booksPage = BooksPage.empty,
    this.showSearchButton = true,
    this.onRefresh,
    this.inverted = true, required this.controller,
  });

  final bool loading;
  final bool paginating;
  final bool showSearchButton;
  final OnBookTap? onBookTap;
  final BooksPage booksPage;
  final Future<void> Function()? onRefresh;
  final bool inverted;
  final ScrollController controller;
  Color getContainerColor(ColorScheme colorScheme,bool inverted) {
    return inverted
        ? colorScheme.primary
        : colorScheme.secondary;
  }
  Widget getRefreshIndicator(RefreshIndicatorMode mode,ColorScheme colorScheme,TextTheme textTheme,bool inverted) {
    if(mode == RefreshIndicatorMode.armed ||
        mode == RefreshIndicatorMode.refresh ||
        mode == RefreshIndicatorMode.done) {
      return  CircularProgressIndicator.adaptive(backgroundColor:inverted ? colorScheme.onPrimary : colorScheme.onSecondary ,);
    } else {
      return Text(
        'Pull to refresh',
        style: textTheme.bodyLarge?.copyWith(
          color: inverted
              ? colorScheme.onPrimary
              : colorScheme.onSecondary,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final topPadding = context.padding.top;
    return CustomScrollView(
      controller: controller,
      slivers: [CupertinoSliverRefreshControl(
        refreshTriggerPullDistance: topPadding + 75,
        refreshIndicatorExtent: topPadding + 75,
        builder: (_, mode, _, _, _) {
          return Container(
            color: getContainerColor(context.colorScheme, inverted),
            padding: EdgeInsets.only(top:context.padding.top + 10),
            child: Center(
              child: getRefreshIndicator(
                mode,
                context.colorScheme,
                context.textTheme,
                inverted,
              ),
            ),
          );
        },
        onRefresh: onRefresh,
      ),
        // 1) This adapter sits right under the AppBar…
        CustomSliverAppBar(inverted: inverted,onScrollUp: (){
          controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        },),


        BooksPageGridViewSliver(
          booksPage: booksPage,
          loading: loading,
          paginating: paginating,
          onBookTap: onBookTap,
        ),
      ],
    );
  }
}
