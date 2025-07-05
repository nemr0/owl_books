import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/netwrok_status.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../managers/search_books_cubit/search_books_cubit.dart';

/// A sliver widget that displays a floating search text field with debounce functionality.
///
/// This widget is intended to be used in a scrollable area (such as a CustomScrollView)
/// and provides a search bar that floats and animates its padding based on scroll offset.
/// It integrates with [SearchBooksCubit] to perform debounced search queries.
class SliverFloatingTextField extends StatefulWidget {
  const SliverFloatingTextField({super.key});

  @override
  State<SliverFloatingTextField> createState() =>
      _SliverFloatingTextFieldState();
}

/// State for [SliverFloatingTextField].
///
/// Handles the text controller, debounce logic, and UI updates based on the search state.
class _SliverFloatingTextFieldState extends State<SliverFloatingTextField> {
  /// Timer used for debouncing search input.
  Timer? _debounce;

  /// Controller for the search text field.
  late final TextEditingController controller;

  /// Tracks whether the text field is empty.
  late bool isEmpty;

  /// Listener to update [isEmpty] state when the text changes.
  listener(){
    if(controller.text.isEmpty && !isEmpty){
      setState(() {
        isEmpty = true;
      });
    } else if(controller.text.isNotEmpty && isEmpty){
      setState(() {
        isEmpty = false;
      });
    }
  }

  @override
  void initState() {
    isEmpty = true;
    controller = TextEditingController()..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return BlocListener<SearchBooksCubit,DataStatus>(
      // Only listen when state is initial or success.
      listenWhen: (_,state)=>state.isInitial || state.isSuccess,
      listener: (BuildContext context, state) {
        if(state.isInitial){
          _debounce?.cancel();
          controller.clear();
        } else if(state.isSuccess && controller.text.isEmpty){
          context.read<SearchBooksCubit>().clear();
        }
      },
      child: SliverLayoutBuilder(builder: (context, constraints) {
        final collapsed = constraints.scrollOffset > 100;
        return SliverFloatingHeader(
          snapMode: FloatingHeaderSnapMode.scroll,
          child: ColoredBox(
            color: colorScheme.onPrimary,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 600),
              padding: const EdgeInsets.all(8.0).copyWith(
                  top: collapsed ? context.padding.top + 60 : 0, bottom: 0),
              child: TextFormField(
                controller: controller,
                autofocus: true,
                onChanged: (value) async {
                   await context.read<SearchBooksCubit>().cancel();
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  // Debounce search input by 700ms.
                  _debounce = Timer(const Duration(milliseconds: 700), () {
                    final cubit = context.read<SearchBooksCubit>();
                    if (value.isNotEmpty) {
                      cubit.searchBooks(value);
                    } else {
                      cubit.clear();
                    }
                  });
                },
                onTap: (){},
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  suffix: controller.value.text.isEmpty?null:CupertinoButton(
                    sizeStyle: CupertinoButtonSize.small,
                    padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.clear_circled_solid),
                      onPressed: () => context.read<SearchBooksCubit>().clear()),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: colorScheme.primary.withAlpha(50),
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  fillColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
