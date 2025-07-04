import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/typedef/typedefs.dart';
import '../../../domain/entities/book_entity.dart';
import '../image_from_network_widget/image_from_network_widget.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    super.key,
    this.onBookTap,
    required this.book,
    this.loading = false,  this.boxFit = BoxFit.contain,
  });

  final OnBookTap? onBookTap;
  final Book book;
  final bool loading;
  final BoxFit boxFit;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  static const _scaleDuration = Duration(milliseconds: 200);
  late bool pressed;
  @override
  void initState() {
   pressed = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.book.id.toString(),
      child: GestureDetector(
        onTap: widget.onBookTap == null || widget.book == Book.empty ||
            widget.loading || pressed == true ? null : ()  async {
          setState(() {
            pressed = true;
          });
          await Future.delayed(_scaleDuration);
          widget.onBookTap?.call(widget.book);
          setState(() {
            pressed = false;
          });
          },
        child: AnimatedScale(
          duration: _scaleDuration,
          scale: !pressed? 1:.9,
          child: Skeleton.shade(
            shade: widget.loading,
            child: Container(
              decoration: ShapeDecoration(
                color:
                 context.colorScheme.secondary.withAlpha(50),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color:
                    context.colorScheme.primary.withAlpha(150),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: ImageFromNetwork(
                widget.book.coverUrl, loading: widget.loading,boxFit: widget.boxFit,),
            ),
          ),
        ),
      ),
    );
  }
}


