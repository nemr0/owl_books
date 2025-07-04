import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/netwrok_status.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../domain/entities/books_page_entity.dart';
import '../../../../managers/get_books_cubit/get_books_cubit.dart';
import '../../../../shared_widgets/books_page/books_page_screen.dart';
import '../../../../shared_widgets/error_widgets/error_notifications.dart';
import '../../../../shared_widgets/error_widgets/network_error_widget.dart';
import '../../../../shared_widgets/error_widgets/server_error_widget.dart';

/// The main tab displaying a paginated list of books.
///
/// Handles infinite scrolling, pull-to-refresh, and error states.
/// Integrates with [GetBooksCubit] for state management.
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  /// Controller for the scrollable book list.
  late final ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(edgeListener);
    // Fetch initial page of books.
    context.read<GetBooksCubit>().getBooksPageInitial();
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(edgeListener);
    controller.dispose();
    super.dispose();
  }

  /// Timer for debouncing pagination requests.
  Timer? _debounce;

  /// Listens for scroll events to trigger pagination when near the bottom.
  void edgeListener() {
    if (controller.offset >= controller.position.maxScrollExtent - 400 && _debounce == null) {

      _debounce = Timer(const Duration(milliseconds: 300), () {
        if (mounted) {
          _debounce = null;
          context.read<GetBooksCubit>().getBooksPagePaginated();
        }
      });
    }
  }
  /// Refreshes the book list by fetching the initial page.
  Future<void> onRefresh() async {
    await context.read<GetBooksCubit>().getBooksPageInitial(true);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetBooksCubit,DataStatus>(
     listener: (context,state){
       if(state.isPaginatingServerError) {
         ErrorNotification.instance.showServerErrorToast(context);
       } else if(state.isPaginatingNoInternet) {
         ErrorNotification.instance.showNetworkErrorToast(context);
       }

     },
     builder: (context,state){
      if(state.isNoInternet ) return  NetworkErrorWidget(onRefresh: onRefresh,);
      if(state.isServerError ) return  ServerErrorWidget(onRefresh: onRefresh,);

      final booksPage = context.watch<GetBooksCubit>().currentBooksPage;
      return BooksPageScreen(
        controller: controller,
        loading: state.isLoading || state.isInitial,
        paginating: state.isPaginating,
        onBookTap: (book) {
          context.push(Routes.bookDetails,extra: book);
        },
        booksPage:  booksPage ?? BooksPage.empty,
        onRefresh: onRefresh,
      );
    });
  }
}
