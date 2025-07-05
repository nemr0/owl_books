import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/book_entity.dart';
import '../../presentation/managers/search_books_cubit/search_books_cubit.dart';
import '../../presentation/views/books_details_screen/books_details_screen.dart';
import '../../presentation/views/layout_screen/layout_screen.dart';
import '../../presentation/views/layout_screen/tabs/home_tab/home_tab.dart';
import '../../presentation/views/layout_screen/tabs/saved_tab/saved_tab.dart';
import '../../presentation/views/search_screen/search_screen.dart';
import 'routes.dart';

/// Build the router
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    ShellRoute(
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
      path: Routes.search,
      // Instead of builder, use pageBuilder for custom transitions:
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          child: BlocProvider(
              create: (BuildContext context) => SearchBooksCubit.factory,
              child: const SearchScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {

            return SlideTransition(
              position: animation.drive(Tween<Offset>(
                begin: const Offset(0, -1), end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut))),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: Routes.bookDetails,
      pageBuilder: (context, state) {
        final book = state.extra as Book? ?? Book.empty;
        return CupertinoPage(
            fullscreenDialog: true, child: BooksDetailsScreen(book: book));
      },
    ),
  ],
);
