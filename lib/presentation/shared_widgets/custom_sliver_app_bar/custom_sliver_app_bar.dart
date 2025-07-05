
import 'package:flutter/cupertino.dart' show CupertinoButton, CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/generated/assets.gen.dart';
import '../../../core/router/routes.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.onScrollUp});
  final VoidCallback onScrollUp;
  Color getBackgroundColor(ColorScheme colorScheme, bool collapsed) {

      return collapsed ? colorScheme.primary : colorScheme.secondary;

  }
  getLogo() =>Assets.shared.logoLight.image();

  Color getForegroundColor(ColorScheme colorScheme, bool collapsed) {
    return collapsed ? colorScheme.onPrimary : colorScheme.primary;
  }
  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
        builder: (context, SliverConstraints constraints) {
          final collapsed = constraints.scrollOffset > 250;
          return SliverAppBar(
            pinned: true,
            floating: false,
            stretch: false,
            expandedHeight: 350,
            backgroundColor: getBackgroundColor(context.colorScheme,collapsed),
            surfaceTintColor: Colors.transparent,

            actions: [
              CupertinoButton(
                padding: const EdgeInsets.only(bottom: 15),

                child:  Icon(Icons.search,color: getForegroundColor(context.colorScheme, collapsed),size: 26,),
                onPressed: () {
                  context.push(Routes.search);
                },
              ),
            ],

            flexibleSpace:FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              title: collapsed ?  Row(

                children: [
                  CupertinoButton(
                      padding: EdgeInsets.zero, onPressed: onScrollUp,
                      child: Icon(CupertinoIcons.arrow_up_circle,color: context.colorScheme.onPrimary,size: 27,)),
                  const Spacer(flex: 4,),

                  Assets.shared.logoDark.image(height: 35,width: 35,),
                  const SizedBox(width: 3,),
                  Text('Owl Books',style: context.textTheme.headlineMedium?.copyWith(color: getForegroundColor(context.colorScheme, collapsed) ),),
                  const Spacer(flex: 6,),

                ],
              ) : const SizedBox.shrink(),
              centerTitle: true,


              background: Container(
                color: getBackgroundColor(context.colorScheme,collapsed),
                child: SafeArea(
                  child: Center(
                    child: getLogo(),
                  ),
                ),
              ),


            ),
          );
        }
    );
  }
}
