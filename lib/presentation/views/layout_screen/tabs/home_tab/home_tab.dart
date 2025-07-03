import 'package:flutter/material.dart';

import '../../../../managers/get_books_cubit/get_books_cubit.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    GetBooksCubit.get(context).getBooksPagePaginated();
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home!'));
  }
}
