import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/book_entity.dart';
import '../../presentation/views/books_details_screen/books_details_screen.dart';
import '../../presentation/views/layout_screen/layout_screen.dart';
import '../../presentation/views/layout_screen/tabs/home_tab/home_tab.dart';
import '../../presentation/views/layout_screen/tabs/saved_tab/saved_tab.dart';
import 'routes.dart';
final _rootNavigatorKey  = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      builder: (_, _, child) => LayoutScreen(child: child),
      routes: [
        GoRoute(
          path: Routes.home,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeTab()),
        ),
        GoRoute(
          path: Routes.saved,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SavedTab()),
        ),

      ],
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,  // push ABOVE the shell
      path: Routes.bookDetails,
      pageBuilder: (_, state) => CupertinoPage(
        fullscreenDialog: true,
        child: BooksDetailsScreen(
          book: (state.extra as Book?) ?? Book.empty,
        ),
      ),
    ),

  ],
);
