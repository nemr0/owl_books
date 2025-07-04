import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/router_config.dart';
import 'core/service_locator/service_locator.dart';
import 'core/theme/theme.dart';
import 'presentation/managers/get_books_cubit/get_books_cubit.dart';

void main() {
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => GetBooksCubit.factory)],
      child: MaterialApp.router(
        title: 'Owl Books',
        theme: AppTheme.instance.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
