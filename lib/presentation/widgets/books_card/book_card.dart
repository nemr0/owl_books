import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/generated/assets.gen.dart';
import '../../../core/typedef/typedefs.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    this.onBookTap,
    this.coverImageUrl,
    this.loading = false,
    this.inverted = true,
  });

  final OnBookTap? onBookTap;
  final String? coverImageUrl;
  final bool loading;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      shade: loading,
      child: Container(
        decoration: ShapeDecoration(
          color:
              (inverted
                      ? context.colorScheme.secondary
                      : context.colorScheme.primary)
                  .withAlpha(50),
          shape: RoundedSuperellipseBorder(
            side: BorderSide(
              color:
                  (inverted
                          ? context.colorScheme.primary
                          : context.colorScheme.secondary)
                      .withAlpha(150),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        child: Skeletonizer(
          enabled: loading,
          child: Builder(
            builder: (context) {
              if (loading) {
                // return const SizedBox();
                return const _CoverSkeleton();
              }
              return CachedNetworkImage(
                imageUrl: coverImageUrl ?? '',
                placeholder: (_, _) => const _CoverSkeleton(),
                errorWidget: (_, __, ___) => const _CoverError(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CoverSkeleton extends StatelessWidget {
  const _CoverSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: context.shimmerEffect,
      child: const Bone.square(),
    );
  }
}

class _CoverError extends StatelessWidget {
  const _CoverError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.shared.noCoverAvailable.provider(),
          fit: BoxFit.contain,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text('No Cover Available', style: context.textTheme.bodyLarge),
        ),
      ),
    );
  }
}
