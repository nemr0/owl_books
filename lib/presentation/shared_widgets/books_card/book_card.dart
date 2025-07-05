import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/typedef/typedefs.dart';
import '../../../domain/entities/book_entity.dart';
import '../image_from_network_widget/image_from_network_widget.dart';

/// A card widget that displays a book cover image and handles tap interactions.
///
/// Shows a loading skeleton when [loading] is true. Tapping the card triggers [onBookTap]
/// if provided, and animates the card scale for feedback.
class BookCard extends StatefulWidget {
  /// Creates a [BookCard].
  ///
  /// [book] is required. [onBookTap] is called when the card is tapped.
  /// [loading] shows a skeleton placeholder if true.
  /// [boxFit] controls how the image is fitted inside the card.
  const BookCard({
    super.key,
    this.onBookTap,
    required this.book,
    this.loading = false,  this.boxFit = BoxFit.contain,
  });

  /// Callback when the book card is tapped.
  final OnBookTap? onBookTap;

  /// The book entity to display.
  final Book book;

  /// Whether to show a loading skeleton.
  final bool loading;

  /// How to inscribe the image into the space allocated.
  final BoxFit boxFit;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  /// Duration for the scale animation on tap.
  static const _scaleDuration = Duration(milliseconds: 200);

  /// Whether the card is currently pressed (animating).
  late bool pressed;

  @override
  void initState() {
   pressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.book.id == 0 ? UniqueKey().toString() : widget.book.id.toString(),
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
