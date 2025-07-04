import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/book_entity.dart';
import '../../presentation/views/books_details_screen/books_details_screen.dart';
import '../../presentation/views/layout_screen/layout_screen.dart';
import '../../presentation/views/layout_screen/tabs/home_tab/home_tab.dart';
import '../../presentation/views/layout_screen/tabs/saved_tab/saved_tab.dart';
import 'routes.dart';


/// Two navigator keys: one for your shell, one for full-screen modals.
final _rootNavigatorKey  = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final heroController = HeroController();
/// Build the router
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.home,
  observers: [heroController,],
  routes: [

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return LayoutScreen(
          index: LayoutScreen.locationToIndex[state.matchedLocation] ?? 0,
        );
      },
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomeTab(),
        ),
        GoRoute(
          path: Routes.saved,
          builder: (context, state) => const SavedTab(),
        ),
      ],
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.bookDetails,
      pageBuilder: (context, state) {
        final book = state.extra as Book? ?? Book.empty;
        return CupertinoPage(
          fullscreenDialog: true,
            child: BooksDetailsScreen(book: book));
      },
    ),

  ],
);