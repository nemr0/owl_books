import 'package:flutter/cupertino.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../domain/entities/contributor_entity.dart';

class ContributorChip extends StatefulWidget {
  const ContributorChip({super.key, required this.contributor});

  final Contributor contributor;

  @override
  State<ContributorChip> createState() => _ContributorChipState();
}

class _ContributorChipState extends State<ContributorChip> {
  late bool expanded;
  final GlobalKey _globalKey = GlobalKey();
  double titleWidth = 0;
  @override
  void initState() {
    expanded = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _globalKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        titleWidth = renderBox.size.width;
      });
    });
    super.initState();
  }
  static const Radius _borderRadius =  Radius.circular(10);
  static const Duration _duration =  Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: expanded?Duration.zero:Duration(milliseconds: _duration.inMilliseconds+300),
          key: _globalKey,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            border: Border.all(color: context.colorScheme.onSecondaryContainer),
            borderRadius:expanded?const BorderRadius.vertical(top: _borderRadius): const BorderRadius.all(_borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.contributor.name,
                style: context.textTheme.labelLarge,
              ),
              if(widget.contributor.birthYear != null || widget.contributor.deathYear!=null)
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.small,
                padding: const EdgeInsets.only(left: 3),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                child: Icon(
                  expanded
                      ? CupertinoIcons.arrow_up_circle_fill
                      : CupertinoIcons.arrow_down_circle_fill,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
          _DateOfLive(duration:_duration,borderRadius: _borderRadius, contributor: widget.contributor, width: titleWidth,expanded: expanded),
      ],
    );
  }
}

class _DateOfLive extends StatelessWidget {
  const _DateOfLive({
    required Radius borderRadius,
    required this.contributor,  required this.expanded, required this.width, required this.duration,
  }) : _borderRadius = borderRadius;

  final Radius _borderRadius;
  final Contributor contributor;
  final bool expanded;
  final double width;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width:width,
      height: expanded ? 50 : 0,
      padding: expanded?const EdgeInsets.all(8.0):EdgeInsets.zero,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius:  BorderRadius.vertical(bottom: _borderRadius),
      ),
      duration: duration,
      child: RichText(



        textAlign: TextAlign.justify, text: TextSpan(
          style: context.textTheme.bodyMedium,
        children: [
          if(contributor.birthYear!=null)TextSpan(text: 'From: ${contributor.birthYear}',),
          if(contributor.birthYear!=null) const TextSpan(text: '\n',),
          if(contributor.deathYear!=null)TextSpan(text: 'To: ${contributor.deathYear}',),
        ]
      ),
      ),
    );
  }
}
