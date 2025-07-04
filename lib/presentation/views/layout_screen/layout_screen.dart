import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/router/routes.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key, required this.child});
  final Widget child;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = 0;
     super.initState();
  }
  _buildNavigationBar(int index) {
    final isFirstSelected = index == 0;
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withAlpha(250),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child:  Icon(isFirstSelected ? CupertinoIcons.house_fill : CupertinoIcons.house,color:isFirstSelected? context.colorScheme.secondary : context.colorScheme.tertiary,size: 27,),
                  onPressed: () {
                    selectedIndex = 0;
                    context.go(Routes.home);
                  },
                ),
                VerticalDivider(
                  indent: 8,
                  endIndent: 8,
                  color: context.colorScheme.secondary.withAlpha(150),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child:  Icon(isFirstSelected ? CupertinoIcons.bookmark : CupertinoIcons.bookmark_fill,color:isFirstSelected? context.colorScheme.tertiary : context.colorScheme.secondary,size: 27,),
                  onPressed: () {
                    selectedIndex = 1;
                    context.go(Routes.saved);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: widget.child,
      bottomNavigationBar:_buildNavigationBar(selectedIndex) ,
    );
  }
}
