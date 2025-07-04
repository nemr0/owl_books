import 'package:go_router/go_router.dart';

import '../../presentation/views/layout_screen/layout_screen.dart';
import '../../presentation/views/layout_screen/tabs/home_tab/home_tab.dart';
import '../../presentation/views/layout_screen/tabs/saved_tab/saved_tab.dart';
import 'routes.dart';

final router = GoRouter(routes: [
  ShellRoute(
   builder: (_,_,child)=> LayoutScreen(child: child),
      routes: [
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => const NoTransitionPage(child: HomeTab()),
        routes: [
      ///TODO: Add book details route
    ]),
    GoRoute(
      path: Routes.saved,
      pageBuilder: (context, state) => const NoTransitionPage(child: SavedTab()),

    ),
  ]),

]);