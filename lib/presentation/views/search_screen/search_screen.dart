import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/netwrok_status.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/router/routes.dart';
import '../../../domain/entities/books_page_entity.dart';
import '../../managers/search_books_cubit/search_books_cubit.dart';
import '../../shared_widgets/sliver_books_page_gridview/sliver_books_page_gridview.dart';
import '../../shared_widgets/error_widgets/error_notifications.dart';
import 'widgets/sliver_centered_text.dart';
import 'widgets/sliver_floating_text_field.dart';
import 'widgets/sliver_search_close_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ScrollController controller;
  Timer? _debounce;
  late bool scrolledDown;
  @override
  void initState() {
    scrolledDown = false;
    controller = ScrollController()..addListener(edgeListener);
    super.initState();
  }
/// Listens to the scroll controller to detect when the user has scrolled down
  void edgeListener() {
    if(controller.offset > 100 && !scrolledDown) {
      setState(() {
        scrolledDown = true;
      });
    }
    if(controller.offset <= 100 && scrolledDown) {
      setState(() {
        scrolledDown = false;
      });
    }
    if (controller.offset >= controller.position.maxScrollExtent - 400 &&
        _debounce == null) {
      _debounce = Timer(const Duration(milliseconds: 300), () {
        if (mounted) {
          _debounce = null;
          context.read<SearchBooksCubit>().paginate();
        }
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(edgeListener);
    controller.dispose();
    super.dispose();
  }
  /// A [FloatingActionButton] to scroll up easily.
  /// shows only on [scrolledDown]
  Widget? buildFAB(bool scrolledDown,Color background){
    if(!scrolledDown) return null;
    return FloatingActionButton.small(
      onPressed: onScrollUp,
      backgroundColor: background,
      child: const Icon(CupertinoIcons.arrow_up),
    );
  }
  onScrollUp()=> controller.animateTo(
    0,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Scaffold(
      floatingActionButton: buildFAB(scrolledDown,colorScheme.primary),
      backgroundColor: colorScheme.tertiary,
      body: BlocListener<SearchBooksCubit, DataStatus>(
        listener: (context, state) {
          if(state.isLoading){
            onScrollUp();
          }
         else if (state.isPaginatingServerError) {
            ErrorNotification.instance.showServerErrorToast(context);
          } else if (state.isPaginatingNoInternet) {
            ErrorNotification.instance.showNetworkErrorToast(context);
          }
        },
        listenWhen: (_,state) => state.isLoading || state.isPaginatingServerError || state.isPaginatingNoInternet,
        child: CustomScrollView(
          controller: controller,
          physics: const ClampingScrollPhysics(),
          slivers: [
            const SliverSearchCloseButton(),
            const SliverFloatingTextField(),
            BlocBuilder<SearchBooksCubit, DataStatus>(
                builder: (context, state) {
                  if (state.isInitial) {
                    return const SliverCenteredText(
                      text: 'Search for something!',
                    );
                  }
                  final booksPage =
                      context.watch<SearchBooksCubit>().currentBooksPage;
                  if (state.isSuccess &&
                      booksPage != null &&
                      booksPage.books.isEmpty == true) {
                    return const SliverCenteredText(
                      text: 'Couldn\'t find any books for your search term.',
                    );
                  }
                  return SliverBooksPageGridView(
                    loading: state.isLoading,
                    paginating: state.isPaginating,
                    booksPage: booksPage ?? BooksPage.empty,
                    onBookTap: (book) =>
                        context.push(Routes.bookDetails, extra: book),
                  );
                })
          ],
        ),
      ),
    );
  }
}
