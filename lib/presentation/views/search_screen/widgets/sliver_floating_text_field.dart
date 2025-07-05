import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/netwrok_status.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../managers/search_books_cubit/search_books_cubit.dart';

class SliverFloatingTextField extends StatefulWidget {
  const SliverFloatingTextField({super.key});

  @override
  State<SliverFloatingTextField> createState() =>
      _SliverFloatingTextFieldState();
}

class _SliverFloatingTextFieldState extends State<SliverFloatingTextField> {
  Timer? _debounce;
  late final TextEditingController controller;
  late bool isEmpty;
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
      listenWhen: (_,state)=>state.isInitial,
      listener: (BuildContext context, state) {
        if(state.isInitial){
          _debounce?.cancel();
          controller.clear();
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
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
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
