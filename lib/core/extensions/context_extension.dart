import 'package:flutter/material.dart';
extension ContextExtension on BuildContext {
 double get height => MediaQuery.sizeOf(this).height;
 double get width => MediaQuery.sizeOf(this).width;
 EdgeInsets get padding => MediaQuery.paddingOf(this);
 ThemeData get theme => Theme.of(this);
 ColorScheme get colorScheme => Theme.of(this).colorScheme;
}