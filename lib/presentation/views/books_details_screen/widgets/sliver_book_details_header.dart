import 'dart:ui';

import 'package:flutter/cupertino.dart' show CupertinoButton, CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../shared_widgets/books_card/book_card.dart';
import '../../../shared_widgets/image_from_network_widget/image_from_network_widget.dart';

class SliverBookDetailsHeader extends StatelessWidget {
  const SliverBookDetailsHeader({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context,SliverConstraints constraints) {
        final collapsed = constraints.scrollOffset > 280;

        return SliverAppBar(
          expandedHeight: 420,
          pinned: true,
          surfaceTintColor: Colors.transparent,

          title: !collapsed? null : Text(
            book.title,
            style: context.textTheme.labelMedium?.copyWith(
              color: collapsed? context.colorScheme.surface:context.colorScheme.onPrimary,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          backgroundColor: collapsed? context.colorScheme.secondary:Colors.transparent,
          leading:  CupertinoButton(
            onPressed: () => context.pop(),
            child: Icon(
              CupertinoIcons.clear,
              color: collapsed? context.colorScheme.surface:context.colorScheme.onPrimary,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: context.colorScheme.secondary,
                          width: 1.0,
                        ))
                      ),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 7,sigmaY: 4),
                        child: SizedBox(
                          height: 250,
                          width: context.width,
                          child: ImageFromNetwork(book.coverUrl,boxFit: BoxFit.cover,),
                        ),
                      ),
                    ),

                  ],
                ),
                // Profile image
                Positioned(
                  top: 100.0,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 250,width: 166,
                          child: BookCard(book: book)),
                      SizedBox(
                        width: context.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 12),
                            child: Text(
                              book.title,
                              style: context.textTheme.displayMedium?.copyWith(
                                color: context.colorScheme.onPrimary
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
