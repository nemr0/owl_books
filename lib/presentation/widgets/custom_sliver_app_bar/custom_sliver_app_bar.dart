
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/generated/assets.gen.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key,  this.inverted = true});
  final bool inverted;

  getBackgroundColor(ColorScheme colorScheme,bool collapsed) {
    return inverted ? collapsed? colorScheme.primary :colorScheme.secondary :collapsed?colorScheme.secondary: colorScheme.primary;
  }
  getLogo() => inverted
      ? Assets.shared.logoLight.image()
      : Assets.shared.logoDark.image();

  getForegroundColor(ColorScheme colorScheme, bool collapsed) {
    return collapsed ?inverted? colorScheme.onPrimary: colorScheme.primary : inverted?colorScheme.primary: colorScheme.onPrimary;
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

            actions: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child:  Icon(Icons.search,color: getForegroundColor(context.colorScheme, collapsed),size: 26,),
                onPressed: () {
                  // TODO: handle search tap
                },
              ),
            ],

            flexibleSpace:FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: collapsed ?  Text('Owl Books',style: context.textTheme.headlineMedium?.copyWith(color: getForegroundColor(context.colorScheme, collapsed) ),) : const Text(''),
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
