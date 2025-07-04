import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
extension ContextExtension on BuildContext {
 double get height => MediaQuery.sizeOf(this).height;
 double get width => MediaQuery.sizeOf(this).width;
 Orientation get orientation => MediaQuery.orientationOf(this);
 EdgeInsets get padding => MediaQuery.paddingOf(this);
 ThemeData get theme => Theme.of(this);
 TextTheme get textTheme => Theme.of(this).textTheme;
 ColorScheme get colorScheme => Theme.of(this).colorScheme;
 Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
 ShimmerEffect get shimmerEffect => ShimmerEffect(
  baseColor: colorScheme.secondary.withAlpha(120),
  highlightColor: colorScheme.onSecondaryContainer,
  duration: const Duration(seconds: 2),
 );
}