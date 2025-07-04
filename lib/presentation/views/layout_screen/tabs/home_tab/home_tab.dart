import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/netwrok_status.dart';
import '../../../../../domain/entities/books_page_entity.dart';
import '../../../../managers/get_books_cubit/get_books_cubit.dart';
import '../../../../widgets/book_page/books_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(edgeListener);
    context.read<GetBooksCubit>().getBooksPageInitial();
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(edgeListener);
    controller.dispose();
    super.dispose();
  }

  edgeListener() {
    if (controller.offset >= controller.position.maxScrollExtent - 100) {
      context.read<GetBooksCubit>().getBooksPagePaginated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBooksCubit,DataStatus>(builder: (context,state){
      if(state.isNoInternet || state.isServerError) return const SizedBox();

      final booksPage = context.watch<GetBooksCubit>().currentBooksPage;
      return BooksPageScrollView(
        controller: controller,
        loading: state.isLoading || state.isInitial,
        paginating: state.isPaginating,
        onBookTap: (book) {
          // TODO: Open Book Details Page.
        },
        booksPage: state.isSuccess ? booksPage ?? BooksPage.empty : BooksPage.empty,
        onRefresh: () async{
          await context.read<GetBooksCubit>().getBooksPageInitial(true);
        },
        inverted: true,
      );
    });
  }
}
