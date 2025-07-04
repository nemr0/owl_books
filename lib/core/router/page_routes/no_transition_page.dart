import 'package:flutter/material.dart';

class NoTransitionPage<T> extends PageRouteBuilder<T> {
  final Widget child;

  NoTransitionPage({
    required this.child,
    super.settings,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}