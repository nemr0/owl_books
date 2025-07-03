import 'package:flutter/material.dart' show Placeholder, StatelessWidget, BuildContext, Widget;

import '../../../core/typedef/typedefs.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, this.onBookTap, this.coverImageUrl});
  final OnBookTap? onBookTap;
  final String? coverImageUrl;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
